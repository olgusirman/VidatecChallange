//
//  PeopleView.swift
//  Vidatec
//
//  Created by Olgu SIRMAN on 10/01/2021.
//

import SwiftUI
import VidatecServiceManager

struct PeopleView: View {
    
    @StateObject var viewModel = PeopleViewModel()
    
    var body: some View {
        PeopleListView(
            searchPeopleText: $viewModel.searchedPeopleName,
            peoples: viewModel.filteredPeople)
            .resignKeyboardOnDragGesture()
            .navigationTitle("People")
            .navigationBarItems(trailing: trailingBarRefreshButton)
            .overlay(PeopleStatusOverlay(viewModel: viewModel))
            .onAppear(perform: {
                viewModel.loadIfNeeded()
            })
    }
    
    private var trailingBarRefreshButton: some View {
        Button(action: {
            viewModel.load()
        }) {
            Image(systemName: "arrow.clockwise")
        }
    }
    
}

struct PeopleStatusOverlay: View {
    
    @ObservedObject var viewModel: PeopleViewModel
    
    var body: some View {
        
        switch viewModel.state {
        case .ready:
            return AnyView(EmptyView())
        case .loading:
            return AnyView(ProgressView("Loading...")
                            .padding()
                            .background(Blur())
                            .cornerRadius(14))
        case .loaded:
            return AnyView(EmptyView())
        case let .error(error):
            return AnyView(
                VStack {
                    Text(error.localizedDescription)
                        .frame(maxWidth: 300)
                    Button("Retry") {
                        self.viewModel.load() // TODO: Use throttle operator for this button
                    }
                }
                .padding()
                .background(Blur())
                .cornerRadius(14)
            )
        }
    }
}

struct PeopleView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleView()
    }
}
