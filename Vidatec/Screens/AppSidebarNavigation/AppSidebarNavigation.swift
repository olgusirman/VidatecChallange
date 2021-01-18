//
//  AppSidebarNavigation.swift
//  Vidatec
//
//  Created by Olgu SIRMAN on 10/01/2021.
//

import SwiftUI

struct AppSidebarNavigation: View {
    
    @State private var selection: NavigationItem? = .people
    
    enum NavigationItem {
        case people
        case rooms
    }
    
    var sidebar: some View {
        List(selection: $selection) {
            NavigationLink(destination: PeopleView(), tag: NavigationItem.people, selection: $selection) {
                Label("People", systemImage: "list.bullet")
            }
            .tag(NavigationItem.people)
            
            NavigationLink(destination: RoomsView(), tag: NavigationItem.rooms, selection: $selection) {
                Label("Rooms", systemImage: "heart")
            }
            .tag(NavigationItem.rooms)
        }
        .listStyle(SidebarListStyle())
    }
    
    var body: some View {
        NavigationView {
            sidebar
        }
    }
    
}

extension AppSidebarNavigation {
    enum Tab {
        case people
        case rooms
    }
}


struct AppSidebarNavigation_Previews: PreviewProvider {
    static var previews: some View {
        AppSidebarNavigation()
    }
}
