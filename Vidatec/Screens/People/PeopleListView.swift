//
//  PeopleListView.swift
//  Vidatec
//
//  Created by Olgu SIRMAN on 10/01/2021.
//

import SwiftUI

struct PeopleListView: View {
    
    var peoples: [Person]
    
    @State private var searchText = ""
    @State private var selection: Person?
    
    var searchTextTrimeed: String {
        searchText.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var filteredPersons: [Person] {
        peoples.filter({ searchTextTrimeed.isEmpty ? true : ($0.firstName?.contains(searchTextTrimeed) ?? false ||  ($0.lastName?.contains(searchTextTrimeed)) ?? false ) })
    }
    
    var body: some View {
        ScrollView {
            LazyVStack (alignment: .leading) {
                SearchBar(text: $searchText)
                
                if filteredPersons.count == 0 {
                    Text("We couldn't find \(searchText) in here. :]")
                } else {
                    ForEach(filteredPersons) { person in
                        NavigationLink(
                            destination: ProfileView(person: person),
                            tag: person,
                            selection: $selection
                        ) {
                            PersonRow(person: person)
                                .foregroundColor(.primary)
                        }
                        .tag(person)
                    }
                }
                
            }
            .padding([.horizontal])
        }
    }
}

struct PeopleListView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach([ColorScheme.light, .dark], id: \.self) { scheme in
            NavigationView {
                PeopleListView(peoples: Person.mockPeople)
                    .navigationTitle("Smoothies")
            }
            .preferredColorScheme(scheme)
        }
    }
}
