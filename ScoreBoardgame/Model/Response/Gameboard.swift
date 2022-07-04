//
//  Gameboard.swift
//  ScoreBoardgame
//
//  Created by Marcos Mejias on 15/4/22.
//
//{
//  "id": "string",
//  "url": "string",
//  "name": "string",
//  "year_published": double,
//  "min_age": double,
//  "image_url": "string",
//  "rules_url": "string",
//  "average_user_rating": double,
//  "players": "string",
//  "playtime": "string",
//  "images": {
//    "thumb": "40x40/string",
//    "small": "150x150/string",
//    "medium": "350x350/string",
//    "large": "700x700/string",
//    "original": "string"
//  },
//  "description_preview": "string"
//}

import Foundation

struct Images: Codable {
    let thumb: String
    let small: String
    let medium: String
    let large: String
    let original: String
}

struct Gameboard: Codable {
    
    let id: String
    let url: String?
    let name: String
    let yearPublished: Int?
    let minAge: Int?
    let imageUrl: String?
    let rulesUrl: String?
    let averageRating: Double?
    let players: String?
    let playtime: String?
    let images: Images?
    let descriptionPreview: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case url
        case name
        case yearPublished = "year_published"
        case minAge = "min_age"
        case imageUrl = "image_url"
        case rulesUrl = "rules_url"
        case averageRating = "average_user_rating"
        case players
        case playtime
        case images
        case descriptionPreview = "description_preview"
    }
}
