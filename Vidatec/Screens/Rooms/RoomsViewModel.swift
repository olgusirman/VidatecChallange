//
//  RoomsViewModel.swift
//  Vidatec
//
//  Created by Olgu SIRMAN on 17/01/2021.
//

import SwiftUI
import Combine
import VidatecServiceManager

protocol RoomsViewModelInputType {}

protocol RoomsViewModelOutputType {
    var rooms: [Room] { get }
    var roomsDataTask: AnyPublisher<[Room], VidatecService.Error> { get }
}

protocol RoomsViewModelType: RoomsViewModelInputType, RoomsViewModelOutputType {}

final class RoomsViewModel: ObservableObject, RoomsViewModelType {
    
    @Published var state = State.ready
        
    enum State {
        case ready
        case loading(Cancellable)
        case loaded
        case error(Error)
    }
    
    var roomsDataTask: AnyPublisher<[Room], VidatecService.Error> {
        return service.getRooms()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    // MARK: - PeopleViewModelOutputType
    @Published fileprivate(set) var rooms: [Room] = []
    
    // MARK: - Properties
    
    private var subscriptions = Set<AnyCancellable>()
    private let debounceTime: Double = 0.2
    private let service: VidatecServiceType
    
    // MARK: - Init
    
    init(service: VidatecServiceType = VidatecService()) {
        self.service = service
    }
    
    // MARK: - Helpers
    
    func load() {
        assert(Thread.isMainThread)
        self.state = .loading(self.roomsDataTask
                                .sink(
            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    self.state = .error(error)
                    self.rooms = []
                }
            },
            receiveValue: { value in
                self.state = .loaded
                self.rooms = value
            }
        ))
    }
    
    func loadIfNeeded() {
        assert(Thread.isMainThread)
        guard case .ready = self.state else { return }
        self.load()
    }
}
