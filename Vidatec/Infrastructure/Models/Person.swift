//
//  Person.swift
//  
//
//  Created by Olgu SIRMAN on 09/01/2021.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let person = try Person(json)

import Foundation

// MARK: - Person
struct Person: Codable, Identifiable {
    var id, createdAt: String?
    var avatar: String?
    var jobTitle, phone, favouriteColor, email: String?
    var firstName, lastName: String?
}

extension Person {
    
    static var persons = [Person(id: UUID().uuidString, createdAt: Date().description, avatar: nil, jobTitle: "IOS Developer", phone: "+44 7858 453702", favouriteColor: "#882753", email: "olgusirman@icloud.com", firstName: "Olgu", lastName: "SIRMAN"),
                          Person(id: UUID().uuidString, createdAt: Date().description, avatar: nil, jobTitle: "Visual Designer", phone: "+44 7858 453702", favouriteColor: "#882753", email: "berkersirman@gmail.com", firstName: "Berker", lastName: "SIRMAN"),
                          Person(id: UUID().uuidString, createdAt: Date().description, avatar: nil, jobTitle: "Orthodontist", phone: "+44 7858 453702", favouriteColor: "#882753", email: "sedef@gmail.com", firstName: "Sedef", lastName: "SIRMAN")]
    
}

// MARK: Person convenience initializers and mutators

extension Person {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Person.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: String?? = nil,
        createdAt: String?? = nil,
        avatar: String?? = nil,
        jobTitle: String?? = nil,
        phone: String?? = nil,
        favouriteColor: String?? = nil,
        email: String?? = nil,
        firstName: String?? = nil,
        lastName: String?? = nil
    ) -> Person {
        return Person(
            id: id ?? self.id,
            createdAt: createdAt ?? self.createdAt,
            avatar: avatar ?? self.avatar,
            jobTitle: jobTitle ?? self.jobTitle,
            phone: phone ?? self.phone,
            favouriteColor: favouriteColor ?? self.favouriteColor,
            email: email ?? self.email,
            firstName: firstName ?? self.firstName,
            lastName: lastName ?? self.lastName
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// JSONSchemaSupport.swift

typealias People = [Person]

extension Array where Element == People.Element {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(People.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
