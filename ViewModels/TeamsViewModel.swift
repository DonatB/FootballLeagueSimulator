//
//  TeamsViewModel.swift
//  FootballLeagueSimulator
//
//  Created by Donat on 1.6.23.
//

import Foundation

final class TeamsViewModel {
    
    var teams: [Team] = []
    var fixtures: [Fixture] = []
    
    init() {
        generateTeams()
        generateFixtures()
    }
    
    func isSeasonOver() -> Bool {
        return fixtures.isEmpty
    }
    
    private func generateTeams() {
        for i in 1...20 {
            //Generate a new team
            let team = Team(
                name: "Team \(i)",
                points: 0,
                logo: "soccerball", 
                coachName: "Coach \(i)",
                city: "City \(i)",
                goalsScored: 0,
                goalsAgainst: 0,
                cellColor: HelperFunctions.randomColor()
            )
            
            // And add the new team object to our array
            teams.append(team)
        }
    }
    
    //Round Robin algorithm used to generate fixtures in order for them to play each other twice in a season.
    private func generateFixtures() {
        let halfway = teams.count / 2
        var firstHalfTeams = Array(teams[0..<halfway])
        var secondHalfTeams = Array(teams[halfway..<teams.count])
        var fixtureWeeks: [[Fixture]] = []
        
        for _ in 0..<(teams.count - 1) {
            var weekMatches: [Fixture] = []
            for i in 0..<halfway {
                let fixture = Fixture(homeTeam: firstHalfTeams[i], awayTeam: secondHalfTeams[i])
                weekMatches.append(fixture)
            }
            
            // Add matches of this week to fixtureWeeks
            fixtureWeeks.append(weekMatches)
            
            let first = firstHalfTeams.remove(at: 1)
            secondHalfTeams.append(first)
            let last = secondHalfTeams.removeLast()
            firstHalfTeams.append(last)
        }
        
        let secondHalfFixtureWeeks = fixtureWeeks.map { weekMatches in
            weekMatches.map { Fixture(homeTeam: $0.awayTeam, awayTeam: $0.homeTeam) }
        }
        
        // Adding second half of the season to fixtureWeeks
        fixtureWeeks.append(contentsOf: secondHalfFixtureWeeks)
        
        // Shuffling weeks, not individual games
        fixtureWeeks.shuffle()
        
        // Flatting [[Fixture]] to [Fixture]
        fixtures = fixtureWeeks.flatMap { $0 }
    }


    
    func playWeekMatches() {
        guard fixtures.count >= 10 else {
            print("Season finished. All fixtures have been played!")
            return
        }
        
        for _ in 1...10 {
            playFixture(fixtureIndex: 0)
        }
    }

    func playFixture(fixtureIndex: Int) {
        // Ensure the fixture index is valid
        guard fixtures.indices.contains(fixtureIndex) else {
            return
        }
        
        // Get a reference to the fixture
        let fixture = fixtures[fixtureIndex]
        
        // Generate random goals for each team
        let homeGoals = Int.random(in: 0...5)
        let awayGoals = Int.random(in: 0...5)
        
        // Update the fixture with the scores
        fixture.homeGoals = homeGoals
        fixture.awayGoals = awayGoals
        
        // Update teams' goals scored and against
        updateTeamGoals(for: fixture.homeTeam.name, scored: homeGoals, against: awayGoals)
        updateTeamGoals(for: fixture.awayTeam.name, scored: awayGoals, against: homeGoals)
        
        // Determine match outcome and update points
        if homeGoals > awayGoals {
            updatePoints(for: fixture.homeTeam.name, points: 3) // Home team wins
        } else if homeGoals < awayGoals {
            updatePoints(for: fixture.awayTeam.name, points: 3) // Away team wins
        } else {
            updatePoints(for: fixture.homeTeam.name, points: 1) // Draw
            updatePoints(for: fixture.awayTeam.name, points: 1) // Draw
        }
        
        // Remove the played fixture
        fixtures.remove(at: fixtureIndex)
    }


    
    private func updateTeamGoals(for teamName: String, scored: Int, against: Int) {
        if let index = teams.firstIndex(where: { $0.name == teamName }) {
            teams[index].goalsScored += scored
            teams[index].goalsAgainst += against
        }
    }
    
    private func updatePoints(for teamName: String, points: Int) {
        if let index = teams.firstIndex(where: { $0.name == teamName }) {
            teams[index].points += points
        }
    }
    
}

