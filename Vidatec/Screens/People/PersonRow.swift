//
//  PersonRow.swift
//  Vidatec
//
//  Created by Olgu SIRMAN on 11/01/2021.
//

import SwiftUI

struct PersonRow: View {
    var person: Person
    
    var body: some View {
        HStack {
            Image(systemName: "person")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .clipped()
                .overlay(Circle()
                            .stroke(lineWidth: 2))
                .shadow(color: Color.black.opacity(0.25), radius: 10, x: 0, y: 5)
                .padding()
                .accessibility(hidden: true)

            VStack(alignment: .leading) {
                Text(person.name)
                    .font(.headline)
                    .lineLimit(1)
                
                Text(person.jobTitle ?? "")
                    .foregroundColor(.secondary)
                    .accessibility(label: Text("jobTitle"))
            }
            Spacer(minLength: 0)
        }
        .font(.subheadline)
        .accessibilityElement(children: .combine)
    }
}

struct PersonRow_Previews: PreviewProvider {
    static var previews: some View {
        PersonRow(person: Person.mockPeople.first!)
    }
}
