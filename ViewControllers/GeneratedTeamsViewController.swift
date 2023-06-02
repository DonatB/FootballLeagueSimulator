//
//  GeneratedTeamsViewController.swift
//  FootballLeagueSimulator
//
//  Created by Donat on 1.6.23.
//

import UIKit


/// This ViewController generates the fixtures of the season and allow the user to simulate a season of the generated teams.
class GeneratedTeamsViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel = TeamsViewModel()
    private var tableView: UITableView!
    
    private var teamDetailView: TeamDetailView?
    var outsideTapGesture: UITapGestureRecognizer?
    private var blurView: UIVisualEffectView?
    
    var count = 0
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    // MARK: - Functions
    private func setupUI() {
        title = "Week \(count)"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        let playFixtureButton = UIBarButtonItem(title: "Start Season", style: .plain, target: self, action: #selector(playFixture))
        navigationItem.rightBarButtonItem = playFixtureButton
    }
    
    @objc func playFixture() {
        if viewModel.isSeasonOver() {
            // If season is over and the button says "Reset Season", reset the season
            if navigationItem.rightBarButtonItem?.title == "Reset Season" {
                viewModel = TeamsViewModel()
                count = 0
                title = "Week \(count)"
                navigationItem.rightBarButtonItem?.title = "Start Season"
            } else {
                // If season is over but the button doesn't say "Reset Season" yet, just change the button
                navigationItem.rightBarButtonItem?.title = "Reset Season"
                
                let alertController = UIAlertController(title: "Season Over", message: "The season has finished, please reset the season to start over.", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(action)
                present(alertController, animated: true, completion: nil)
            }
        } else {
            // If season is not over, play matches for the week
            viewModel.playWeekMatches()
            count += 1
            title = "Week \(count)"
            navigationItem.rightBarButtonItem?.title = "Play Next Week"
        }
        
        UIView.transition(with: tableView, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.tableView.reloadData()
        }, completion: nil)
    }

    
    
}

// MARK: TableView Delegates and methods
extension GeneratedTeamsViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setupTableView() {
        tableView = UITableView(frame: self.view.safeAreaLayoutGuide.layoutFrame)
        tableView.register(TeamsTableViewCell.self, forCellReuseIdentifier: TeamsTableViewCell.reuseIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        
        self.view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TeamsTableViewCell.reuseIdentifier, for: indexPath) as? TeamsTableViewCell
        else { fatalError("Error initialising the cell. This should never happen.") }
        
        let sortedTeams = viewModel.teams.sorted { $0.points > $1.points }
        let team = sortedTeams[indexPath.row]
        
        cell.configure(with: team)
        cell.tablePositionLabel.text = "\(indexPath.row + 1)."
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sortedTeams = viewModel.teams.sorted { $0.points > $1.points }
        let team = sortedTeams[indexPath.row]
        teamDetailView = TeamDetailView(team: team)
    
        
        blurView = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
        blurView?.translatesAutoresizingMaskIntoConstraints = false
        blurView?.alpha = 0
        
        guard let teamDetailView = teamDetailView, let blurView = blurView else { return }
        
        if let window = view.window?.windowScene?.keyWindow {
            window.addSubview(blurView)
            window.addSubview(teamDetailView)
        }
        
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: self.view.topAnchor),
            blurView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            blurView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            teamDetailView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            teamDetailView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            teamDetailView.widthAnchor.constraint(equalToConstant: 300),
            teamDetailView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        outsideTapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissDetailView(_:)))
        outsideTapGesture?.cancelsTouchesInView = false
        blurView.addGestureRecognizer(outsideTapGesture!)
        
        UIView.animate(withDuration: 0.3) {
            blurView.alpha = 1
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    @objc private func dismissDetailView(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: self.view.window)
        if let teamDetailView = teamDetailView, let blurView = blurView, !teamDetailView.frame.contains(location) {
            UIView.animate(withDuration: 0.3, animations: {
                teamDetailView.alpha = 0
                blurView.alpha = 0
            }, completion: { _ in
                teamDetailView.removeFromSuperview()
                blurView.removeFromSuperview()
                self.teamDetailView = nil
                if let outsideTap = self.outsideTapGesture {
                    blurView.removeGestureRecognizer(outsideTap)
                    self.outsideTapGesture = nil
                }
            })
        }
    }
    
}


