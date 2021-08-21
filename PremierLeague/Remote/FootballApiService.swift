//
//  ApiService.swift
//  PremierLeague
//
//  Created by Matt Robertson on 8/20/21.
//

import Foundation
import UIKit

class FootballApiService {
    
    private let apiKey = "0db9a9e0d3414681ad1638522446d643"
    
    private let baseUrl = "https://api.football-data.org/v2/"

    //
    // Get standings for the given league
    //
    func getStandings(league: String = "PL", result: @escaping ([StandingsEntry]) -> () ) {

        let url = "\(baseUrl)competitions/\(league)/standings"

        makeJsonRequest(urlString: url) { data in
            do {
                let jsonResponse = try JSONDecoder().decode(StandingsResponse.self, from: data)
                result(jsonResponse.table)
            }
            catch let parseError {
                print(parseError)
            }
        }
    }

    //
    // Get all matches for the given team
    //
    func getMatches(forTeam: Int, result: @escaping ([Match]) -> Void ) {

        let url = "\(baseUrl)teams/\(forTeam)/matches"

        makeJsonRequest(urlString: url) { data in
            do {
                let jsonResponse = try JSONDecoder().decode(MatchesResponse.self, from: data)
                result(jsonResponse.matches)
            }
            catch let parseError {
                print(parseError)
            }
        }
    }

    private func makeJsonRequest(urlString: String, result: @escaping (Data) -> () ) {

        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = [
            "X-Auth-Token": apiKey,
            "Content-Type": "application/json"
        ]
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            result(data)
        }

        task.resume()
    }
    
}
