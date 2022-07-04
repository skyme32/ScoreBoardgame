//
//  DetailBoardgame.swift
//  ScoreBoardgame
//
//  Created by Marcos Mejias on 2/7/22.
//

import Foundation

struct DetailBoardgame {

    var id = ""
    var url = ""
    var name = ""
    var yearPublished = 1900
    var minAge = ""
    var imageUrl = ""
    var rulesUrl = ""
    var averageRating = 0.0
    var players = ""
    var playtime = ""
    var descriptionPreview = ""
    typealias GameboardData = (title: String, value: String?, image: String)
    
    var tableRepresentation: [GameboardData] {
        
        return [
            ("Name", name, "dice.fill"),
            ("Year", "\(String(describing: yearPublished))", "calendar"),
            ("Rating", "\(String(format:"%.1f", averageRating))/5", "star.fill"),
            ("Players", "\(players)", "person.fill"),
            ("Play time", "\(playtime)", "clock.fill")
        ]
    }

    init(gameboard: Gameboard) {
        
        self.name = gameboard.name
        self.averageRating = gameboard.averageRating ?? 0.0
        self.descriptionPreview = gameboard.descriptionPreview ?? ""
        self.imageUrl = gameboard.imageUrl ?? ""
        self.players = gameboard.players ?? ""
        self.playtime = gameboard.playtime ?? ""
        self.yearPublished = gameboard.yearPublished ?? 1900
        self.rulesUrl = gameboard.rulesUrl ?? ""
        self.url = gameboard.url!
    }

    init(boardgame: Boardgame) {
        
        self.name = boardgame.name!
        self.averageRating = boardgame.average_rating
        self.descriptionPreview = boardgame.description_preview!
        self.imageUrl = boardgame.image_url!
        self.players = boardgame.players!
        self.playtime = boardgame.playtime!
        self.yearPublished = Int(boardgame.year_published)
        self.rulesUrl = boardgame.rules_url!
        self.url = boardgame.url!
    }
}
