//
//  ApiService.swift
//  PremierLeague
//
//  Created by Matt Robertson on 8/20/21.
//

import Foundation
import UIKit

class ApiService {
    
    let apiKey = "0db9a9e0d3414681ad1638522446d643"
    
    func getStandings(league: String = "PL", result: @escaping ([StandingsEntry]) -> Void ) {
        let urlString = "https://api.football-data.org/v2/competitions/\(league)/standings"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = [
            "X-Auth-Token": apiKey,
            "Content-Type": "application/json"
        ]
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("Invalid server data")
                return
            }
            
            do {
                let standings = try JSONDecoder().decode(StandingsResponse.self, from: data)
                result(standings.table)
            }
            catch let parseError {
                print(parseError)
            }
        }.resume()
    }
    
}
