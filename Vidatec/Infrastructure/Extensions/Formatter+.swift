//
//  Formatter+.swift
//  Vidatec
//
//  Created by Olgu SIRMAN on 10/01/2021.
//

import Foundation

let longFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE, MMM d, h:mm a"
    return formatter
}()

let taskFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE, HH:mm"
    return formatter
}()

let taskAlertFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    return formatter
}()
