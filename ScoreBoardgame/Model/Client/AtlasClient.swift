//
//  AtlasClient.swift
//  ScoreBoardgame
//
//  Created by Marcos Mejias on 3/4/22.
//

import Foundation


class FlickrClient {

    struct Auth {
        static var key = ""
    }

    // MARK: Endpoints

    enum Endpoints {
        static let base = ""
        
        case searchBoardgamr(querie: String)
        
        var stringValue: String {
            switch self {
            case .searchBoardgamr(let searching):
                return Endpoints.base
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    // MARK: Request Search GEO Methods
}
