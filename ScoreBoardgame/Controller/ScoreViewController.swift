//
//  ScoreViewController.swift
//  ScoreBoardgame
//
//  Created by Marcos Mejias on 16/7/22.
//

import UIKit
import CoreData

class ScoreViewController: UIViewController {
    
    var dataController:DataController!
    var fetchedResultsController:NSFetchedResultsController<Boardgame>!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let scoreNew = Score(context: dataController.viewContext)
        scoreNew.player = "Mark"
        scoreNew.score = 12
        try? dataController.viewContext.save()
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
