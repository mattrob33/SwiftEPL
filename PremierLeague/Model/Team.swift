//
//  TeamEntry.swift
//  PremierLeague
//
//  Created by Matt Robertson on 8/20/21.
//

import Foundation

public struct Team {
    
    var id: Int
    var name: String
    var crest: String

    public init(id: Int, name: String, crest: String) {
        self.id = id
        self.name = name
        self.crest = crest
    }
    
}
