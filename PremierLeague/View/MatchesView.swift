//
//  MatchesView.swift
//  PremierLeague
//
//  Created by Matt Robertson on 8/21/21.
//

import Foundation
import SwiftUI

struct MatchesView: View {

    @State var team: Team
    @State var matches: [Match] = []
    
    @State private var isLoading: Bool = true

    var body: some View {
        ZStack {
            List(matches, id: \.id) { match in
                MatchView(match: match).padding(.bottom, 16)
            }
            .onAppear(perform: loadData)
            .navigationTitle("\(team.name)")
            
            if isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
                    
            }
        }
    }

    func loadData() {
        FootballApiService().getMatches(forTeam: team.id) { matchesResponse in
            isLoading = false
            self.matches = matchesResponse
        }
    }
}

struct MatchView: View {
    
    var match: Match
    
    var body: some View {
        VStack(alignment: .center) {
            HeaderView(match: match)
            MatchScoreView(match: match)
        }
    }
}

fileprivate struct HeaderView: View {
    var match: Match
    
    var body: some View {
        VStack(alignment: .center) {
            DateView(date: match.date)
            Text("(Matchday \(match.matchday))").font(.system(size: 16))
        }.padding()
    }
}

fileprivate struct MatchScoreView: View {
    
    var match: Match
    
    var body: some View {
        HStack {
            Spacer()
            TeamScoreView(team: match.awayTeam, score: match.awayScore, isCompleted: match.status == MatchStatus.completed)
            Spacer()
            VersusView()
            Spacer()
            TeamScoreView(team: match.homeTeam, score: match.homeScore, isCompleted: match.status == MatchStatus.completed)
            Spacer()
        }.frame(maxWidth: .infinity)
    }
}

fileprivate struct DateView: View {
    var date: String
    
    var body: some View {
        Text(getDateString(date))
            .font(.system(size: 20))
            .bold()
    }
}


fileprivate struct TeamScoreView: View {
    var team: Team
    var score: Int
    var isCompleted: Bool
    
    var body: some View {
        VStack {
            CrestView(crest: team.crest)
            Text("\(team.name)").font(.system(size: 16)).padding(2)
            if isCompleted {
                Text("\(score)").font(.system(size: 28)).padding(.top, 2)
            }
        }
    }
}


fileprivate struct CrestView: View {
    var crest: String
    
    var body: some View {
        Image(crest)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 64, height: 64)
    }
}


fileprivate struct VersusView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("vs").font(.system(size: 20)).padding()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
        }
    }
}

struct MatchesView_Previews: PreviewProvider {
    static var previews: some View {
        MatchesView(
            team: Team(
                id: 57,
                name: "Arsenal FC",
                crest: "57"
            ),
            matches: [
                Match(id: 1, status: MatchStatus.completed, date: "2021-08-13T19:00:00Z", matchday: 1, winner: MatchTeam.home, homeScore: 2, awayScore: 0, homeTeam: Team(id: 402, name: "Brentford", crest: "402"), awayTeam: Team(id: 57, name: "Arsenal", crest: "57"))
            ]
        )
    }
}
