//
//  HelperFunctions.swift
//  FootballLeagueSimulator
//
//  Created by Donat on 2.6.23.
//

import UIKit

class HelperFunctions {
    
    static func randomColor() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
}
