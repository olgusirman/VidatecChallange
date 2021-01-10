//
//  AppSidebarNavigation.swift
//  Vidatec
//
//  Created by Olgu SIRMAN on 10/01/2021.
//

import SwiftUI

struct AppSidebarNavigation: View {
    
    var body: some View {
        VStack {
            Text("Select a category")
                .foregroundColor(.secondary)
            Text("Select a smoothie")
                .foregroundColor(.secondary)
        }
    }
}

struct AppSidebarNavigation_Previews: PreviewProvider {
    static var previews: some View {
        AppSidebarNavigation()
    }
}
