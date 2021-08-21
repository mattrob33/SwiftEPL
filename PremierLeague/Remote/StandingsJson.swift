import Foundation
import UIKit

fileprivate struct RawServerStandingsResponse: Decodable {
    struct Standings: Decodable {
        var table: [TableEntry]
        
        enum CodingKeys: String, CodingKey {
            case table
        }
    }
    
    struct TableEntry: Decodable {
        var position: Int
        var team: Team
        var playedGames: Int
        var won: Int
        var draw: Int
        var lost: Int
        var points: Int
        var goalsFor: Int
        var goalsAgainst: Int
        var goalDifference: Int
        
        enum CodingKeys: String, CodingKey {
            case position, team, playedGames, won, draw, lost, points, goalsFor, goalsAgainst, goalDifference
        }
    }
    
    struct Team: Decodable {
        var id: Int
        var name: String
        var crestUrl: String
    }
    
    var standings: [Standings]
    
    enum CodingKeys: String, CodingKey {
        case standings
    }
    
}

public struct StandingsResponse: Decodable {
    
    var table: [StandingsEntry] = []
    
    public init(from decoder: Decoder) throws {
        let rawResponse = try RawServerStandingsResponse(from: decoder)

        let teams = rawResponse.standings.first!.table
        
        for entry in teams {
            table.append(
                StandingsEntry(
                    position: entry.position,
                    team: TeamEntry(
                        id: entry.team.id,
                        name: entry.team.name,
                        crestUrl: entry.team.crestUrl
                    ),
                    playedGames: entry.playedGames,
                    won: entry.won,
                    draw: entry.draw,
                    lost: entry.lost,
                    points: entry.points,
                    goalsFor: entry.goalsFor,
                    goalsAgainst: entry.goalsAgainst,
                    goalDifference: entry.goalDifference
                )
            )
        }
    }
}
