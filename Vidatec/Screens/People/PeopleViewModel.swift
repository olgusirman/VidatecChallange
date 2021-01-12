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
    func fetchPeople()
}

protocol PeopleViewModelType: PeopleViewModelInputType, PeopleViewModelOutputType {}

final class PeopleViewModel: ObservableObject, PeopleViewModelType {
    
    // MARK: - PeopleViewModelInputType
    @Published var searchedPeopleName = ""
    
    // MARK: - PeopleViewModelOutputType
    @Published fileprivate(set) var peoples: [Person] = []
    @Published fileprivate(set) var filteredPeople: [Person] = []
    
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
    
    private func bindPeopleSearch() {
        
        let searchedName = $searchedPeopleName
            .map({ $0.lowercased() })
            .debounce(for: .seconds(debounceTime), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .map({ $0.trimmingCharacters(in: .whitespacesAndNewlines) })
            .share()
        
        //you can  use this searchName if you need any other binding
        searchedName
            .compactMap({ [weak self] searchtedText in
                return (self?.peoples.filter({ searchtedText.isEmpty ? true : ($0.firstName?.lowercased().localizedCaseInsensitiveContains(searchtedText)) ?? false || ($0.lastName?.lowercased().localizedCaseInsensitiveContains(searchtedText)) ?? false }) ?? [])
            })
            .assign(to: \.filteredPeople, on: self)
            .store(in: &subscriptions)
    }
}
