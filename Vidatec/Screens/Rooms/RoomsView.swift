//
//  RoomsView.swift
//  Vidatec
//
//  Created by Olgu SIRMAN on 10/01/2021.
//

import SwiftUI
import CoreData

struct RoomsView: View {
    
    @StateObject var viewModel = RoomsViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.rooms) { item in
                RoomRow(item: item)
            }
        }.toolbar {
            ToolbarItem(placement: .principal) {
                Image(systemName: "house")
                    .font(.title)
            }
        }
        .overlay(RoomsStatusOverlay(viewModel: viewModel))
        .onAppear {
            viewModel.loadIfNeeded()
        }
    }
}

struct RoomsStatusOverlay: View {
    
    @ObservedObject var viewModel: RoomsViewModel
    
    var body: some View {
        
        switch viewModel.state {
        case .ready:
            return AnyView(EmptyView())
        case .loading:
            return AnyView(ProgressView("Loading...")
                            .padding()
                            .background(Blur())
                            .cornerRadius(14))
        case .loaded:
            return AnyView(EmptyView())
        case let .error(error):
            return AnyView(
                VStack {
                    Text(error.localizedDescription)
                        .frame(maxWidth: 300)
                    Button("Retry") {
                        self.viewModel.load() // TODO: Use throttle operator for this button
                    }
                }
                .padding()
                .background(Blur())
                .cornerRadius(14)
            )
        }
    }
}

struct RoomsView_Previews: PreviewProvider {
    
    static var roomPreview: some View {
        List {
            ForEach(Room.mockRooms) { item in
                RoomRow(item: item)
            }
        }.toolbar {
            ToolbarItem(placement: .principal) {
                Image(systemName: "house")
                    .font(.title)
            }
        }
    }
    
    static var previews: some View {
        roomPreview
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
