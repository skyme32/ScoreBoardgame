//
//  GameboardResponse.swift
//  ScoreBoardgame
//
//  Created by Marcos Mejias on 15/4/22.
//

import Foundation


struct GameboardResponse: Codable {
    
    let games: [Gameboard]
    let count: Int
    
}
