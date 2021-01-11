//
//  RoomsView.swift
//  Vidatec
//
//  Created by Olgu SIRMAN on 10/01/2021.
//

import SwiftUI
import CoreData

struct RoomsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        List {
            ForEach(Room.mockRooms) { item in
                Text(item.name ?? "")
            }
        }
    }
}

struct RoomsView_Previews: PreviewProvider {
    static var previews: some View {
        RoomsView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
