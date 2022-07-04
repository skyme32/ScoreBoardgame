//
//  extensionBoardgame.swift
//  ScoreBoardgame
//
//  Created by Marcos Mejias on 2/7/22.
//

import Foundation


extension Boardgame {
    
    typealias GameboardData = (title: String, value: String?, image: String)
    
    var tableRepresentation: [GameboardData] {
        
        return [
            ("Name", name, "dice.fill"),
            ("Year", "\(year_published)", "calendar"),
            ("Rating", "\(String(format:"%.1f", average_rating))/5", "star.fill"),
            ("Players", "\(players ?? "")", "person.fill"),
            ("Play time", "\(playtime ?? "")", "clock.fill")
        ]
    }
    
    func convert(gameboard: Gameboard) {
        
        self.name = gameboard.name
        self.average_rating = gameboard.averageRating!
        self.description_preview = gameboard.descriptionPreview
        self.image_url = gameboard.imageUrl
        self.players = gameboard.players
        self.playtime = gameboard.playtime
        self.year_published = Int16(gameboard.yearPublished!)
        self.rules_url = gameboard.rulesUrl
        self.url = gameboard.url

    }
}
