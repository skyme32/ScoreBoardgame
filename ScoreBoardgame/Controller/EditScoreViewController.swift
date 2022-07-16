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
    
    var dataController = DataController.shared.viewContext
    var fetchedResultsController:NSFetchedResultsController<Boardgame>!
    var gameboard: DetailBoardgame!
    var scoreList: [Score] = []

    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupFetchedResultsController()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        fetchedResultsController = nil
    }
        
    
    // MARK: Action buttons
    
    @IBAction func buttonSaveSacore(_ sender: Any) {
        saveBoardGame()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "InitialTab")
        self.view.window?.rootViewController = initialViewController
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
    
    fileprivate func setupFetchedResultsController() {
        let fetchRequest:NSFetchRequest<Boardgame> = Boardgame.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let predicate = NSPredicate(format: "id == %@", gameboard.id)
        fetchRequest.predicate = predicate
        
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: DataController.shared.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
    }
    
    func addScore(playerName: String, score: Int32) -> Score {
        let scoreNew = Score(context: dataController)
        scoreNew.player = playerName
        scoreNew.score = score
        
        return scoreNew
    }
    
    func saveBoardGame() {
        
        if fetchedResultsController.fetchedObjects!.count < 1 {
            let boardgame = Boardgame(context: dataController)
            
            boardgame.id = gameboard.id
            boardgame.name = gameboard.name
            boardgame.average_rating = gameboard.averageRating
            boardgame.description_preview = gameboard.descriptionPreview
            boardgame.image_url = gameboard.imageUrl
            boardgame.players = gameboard.players
            boardgame.playtime = gameboard.playtime
            boardgame.year_published = Int16(gameboard.yearPublished)
            boardgame.rules_url = gameboard.rulesUrl
            boardgame.url = gameboard.url
            boardgame.photo = gameboard.imageGame
            
            try? dataController.save()
        }
    }
    
}
