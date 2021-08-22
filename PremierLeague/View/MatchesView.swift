//
//  MatchesView.swift
//  PremierLeague
//
//  Created by Matt Robertson on 8/21/21.
//

import Foundation
import SwiftUI

struct MatchesView: View {
    
    @State var matches: [Match] = []
    
    var body: some View {
        VStack {
            List(matches, id: \.id) { match in
                MatchView(match: match)
            }.onAppear(perform: loadData)
        }
    }

    func loadData() {
        FootballApiService().getMatches(forTeam: 57) { matchesResponse in
            self.matches = matchesResponse
        }
    }
}

struct MatchView: View {
    
    var match: Match
    
    var body: some View {
        VStack(alignment: .center) {
            DateView(date: match.date)
            
            HStack {
                
                Spacer()
                
                VStack {
                    CrestView(crest: match.homeTeam.crest)
                    Text("\(match.homeScore)").font(.system(size: 36)).padding()
                }
                
                Spacer()
                
                VStack {
                    Spacer()
                    Text("vs").font(.system(size: 24)).padding()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                }
                
                Spacer()
                
                VStack {
                    CrestView(crest: match.awayTeam.crest)
                    Text("\(match.awayScore)").font(.system(size: 36)).padding()
                }
                
                Spacer()
            }.frame(maxWidth: .infinity)
        }
    }
}

fileprivate struct DateView: View {
    var date: String
    
    var body: some View {
        Text(getDateString(date))
            .font(.system(size: 24))
            .bold()
            .padding()
    }
}

fileprivate struct CrestView: View {
    var crest: String
    
    var body: some View {
        Image(crest)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100)
    }
}


struct MatchesView_Previews: PreviewProvider {
    static var previews: some View {
        MatchesView(
            matches: [
                Match(id: 1, date: "2021-08-13T19:00:00Z", matchday: 1, winner: MatchTeam.home, homeScore: 2, awayScore: 0, homeTeam: Team(id: 402, name: "Brentford", crest: "402"), awayTeam: Team(id: 57, name: "Arsenal", crest: "57"))
            ]
        )
    }
}
