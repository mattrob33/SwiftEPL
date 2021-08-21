//
//  StandingsEntry.swift
//  PremierLeague
//
//  Created by Matt Robertson on 8/20/21.
//

import Foundation

public struct StandingsEntry {
    
    var position: Int
    var team: TeamEntry
    var playedGames: Int
    var won: Int
    var draw: Int
    var lost: Int
    var points: Int
    var goalsFor: Int
    var goalsAgainst: Int
    var goalDifference: Int
    
    public init(position: Int, team: TeamEntry, playedGames: Int, won: Int, draw: Int, lost: Int, points: Int, goalsFor: Int, goalsAgainst: Int, goalDifference: Int) {
        self.position = position
        self.team = team
        self.playedGames = playedGames
        self.won = won
        self.draw = draw
        self.lost = lost
        self.points = points
        self.goalsFor = goalsFor
        self.goalsAgainst = goalsAgainst
        self.goalDifference = goalDifference
    }
    
}
