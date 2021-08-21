//
//  ContentView.swift
//  PremierLeague
//
//  Created by Matt Robertson on 8/20/21.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @State var standings: [StandingsEntry] = []

    var body: some View {
        NavigationView {
            List(standings, id: \.position) { entry in
                StandingsRow(entry: entry)
            }
            .navigationTitle("Standings")
            .onAppear(perform: loadData)
        }
    }

    func loadData() {
        FootballApiService().getStandings() { standingsResponse in
            standings = standingsResponse
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            standings: [
                StandingsEntry(
                    position: 1, team: TeamEntry(id: 1, name: "Manchester United FC", crestUrl: ""), playedGames: 1, won: 1, draw: 0, lost: 0, points: 3, goalsFor: 5, goalsAgainst: 0, goalDifference: 5
                ),
                StandingsEntry(
                    position: 2, team: TeamEntry(id: 2, name: "Arsenal FC", crestUrl: ""), playedGames: 1, won: 1, draw: 0, lost: 0, points: 3, goalsFor: 5, goalsAgainst: 0, goalDifference: 5
                ),
                StandingsEntry(
                    position: 3, team: TeamEntry(id: 2, name: "Chelsea FC", crestUrl: ""), playedGames: 1, won: 1, draw: 0, lost: 0, points: 3, goalsFor: 5, goalsAgainst: 0, goalDifference: 5
                )
            ]
        )
    }
}
