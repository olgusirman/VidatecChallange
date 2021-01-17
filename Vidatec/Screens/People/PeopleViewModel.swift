//
//  PeopleViewModel.swift
//  Vidatec
//
//  Created by Olgu SIRMAN on 11/01/2021.
//

import SwiftUI
import Combine

protocol PeopleViewModelInputType {
    var searchedPeopleName: String { get set }
}

protocol PeopleViewModelOutputType {
    var peoples: [Person] { get }
    var filteredPeople: [Person] { get }
    var personsDataTask: AnyPublisher<[Person], VidatecService.Error> { get }
    func fetchPeople()
}

protocol PeopleViewModelType: PeopleViewModelInputType, PeopleViewModelOutputType {}

final class PeopleViewModel: ObservableObject, PeopleViewModelType {
    
    @Published var state = State.ready
        
    enum State {
        case ready
        case loading(Cancellable)
        case loaded
        case error(Error)
    }
    
    var personsDataTask: AnyPublisher<[Person], VidatecService.Error> {
        return service.getPeoples()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    // MARK: - PeopleViewModelInputType
    @Published var searchedPeopleName = ""
    
    // MARK: - PeopleViewModelOutputType
    @Published fileprivate(set) var peoples: [Person] = []
    @Published fileprivate(set) var filteredPeople: [Person] = []
    
    /// Fetches 
    func fetchPeople() {
        service.getPeoples()
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .assign(to: \.peoples, on: self)
            .store(in: &subscriptions)
    }
    
    // MARK: - Properties
    
    private var subscriptions = Set<AnyCancellable>()
    private let debounceTime: Double = 0.2
    private let service: VidatecServiceType
    
    // MARK: - Init
    
    init(service: VidatecServiceType = VidatecService()) {
        self.service = service
        bindPeopleSearch()
    }
    
    // MARK: - Helpers
    
    func load() {
        assert(Thread.isMainThread)
        self.state = .loading(self.personsDataTask
                                .sink(
            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    self.state = .error(error)
                    self.peoples = []
                    self.filteredPeople = []
                }
            },
            receiveValue: { value in
                self.state = .loaded
                self.searchedPeopleName = ""
                self.peoples = value
                self.filteredPeople = value
            }
        ))
    }
    
    func loadIfNeeded() {
        assert(Thread.isMainThread)
        guard case .ready = self.state else { return }
        self.load()
    }
    
    private func bindPeopleSearch() {
        
        let searchedName = $searchedPeopleName
            .map({ $0.lowercased() })
            .debounce(for: .seconds(debounceTime), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .map({ $0.trimmingCharacters(in: .whitespacesAndNewlines) })
            //.share() we can use this share operator if we need any binding, this subscribers only once
        
        searchedName
            .compactMap({ [weak self] searchedText in
                return (self?.peoples.filter({ searchedText.isEmpty ? true : self?.searchPerson($0, searchedText) ?? false }) ?? [])
            })
            .assign(to: \.filteredPeople, on: self)
            .store(in: &subscriptions)
    }
    
    private func searchPerson(_ searchedPerson: Person, _ searchedText: String) -> Bool {
        return (searchedPerson.firstName?.lowercased().localizedCaseInsensitiveContains(searchedText)) ?? false || (searchedPerson.lastName?.lowercased().localizedCaseInsensitiveContains(searchedText)) ?? false || (searchedPerson.name.lowercased().localizedCaseInsensitiveContains(searchedText))
    }
}
