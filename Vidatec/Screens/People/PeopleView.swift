//
//  PeopleView.swift
//  Vidatec
//
//  Created by Olgu SIRMAN on 10/01/2021.
//

import SwiftUI

struct PeopleView: View {
    
    @StateObject var viewModel = PeopleViewModel()
    
    var body: some View {
        PeopleListView(
            searchPeopleText: $viewModel.searchedPeopleName,
            peoples: viewModel.peoples)
            .resignKeyboardOnDragGesture()
            .navigationTitle("People").onAppear(perform: {
                viewModel.fetchPeople()
            })
    }
    
}

struct PeopleView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleView()
    }
}
