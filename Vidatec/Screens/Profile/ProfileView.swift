//
//  ProfileView.swift
//  Vidatec
//
//  Created by Olgu SIRMAN on 10/01/2021.
//

import SwiftUI

struct ProfileView: View {
    
    var person: Person
    
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    
    var body: some View {
        #if os(iOS)
        if verticalSizeClass == .compact {
            profileCompact
        } else {
            profileView
        }
        #else
        profileView
        #endif
    }
    
    var profileView: some View {
        ScrollView {
            VStack {
                UserImage(imageUrlString: person.avatar ?? "")
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .aspectRatio(contentMode: .fill)
                    .shadow(color: .gray, radius: 0.5, x: 1, y: 1)
                    .padding()
                VStack (spacing: 20) {
                    Text(person.jobTitle ?? "")
                        .font(.title3)
                    Link(person.email ?? "", destination: URL(string: "mailto:\(person.email ?? "")")!)
                    Circle()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color(hex: person.favouriteColor ?? ""))
                }
                Spacer()
            }.navigationTitle(person.name)
        }
    }
    
    var profileCompact: some View {
        ScrollView {
            HStack {
                Image(systemName: "person")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .clipped()
                    .overlay(Circle()
                                .stroke(lineWidth: 4))
                    .shadow(color: Color.black.opacity(0.25), radius: 10, x: 0, y: 5)
                VStack (alignment: .leading) {
                    Text(person.jobTitle ?? "")
                        .font(.title3)
                    Link(person.email ?? "", destination: URL(string: "mailto:\(person.email ?? "")")!)
                    Circle()
                        .frame(width: 100, height: 100, alignment: .center)
                        .foregroundColor(Color(hex: person.favouriteColor ?? ""))
                }
            }
        }.navigationTitle(person.name)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProfileView(person: Person.mockPeople.first!)
            //                .preferredColorScheme(.light)
            //            ProfileView(person: Person.mockPeople.first!)
            //                .previewDevice("iPhone SE (2nd generation)")
            //                .preferredColorScheme(.dark)
        }
    }
}
