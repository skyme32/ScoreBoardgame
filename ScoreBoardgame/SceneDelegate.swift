//
//  SceneDelegate.swift
//  ScoreBoardgame
//
//  Created by Marcos Mejias on 3/4/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    let dataController = DataController(modelName: "ScoreBoardgame")

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let _ = (scene as? UIWindowScene) else { return }
        
        dataController.load()
        
        if let tabBarController = window?.rootViewController as? UITabBarController {
                    
            let tabArray = tabBarController.viewControllers!
            
            for tab in tabArray {
                
                let controller = tab as! UINavigationController
                let uiController = controller.topViewController
                
                switch uiController {
                case let uiController as ScoreViewController:
                    uiController.dataController = dataController
                case let uiController as SearchViewController:
                    uiController.dataController = dataController
                case let uiController as FavoriteViewController:
                    uiController.dataController = dataController
                default:
                    break
                }
            }
        }
    }
    
}
