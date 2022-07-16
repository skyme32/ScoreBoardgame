//
//  EditScoreViewController.swift
//  ScoreBoardgame
//
//  Created by Marcos Mejias on 2/7/22.
//

import UIKit
import CoreData

class EditScoreViewController: UIViewController {
    
    // MARK: @IBOutlet
    
    @IBOutlet weak var pickerDate: UIDatePicker!
    @IBOutlet weak var editTextTime: UITextField!
    @IBOutlet weak var editTextLocation: UITextField!
    @IBOutlet weak var editTextComment: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var dataController:DataController!
    var scoreList: [Score] = []

    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    
    // MARK: Action buttons
    
    @IBAction func buttonSaveSacore(_ sender: Any) {
    }
    
    @IBAction func buttonAddPlayer(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddPlayer") as! AddPlayerViewController
        vc.completionHandler = { name, score in
            self.addRefreshNewPlayer(name: name!, score: score!)
        }
        present(vc, animated: true)
    }
    
    
    // MARK: Private functions
    
    private func addRefreshNewPlayer(name: String, score: String) {
        if !name.isEmpty && !score.isEmpty {
            scoreList.append(addScore(playerName: name, score: Int32(score)!))
            tableView.reloadData()
        }
    }
}


// MARK: Table Delegate

extension EditScoreViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoreList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let score = scoreList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreViewCell", for: indexPath) as! ScoreViewCell
        cell.playerName.text = score.player
        cell.score.text = String(score.score)
        
        return cell
    }
}


// MARK: Delegate CoreData

extension EditScoreViewController: NSFetchedResultsControllerDelegate {
    
    func addScore(playerName: String, score: Int32) -> Score {
        let scoreNew = Score(context: dataController.viewContext)
        scoreNew.player = playerName
        scoreNew.score = score
        
        return scoreNew
    }
    
}
