//
//  Utils.swift
//  PremierLeague
//
//  Created by Matt Robertson on 8/21/21.
//

import Foundation

func getCrestImageName(_ url: String) -> String {
    return url.replacingOccurrences(of: "https://crests.football-data.org/", with: "")
                .replacingOccurrences(of: "https://upload.wikimedia.org/wikipedia/en/8/8c/", with: "")
                .replacingOccurrences(of: ".svg", with: "")
}

func getDateString(_ isoDate: String) -> String {
    
    let formatter = ISO8601DateFormatter()
    
//    "2021-08-13T19:00:00Z"
    
    formatter.formatOptions = [.withFullDate, .withFullTime, .withTimeZone]
    
    guard let date = formatter.date(from: isoDate) else { return "no date" }

    let components = Calendar.current.dateComponents([.day, .month, .year], from: date)
    let day = components.day!
    let month = Calendar.current.monthSymbols[components.month! - 1]
    let year = components.year!
    
    return "\(month) \(day), \(year)"
}

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
