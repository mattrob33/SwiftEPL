//
//  TeamEntry.swift
//  PremierLeague
//
//  Created by Matt Robertson on 8/20/21.
//

import Foundation

public struct TeamEntry {
    
    var id: Int
    var name: String
    var crestUrl: String

    public init(id: Int, name: String, crestUrl: String) {
        self.id = id
        self.name = name
        self.crestUrl = crestUrl
    }
    
}
