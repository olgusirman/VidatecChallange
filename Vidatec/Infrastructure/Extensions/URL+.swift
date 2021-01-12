//
//  URL+.swift
//  Vidatec
//
//  Created by Olgu SIRMAN on 12/01/2021.
//

import Foundation

extension URL {
    init(staticString string: StaticString) {
        guard let url = URL(string: "\(string)") else {
            preconditionFailure("Invalid static URL string: \(string)")
        }

        self = url
    }
}
