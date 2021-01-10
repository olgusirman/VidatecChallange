//
//  AppTabNavigation.swift
//  Vidatec
//
//  Created by Olgu SIRMAN on 10/01/2021.
//

import SwiftUI

// MARK: - AppTabNavigation

struct AppTabNavigation: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var selection: Tab = .people
    
    var body: some View {
        TabView(selection: $selection) {
            NavigationView {
                PeopleView()
                    .resignKeyboardOnDragGesture()
                    .navigationBarTitle("People")
            }
            .tabItem {
                peopleTabLabel
            }
            .tag(Tab.people)
            
            NavigationView {
                RoomsView()
                    .environment(\.managedObjectContext, viewContext)
                    .navigationBarTitle("Rooms")
            }
            .tabItem {
                roomsTabLabel
            }
            .tag(Tab.rooms)
        }
    }
    
    var peopleTabLabel: some View {
        var image: String
        
        switch selection {
        case .people:
            image = "person.3.fill"
        default:
            image = "person.3"
        }
        
        return Label("People", systemImage: image)
            .accessibility(label: Text("People"))
    }
    
    var roomsTabLabel: some View {
        
        var image: String
        
        switch selection {
        case .rooms:
            image = "house.circle.fill"
        default:
            image = "house.circle"
        }
        
        return Label("Rooms", systemImage: image)
            .accessibility(label: Text("Rooms"))
    }
    
}

// MARK: - Tab

extension AppTabNavigation {
    enum Tab {
        case people
        case rooms
    }
}

// MARK: - Previews

struct AppTabNavigation_Previews: PreviewProvider {
    static var previews: some View {
        AppTabNavigation()
    }
}
