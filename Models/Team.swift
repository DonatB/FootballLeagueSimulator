//
//  Team.swift
//  FootballLeagueSimulator
//
//  Created by Donat on 1.6.23.
//

import UIKit

class Team: Hashable {
    let name: String
    var points: Int
    let logo: String?
    let coachName: String?
    let city: String?
    var goalsScored: Int
    var goalsAgainst: Int
    var cellColor: UIColor?
    
    var goalsDifference: Int {
        return goalsScored - goalsAgainst
    }
    
    init(name: String, points: Int, logo: String?, coachName: String?, city: String?, goalsScored: Int, goalsAgainst: Int, cellColor: UIColor) {
        self.name = name
        self.points = points
        self.logo = logo
        self.coachName = coachName
        self.city = city
        self.goalsScored = goalsScored
        self.goalsAgainst = goalsAgainst
        self.cellColor = cellColor
    }
    
    static func == (lhs: Team, rhs: Team) -> Bool {
        return lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
