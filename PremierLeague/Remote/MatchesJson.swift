import Foundation
import UIKit

fileprivate struct RawServerMatchesResponse: Decodable {
    struct RawMatch: Decodable {
        var id: Int
        var utcDate: String
        var matchday: Int

        var score: RawScore

        var homeTeam: RawTeam
        var awayTeam: RawTeam
        
        enum CodingKeys: String, CodingKey {
            case id, utcDate, matchday, score, homeTeam, awayTeam
        }
    }

    struct RawScore: Decodable {
        var winner: String
        var score: RawScoreFullTime
    }
    
    struct RawScoreFullTime: Decodable {
        var homeTeam: Int
        var awayTeam: Int
    }
    
    struct RawTeam: Decodable {
        var id: Int
        var name: String
    }

    var matches: [RawMatch]
    
    enum CodingKeys: String, CodingKey {
        case matches
    }
    
}

public struct MatchesResponse: Decodable {
    
    var matches: [Match] = []
    
    public init(from decoder: Decoder) throws {
        let rawResponse = try RawServerMatchesResponse(from: decoder)

        for match in rawResponse.matches {
            matches.append(
                Match(
                    id: match.id,
                    date: match.utcDate,
                    matchday: match.matchday,
                    winner: getMatchTeam(match.score.winner),
                    homeScore: match.score.score.homeTeam,
                    awayScore: match.score.score.awayTeam,
                    homeTeam: Team(id: match.homeTeam.id, name: match.homeTeam.name, crest: "\(match.homeTeam.id)"),
                    awayTeam: Team(id: match.awayTeam.id, name: match.awayTeam.name, crest: "\(match.awayTeam.id)")
                )
            )
        }
    }
}

private func getMatchTeam(_ raw: String) -> MatchTeam {
    switch raw {
        case "HOME_TEAM":
            return MatchTeam.home
        default:
            return MatchTeam.away
    }
}
