//
//  StandingsEntry.swift
//  PremierLeague
//
//  Created by Matt Robertson on 8/20/21.
//

import Foundation

struct Match {
    
    var id: Int
    var date: String
    var matchday: Int
    
    var homeTeam: Team
    var awayTeam: Team

    var winner: MatchTeam
    var homeScore: Int
    var awayScore: Int
    
    init(id: Int, date: String, matchday: Int, winner: MatchTeam, homeScore: Int, awayScore: Int, homeTeam: Team, awayTeam: Team) {
        self.id = id
        self.date = date
        self.matchday = matchday
        self.winner = winner
        self.homeScore = homeScore
        self.awayScore = awayScore
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
    }
    
}
