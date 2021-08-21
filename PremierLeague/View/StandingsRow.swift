//
//  StandingsRow.swift
//  PremierLeague
//
//  Created by Matt Robertson on 8/20/21.
//

import Foundation
import SwiftUI

struct StandingsRow: View {
    
    var entry: StandingsEntry
    
    var body: some View {
        HStack {
            LeaguePositionText(position: entry.position)

            Crest(imageName: getCrestImageName(entry.team.crestUrl))

            VStack(alignment: .leading) {
                TitleText(text: entry.team.name)
                RecordRow(entry: entry)
                GoalsRow(entry: entry)
            }

            Spacer()

            PointsText(points: entry.points)
        }
    }
}

struct LeaguePositionText: View {
    
    var position: Int
    
    var body: some View {
        Text("\(position).")
            .font(.system(size: 18))
            .fixedSize()
            .frame(width: 16)
    }
}

struct PointsText: View {
    
    var points: Int
    
    var body: some View {
        Text("\(points)")
            .font(.system(size: 18))
    }
}

fileprivate struct Crest: View {
    
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 40, height: 40)
            .padding(6)
    }
}

struct TitleText: View {
    
    var text: String
    
    var body: some View {
        Text(text).font(.system(size: 16)).bold()
    }
}

struct RecordRow: View {
    
    var entry: StandingsEntry
    
    var body: some View {
        HStack {
            SmallText(text: "Record: ")
            SmallGreenText(text: "\(entry.won) ")
            SmallText(text: "\(entry.draw) ")
            SmallRedText(text: "\(entry.lost)")
        }
    }
}

struct GoalsRow: View {
    
    var entry: StandingsEntry
    
    var body: some View {
        HStack {
            SmallText(text: "Goals: ")
            SmallGreenText(text: "\(entry.goalsFor) ")
            SmallRedText(text: "\(entry.goalsAgainst) ")
            SmallText(text: "\(entry.goalDifference)")
        }
    }
}

struct SmallGreenText: View {
    var text: String

    var body: some View {
        SmallText(
            text: text,
            color: Color(.init(red: 0.0, green: 0.55, blue: 0.0, alpha: 1.0))
        )
    }
}

struct SmallRedText: View {
    var text: String

    var body: some View {
        SmallText(
            text: text,
            color: Color(.init(red: 0.9, green: 0.0, blue: 0.0, alpha: 1.0))
        )
    }
}

struct SmallText: View {
    var text: String
    var color: Color?
    
    var body: some View {
        Text(text)
            .font(.system(size: 14))
            .foregroundColor(color)
    }
}
