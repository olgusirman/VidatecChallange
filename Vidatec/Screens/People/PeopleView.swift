//
//  PeopleView.swift
//  Vidatec
//
//  Created by Olgu SIRMAN on 10/01/2021.
//

import SwiftUI

struct PeopleView: View {
    
    var body: some View {
        PeopleListView(peoples: Person.mockPeople)
            .resignKeyboardOnDragGesture()
            .navigationBarTitle("People")
    }
    
}

struct PeopleView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleView()
    }
}
