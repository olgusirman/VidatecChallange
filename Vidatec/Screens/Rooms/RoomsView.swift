//
//  RoomsView.swift
//  Vidatec
//
//  Created by Olgu SIRMAN on 10/01/2021.
//

import SwiftUI
import CoreData

struct RoomsView: View {
    
    var rooms: [Room] = Room.mockRooms
    
    var body: some View {
        List {
            ForEach(rooms) { item in
                RoomRow(item: item)
            }
        }.toolbar {
            ToolbarItem(placement: .principal) {
                Image(systemName: "house")
                    .font(.title)
            }
        }
    }
}

struct RoomsView_Previews: PreviewProvider {
    static var previews: some View {
        RoomsView()
    }
}

struct RoomRow: View {
    
    var item: Room
    
    var body: some View {
        HStack {
            Text(item.name ?? "")
            if item.isOccupied ?? false {
                Spacer()
                Image(systemName:"checkmark")
            }
        }
        .font(.title2)
    }
}
