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
