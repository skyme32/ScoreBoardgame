//
//  AtlasClient.swift
//  ScoreBoardgame
//
//  Created by Marcos Mejias on 3/4/22.
//

import Foundation


class AtlasClient {

    struct Auth {
        static var key = "fF0EiJBgl1"
    }

    // MARK: Endpoints

    enum Endpoints {
        static let base = "https://api.boardgameatlas.com/api/search"
        static let apiKeyParam = "?client_id=\(AtlasClient.Auth.key)"
        
        case searchBoardgamr(query: String)
        
        var stringValue: String {
            switch self {
            case .searchBoardgamr(let query):
                return Endpoints.base + Endpoints.apiKeyParam + "&order_by=popularity" + "&name=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    // MARK: Request Search Methods
    
    class func getSearchGameboardList(query: String,
                                     completion: @escaping ([Gameboard], Error?) -> Void) {
        let urlExtension = Endpoints.searchBoardgamr(query: query).url
        MethodAPI.taskForGETRequest(url: urlExtension, responseType: GameboardResponse.self) { response, error in
            if let response = response {
                completion(response.games, nil)
            } else {
                print("ERROR: \(String(describing: error))")
                completion([], error)
            }
        }
    }
    
    /*
    class func downloadPosterImage(url: String, completion: @escaping (Data?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: Endpoints.getUrl(url).url) { data, response, error in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
        task.resume()
    }
     */
}
