//
//  Fixture.swift
//  FootballLeagueSimulator
//
//  Created by Donat on 1.6.23.
//

import Foundation

class Fixture: Hashable {
    var homeTeam: Team
    var awayTeam: Team
    var homeGoals: Int?
    var awayGoals: Int?
    
    init(homeTeam: Team, awayTeam: Team, homeGoals: Int? = nil, awayGoals: Int? = nil) {
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.homeGoals = homeGoals
        self.awayGoals = awayGoals
    }
    
    static func == (lhs: Fixture, rhs: Fixture) -> Bool {
        return (lhs.homeTeam == rhs.homeTeam && lhs.awayTeam == rhs.awayTeam) ||
        (lhs.homeTeam == rhs.awayTeam && lhs.awayTeam == rhs.homeTeam)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(homeTeam)
        hasher.combine(awayTeam)
    }
}
