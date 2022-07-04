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
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let scoreViewController = storyboard.instantiateViewController(withIdentifier: "ScoreBoardgames") as! ScoreViewController
        scoreViewController.dataController = dataController
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

