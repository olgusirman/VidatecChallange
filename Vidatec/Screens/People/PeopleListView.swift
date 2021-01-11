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
    
    var filteredPersons: [Person] {
        peoples.filter({ searchText.isEmpty ? true : $0.firstName!.contains(searchText) })
    }
    
    var body: some View {
        List(selection: $selection) {
            ForEach(peoples) { person in
                NavigationLink(
                    destination: ProfileView(person: person),
                    tag: person,
                    selection: $selection
                ) {
                    //SmoothieRow(smoothie: smoothie)
                    Text(person.name)
                }
                .tag(person)
                //.onReceive(model.$selectedSmoothieID) { newValue in
                //    guard let smoothieID = newValue, let smoothie = Smoothie(for: smoothieID) else { return }
                //    selection = smoothie
                //}
            }
        }
        
        ScrollView {
            LazyVStack (alignment: .leading) {
                SearchBar(text: $searchText)
                
                if filteredPersons.count == 0 {
                    Text("We couldn't find \(searchText) in here. :]")
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

struct PeopleListView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleListView(peoples: Person.mockPeople)
    }
}
