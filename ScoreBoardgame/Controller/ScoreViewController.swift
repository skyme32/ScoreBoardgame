//
//  ScoreViewController.swift
//  ScoreBoardgame
//
//  Created by Marcos Mejias on 16/7/22.
//

import UIKit
import CoreData

class ScoreViewController: UIViewController {
    
    var dataController = DataController.shared.viewContext
    var fetchedResultsController:NSFetchedResultsController<Boardgame>!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
