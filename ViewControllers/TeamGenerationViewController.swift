//
//  TeamGenerationViewController.swift
//  FootballLeagueSimulator
//
//  Created by Donat on 1.6.23.
//

import UIKit


/// The initial viewController that is shown ot the user whenever they open the app. Main function is to navigate to the TableView of the Generated teams.
class TeamGenerationViewController: UIViewController {
    
    // Mark: Properties
    let button: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Generate Fixtures", for: .normal)
        btn.setTitleColor(.label, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        return btn
    }()

    // Mark: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    // Mark: Functions
    func setupUI() {
        view.addSubview(button)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    @objc func buttonTapped() {
        let vc = GeneratedTeamsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }


}
