//
//  PeopleViewModel.swift
//  Vidatec
//
//  Created by Olgu SIRMAN on 11/01/2021.
//

import SwiftUI
import Combine

final class PeopleViewModel: ObservableObject {
    
    @Published var isSearching = false
    @Published var searchedPeopleName = ""
    @Published var repositories: [Person] = [] {
        didSet {
            isSearching = false
        }
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
            .map({ [weak self] (text) -> String in
                //self?.cleanPage()
                return text
            })
        
        
        //            .map({ [weak self] text in
        //                if text.isEmpty {
        //                    self?.isSearching = false
        //                } else {
        //                    self?.isSearching = true
        //                }
        //                return text
        //            })
        //            .compactMap({ [weak self] in GetRepositoriesRequestModel(query: $0, page: self?.pageCount ?? 1, sort: self?.sortType ?? .stars) })
        //            .flatMap({ [unowned self] in self.fetchRepositories(request: $0) })
        //            .replaceError(with: [])
        //            .receive(on: DispatchQueue.main)
        //            .assign(to: \.repositories, on: self)
        //            .store(in: &subscriptions)
        
    }
    
//    private func fetchPeople() -> AnyPublisher<[People], Never> {
        
//        service.getRepositories()
//            .map({ $0.items })
//            .replaceError(with: [])
//            .eraseToAnyPublisher()
//    }
    
}
