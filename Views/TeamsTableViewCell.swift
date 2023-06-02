//
//  TeamsTableViewCell.swift
//  FootballLeagueSimulator
//
//  Created by Donat on 2.6.23.
//

import UIKit


/// The cell which is used to display information about the teams in the GeneratedTeamsTableView.
class TeamsTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "TeamsTableViewCell"
    
    public let tablePositionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let teamImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let goalsScoredLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let goalsAgainstLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let goalDifferenceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let teamNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pointsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Mark: Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Mark: UI Setup
    private func addConstraints() {
        contentView.addSubview(tablePositionLabel)
        contentView.addSubview(teamImageView)
        contentView.addSubview(goalsScoredLabel)
        contentView.addSubview(goalsAgainstLabel)
        contentView.addSubview(goalDifferenceLabel)
        contentView.addSubview(teamNameLabel)
        contentView.addSubview(pointsLabel)
        
        NSLayoutConstraint.activate([
            tablePositionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            tablePositionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            teamImageView.leadingAnchor.constraint(equalTo: tablePositionLabel.trailingAnchor, constant: 16),
            teamImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            teamImageView.widthAnchor.constraint(equalToConstant: 40),
            teamImageView.heightAnchor.constraint(equalToConstant: 40),
            
            goalsScoredLabel.leadingAnchor.constraint(equalTo: teamImageView.trailingAnchor, constant: 16),
            goalsScoredLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            
            goalsAgainstLabel.leadingAnchor.constraint(equalTo: teamImageView.trailingAnchor, constant: 16),
            goalsAgainstLabel.topAnchor.constraint(equalTo: goalsScoredLabel.bottomAnchor, constant: 8),
            
            goalDifferenceLabel.leadingAnchor.constraint(equalTo: teamImageView.trailingAnchor, constant: 16),
            goalDifferenceLabel.topAnchor.constraint(equalTo: goalsAgainstLabel.bottomAnchor, constant: 8),
            
            teamNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 10),
            teamNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            pointsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            pointsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    // Mark: Public functions
    func configure(with team: Team) {
        teamImageView.image = UIImage(systemName: team.logo ?? "soccerball")
        teamImageView.tintColor = team.cellColor ?? .systemPink
        goalsScoredLabel.text = "GF: \(team.goalsScored)"
        goalsAgainstLabel.text = "GA: \(team.goalsAgainst)"
        goalDifferenceLabel.text = "GD: \(team.goalsDifference)"
        teamNameLabel.text = team.name
        teamNameLabel.textColor = team.cellColor ?? .systemPink
        pointsLabel.text = "Pts: \(team.points)"
    }

}
