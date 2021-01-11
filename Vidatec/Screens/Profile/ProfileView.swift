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
        ZStack {
            ZStack {
            //    LinearGradient(gradient: Gradient(colors: [Color(hex: person.favouriteColor ?? ""), .white]), startPoint: UnitPoint(x: 0.5, y: 0.95), endPoint: UnitPoint(x: 0.2, y: 0.2))
            }
            .edgesIgnoringSafeArea(.all)

            VStack {
                Image(systemName: "person")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .clipped()
                    .overlay(Circle()
                                .stroke(lineWidth: 4))
                    .shadow(color: Color.black.opacity(0.25), radius: 10, x: 0, y: 5)
                    .padding()
                
                VStack {
                    Text(person.jobTitle ?? "")
                        .font(.title3)
                    Link(person.email ?? "", destination: URL(string: "mailto:\(person.email ?? "")")!)
                    Circle()
                        .frame(width: 100, height: 100, alignment: .center)
                        .foregroundColor(Color(hex: person.favouriteColor ?? ""))
                }
                Spacer()
            }
        }
    }
    
    var profileCompact: some View {
        ZStack {
            
            ZStack {
            //    LinearGradient(gradient: Gradient(colors: [Color(hex: person.favouriteColor ?? ""), .white]), startPoint: UnitPoint(x: 0.5, y: 0.95), endPoint: UnitPoint(x: 0.2, y: 0.2))
            }
            .edgesIgnoringSafeArea(.all)
            
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
                    .padding(.top, 100)
                
                VStack (alignment: .leading) {
                    Text(person.jobTitle ?? "")
                        .font(.title3)
                    Link(person.email ?? "", destination: URL(string: "mailto:\(person.email ?? "")")!)
                    Circle()
                        .frame(width: 100, height: 100, alignment: .center)
                        .foregroundColor(Color(hex: person.favouriteColor ?? ""))
                }
            }
        }
        //.background(LinearGradient(gradient: Gradient(colors: [Color(hex: person.favouriteColor ?? ""), .primary]), startPoint: UnitPoint(x: 0.5, y: 0.95), endPoint: UnitPoint(x: 0.2, y: 0.2)))
//        .edgesIgnoringSafeArea(.all)
    }
    
}

struct ProfileHeaderButton: View {
    
    var person: Person
    
    @Environment(\.colorScheme) private var colorScheme
    
    var minWidth: CGFloat {
        #if os(iOS)
        return 80
        #else
        return 60
        #endif
    }
    
    var bar: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(person.name)
                    .font(.headline)
                    .bold()
                Text(person.jobTitle ?? "")
                    .foregroundColor(.secondary)
                    .font(.subheadline)
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .accessibilityElement(children: .combine)
    }
    
    var shape: RoundedRectangle {
        #if os(iOS)
        return RoundedRectangle(cornerRadius: 16, style: .continuous)
        #else
        return RoundedRectangle(cornerRadius: 10, style: .continuous)
        #endif
    }
    
    var body: some View {
        #if os(iOS)
        ZStack(alignment: .bottom) {
            Image(systemName: "person")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .accessibility(hidden: true)
            bar.background(VisualEffectBlur())
        }
        .clipShape(shape)
        .shadow(color: Color.black.opacity(0.25), radius: 10, x: 0, y: 5)
        .padding()
        .accessibilityElement(children: .contain)
        #else
        VStack(spacing: 0) {
            Image(systemName: "person")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 100)
                .clipped()
                .overlay(Divider().padding(.horizontal, 1), alignment: .bottom)
                .accessibility(hidden: true)
            bar.background(Rectangle().fill(BackgroundStyle()))
        }
        .clipShape(shape)
        .overlay(shape.inset(by: 0.5).stroke(Color.primary.opacity(0.1), lineWidth: 1))
        .padding(10)
        .accessibilityElement(children: .contain)
        #endif
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
//            ProfileView(person: Person.mockPeople.first!)
//                .preferredColorScheme(.light)
            ProfileView(person: Person.mockPeople.first!)
                .previewDevice("iPhone SE (2nd generation)")
                .preferredColorScheme(.dark)
        }
    }
}
