//
//  TeamDetailView.swift
//  FootballLeagueSimulator
//
//  Created by Donat on 2.6.23.
//

import UIKit

/// The view which is shown whenever a cell is clicked in the GeneratedTeamsViewController. This View is used to give more details for the user.
class TeamDetailView: UIView {
    private var team: Team?
    private let stackView = UIStackView()
    private let teamNameLabel = UILabel()
    private let coachNameLabel = UILabel()
    private let cityLabel = UILabel()
    private let pointsLabel = UILabel()
    private let goalsScoredLabel = UILabel()
    private let goalsAgainstLabel = UILabel()
    
    init(team: Team) {
        super.init(frame: .zero)
        self.team = team
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.systemMint.cgColor
        self.layer.borderWidth = 1
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        addSubview(stackView)
        
        setupConstraints()
        configureLabels()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
        ])
    }
    
    private func configureLabels() {
        guard let team = team else { return }
        teamNameLabel.text = "Team: \(team.name)"
        coachNameLabel.text = "Coach: \(team.coachName ?? "Jose Mourinho")"
        cityLabel.text = "City: \(team.city ?? "Manchester")"
        pointsLabel.text = "Points: \(team.points)"
        goalsScoredLabel.text = "Goals scored: \(team.goalsScored)"
        goalsAgainstLabel.text = "Goals against: \(team.goalsAgainst)"
        
        [teamNameLabel, coachNameLabel, cityLabel, pointsLabel, goalsScoredLabel, goalsAgainstLabel].forEach { label in
            stackView.addArrangedSubview(label)
        }
    }
}

