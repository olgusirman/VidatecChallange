//
//  PeopleListView.swift
//  Vidatec
//
//  Created by Olgu SIRMAN on 10/01/2021.
//

import SwiftUI

struct PeopleListView: View {
    
    @Binding var searchPeopleText: String
    var peoples: [Person]
    
    @State private var selection: Person?
    
    var body: some View {
        ScrollView {
            LazyVStack (alignment: .leading) {
                SearchBar(text: $searchPeopleText)
                    .accessibility(hint: Text("People search \(searchPeopleText)"))
                
                if peoples.count == 0 {
                    Text("We couldn't find \(searchPeopleText) in here. :]")
                        .accessibility(hint: Text("We couldn't find \(searchPeopleText) in here. :]"))
                } else {
                    ForEach(peoples) { person in
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
                PeopleListView(searchPeopleText: .constant("Jon"),
                               peoples: Person.mockPeople)
                    .navigationTitle("People")
            }
            .preferredColorScheme(scheme)
        }
    }
}
