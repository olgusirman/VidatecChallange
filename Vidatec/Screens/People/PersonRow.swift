//
//  PersonRow.swift
//  Vidatec
//
//  Created by Olgu SIRMAN on 11/01/2021.
//

import SwiftUI
import VidatecServiceManager

public struct PersonRow: View {
    var person: Person
    
    public var body: some View {
        HStack {
            UserImage(imageUrlString: person.avatar ?? "")
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .aspectRatio(contentMode: .fill)
                .shadow(color: .gray, radius: 0.5, x: 1, y: 1)
                .accessibility(hint: Text("User Image"))

        
            VStack(alignment: .leading) {
                Text(person.name)
                    .font(.headline)
                    .lineLimit(1)
                    .accessibility(hint: Text("Person name"))
                
                Text(person.jobTitle ?? "")
                    .foregroundColor(.secondary)
                    .accessibility(label: Text("Job Title"))
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
