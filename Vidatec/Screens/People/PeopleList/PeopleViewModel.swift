//
//  PeopleViewModel.swift
//  Vidatec
//
//  Created by Olgu SIRMAN on 11/01/2021.
//

import SwiftUI
import Combine

final class PeopleViewModel: ObservableObject {
    
    @Published var searchedPeopleName = ""
    @Published var peoples: [Person] = []
    
    var searchTextTrimeed: String {
        searchedPeopleName.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var filteredPeople: [Person] {
        peoples.filter({ searchTextTrimeed.isEmpty ? true : ($0.firstName?.contains(searchTextTrimeed) ?? false ||  ($0.lastName?.contains(searchTextTrimeed)) ?? false ) })
    }
    
    private var subscriptions = Set<AnyCancellable>()
    private let debounceTime: Double = 0.4
    private let service: VidatecServiceType
    
    init(service: VidatecServiceType = VidatecService()) {
        self.service = service
        bindPeopleSearch()
    }
    
    private func bindPeopleSearch() {
        
        $searchedPeopleName
            .map({ $0.localizedLowercase })
            .debounce(for: .seconds(debounceTime), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .filter { !$0.isEmpty }
            .map({ $0.trimmingCharacters(in: .whitespacesAndNewlines) })
            .map({ [weak self] searchtedText in
                return (self?.peoples.filter({ searchtedText.isEmpty ? true : ($0.firstName?.contains(searchtedText) ?? false ||  ($0.lastName?.contains(searchtedText)) ?? false ) }) ?? [])
            })
            .assign(to: \.peoples, on: self)
            .store(in: &subscriptions)
    
    }
    
    func fetchPeople() {
        service.getPeoples()
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .print()
            .assign(to: \.peoples, on: self)
            .store(in: &subscriptions)
    }
    
}
