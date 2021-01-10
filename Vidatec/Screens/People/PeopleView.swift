//
//  PeopleView.swift
//  Vidatec
//
//  Created by Olgu SIRMAN on 10/01/2021.
//

import SwiftUI

struct PeopleView: View {
    
    private var peoples = Person.persons
    
    @State private var searchText = ""
    
    var filteredPersons: [Person] {
        peoples.filter({ searchText.isEmpty ? true : $0.firstName!.contains(searchText) })
    }
    
    var body: some View {
        ScrollView {
            LazyVStack (alignment: .leading) {
                SearchBar(text: $searchText)
                
                if filteredPersons.count == 0 {
                    Text("Sorry, No results")
                } else {
                    ForEach(filteredPersons) { item in
                        Text(item.firstName ?? "")
                        Divider()
                    }
                }
                
            }.padding([.horizontal])
        }
    }
    
}

struct PeopleView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleView()
    }
}
