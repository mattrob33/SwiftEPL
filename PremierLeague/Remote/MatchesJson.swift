import Foundation
import UIKit

fileprivate struct RawServerMatchesResponse: Decodable {
    struct RawMatch: Decodable {
        var id: Int
        var utcDate: String
        var status: String
        var matchday: Int

        var score: RawScore

        var homeTeam: RawTeam
        var awayTeam: RawTeam
        
        enum CodingKeys: String, CodingKey {
            case id, utcDate, status, matchday, score, homeTeam, awayTeam
        }
    }

    struct RawScore: Decodable {
        var winner: String?
        var fullTime: RawScoreFullTime
    }
    
    struct RawScoreFullTime: Decodable {
        var homeTeam: Int?
        var awayTeam: Int?
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
                    status: mapMatchStatus(match.status),
                    date: match.utcDate,
                    matchday: match.matchday,
                    winner: mapMatchTeam(match.score.winner),
                    homeScore: match.score.fullTime.homeTeam ?? 0,
                    awayScore: match.score.fullTime.awayTeam ?? 0,
                    homeTeam: Team(
                        id: match.homeTeam.id,
                        name: match.homeTeam.name,
                        crest: mapTeamCrest(teamId: match.homeTeam.id)
                    ),
                    awayTeam: Team(
                        id: match.awayTeam.id,
                        name: match.awayTeam.name,
                        crest: mapTeamCrest(teamId: match.awayTeam.id)
                    )
                )
            )
        }
    }
}

private func mapMatchTeam(_ raw: String?) -> MatchTeam? {
    guard let raw = raw else { return nil }

    switch raw {
        case "HOME_TEAM":
            return MatchTeam.home
        default:
            return MatchTeam.away
    }
}


private func mapMatchStatus(_ raw: String) -> MatchStatus {
    switch raw {
        case "FINISHED":
            return MatchStatus.completed
        default:
            return MatchStatus.scheduled
    }
}
