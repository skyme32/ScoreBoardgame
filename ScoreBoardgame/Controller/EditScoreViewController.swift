//
//  EditScoreViewController.swift
//  ScoreBoardgame
//
//  Created by Marcos Mejias on 2/7/22.
//

import UIKit
import CoreData
import CoreLocation

class EditScoreViewController: UIViewController {
    
    // MARK: @IBOutlet
    
    @IBOutlet weak var pickerDate: UIDatePicker!
    @IBOutlet weak var editTextTime: UITextField!
    @IBOutlet weak var editTextLocation: UITextField!
    @IBOutlet weak var editTextComment: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var dataController = DataController.shared.viewContext
    var fetchedResultsBoardgame:NSFetchedResultsController<Boardgame>!
    var fetchedResultsGame:NSFetchedResultsController<Game>!
    var gameboard: DetailBoardgame!
    var gameEdit: Game!
    var titleGame: String = ""
    var photoGame: Data!
    var flagKeyBoard = false;
    var scoreList: [Score] = []
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D();
    lazy var geocoder = CLGeocoder()

    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if gameEdit == nil {
            setupFetchedResultsBoardGame()
        } else {
            refreshTextValues()
            setupFetchedResultsGame()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        fetchedResultsBoardgame = nil
        unsubscribeFromKeyboardNotifications()
    }
    
    
    // MARK: Action buttons
    
    @IBAction func buttonSaveSacore(_ sender: Any) {
        geocode(address: editTextLocation.text!)
        
        saveBoardGame()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "InitialTab")
        self.view.window?.rootViewController = initialViewController
    }
    
    @IBAction func buttonAddPlayer(_ sender: Any) {
        
        segueAddPlayer(index: -1, score: nil)
    }
    
    
    // MARK: Private functions
    
    private func addRefreshNewPlayer(name: String, score: String, index: Int) {
        
        if index > -1 {
            scoreList.remove(at: index)
        }
        
        if !name.isEmpty && !score.isEmpty {
            scoreList.append(addScore(playerName: name, score: Int32(score)!))
            tableView.reloadData()
        }
    }
    
    private func refreshTextValues() {
        
        titleGame = gameEdit.title!
        photoGame = gameEdit.photo!
        pickerDate.date = gameEdit.creation_date!
        editTextTime.text = gameEdit.time
        editTextLocation.text = gameEdit.geolocation
        editTextComment.text = gameEdit.comment
        
        for case let score as Score in gameEdit.scores!  {
            scoreList.append(score)
        }
        scoreList = scoreList.sorted(by: { $0.score > $1.score })
    }
    
    private func segueAddPlayer(index: Int, score: Score?) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddPlayer") as! AddPlayerViewController
        vc.indexList = index
        vc.score = score
        vc.completionHandler = { name, score, index in
            self.addRefreshNewPlayer(name: name!, score: score!, index: index!)
        }
        present(vc, animated: true)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        segueAddPlayer(index: indexPath.item, score: scoreList[indexPath.row])
    }
}


// MARK: Delegate CoreData

extension EditScoreViewController: NSFetchedResultsControllerDelegate {
    
    fileprivate func setupFetchedResultsBoardGame() {
        let fetchRequest:NSFetchRequest<Boardgame> = Boardgame.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let predicate = NSPredicate(format: "id == %@", gameboard.id)
        fetchRequest.predicate = predicate
        
        fetchedResultsBoardgame = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: dataController,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
                
        fetchedResultsBoardgame.delegate = self
        do {
            try fetchedResultsBoardgame.performFetch()
        } catch {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
    }
    
    fileprivate func setupFetchedResultsGame() {
        let fetchRequest:NSFetchRequest<Game> = Game.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let predicate = NSPredicate(format: "id == %@", gameEdit.id! as CVarArg)
        fetchRequest.predicate = predicate
        
        fetchedResultsGame = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: dataController,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
                
        fetchedResultsGame.delegate = self
        do {
            try fetchedResultsGame.performFetch()
        } catch {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
    }
    
    private func addScore(playerName: String, score: Int32) -> Score {
        let scoreNew = Score(context: dataController)
        scoreNew.player = playerName
        scoreNew.score = score
        
        return scoreNew
    }
    
    private func updateGameScore() {
        
        let indexPath = NSIndexPath(row: 0, section: 0)
        let gameUpdate = fetchedResultsGame.object(at: indexPath as IndexPath)
        
        gameUpdate.geolocation = editTextLocation.text
        gameUpdate.creation_date = pickerDate.date
        gameUpdate.time = editTextTime.text
        gameUpdate.geolocation = editTextLocation.text
        gameUpdate.comment = editTextComment.text
        gameUpdate.longitude = coordinate.longitude
        gameUpdate.latitude = coordinate.latitude
        gameUpdate.scores = nil
        
        for score in scoreList {
            let scoreNew = Score(context: dataController)
            scoreNew.player = score.player
            scoreNew.score = score.score
            
            gameUpdate.addToScores(scoreNew)
        }
        
        try? dataController.save()
    }
    
    private func saveGameScore(title: String, photo: Data) {
        let game = Game(context: dataController)
        game.id = UUID()
        game.title = title
        game.creation_date = pickerDate.date
        game.photo = photo
        game.time = editTextTime.text
        game.geolocation = editTextLocation.text
        game.comment = editTextComment.text
        game.longitude = coordinate.longitude
        game.latitude = coordinate.latitude
        
        for score in scoreList {
            let scoreNew = Score(context: dataController)
            scoreNew.player = score.player
            scoreNew.score = score.score
            
            game.addToScores(scoreNew)
        }
                
        try? dataController.save()
    }
    
    private func saveBoardGame() {
        
        if gameEdit == nil && fetchedResultsBoardgame.fetchedObjects!.count < 1 {
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
            boardgame.createDate = Date()
            
            try? dataController.save()
        }
    }
    
}


// MARK: Forward Geocode

extension EditScoreViewController {
    
    func geocode(address: String) {
        
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            self.processResponse(withPlacemarks: placemarks, error: error)
        }
    }
    
    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {

        if error == nil {
            var location: CLLocation?

            if let placemarks = placemarks, placemarks.count > 0 {
                location = placemarks.first?.location
            }

            if let location = location {
                coordinate = location.coordinate
            }
        }
        
        if (gameEdit == nil) {
            saveGameScore(title: gameboard.name, photo: gameboard.imageGame)
        } else {
            updateGameScore()
        }
    }
}

// MARK: KeyBoard controller

extension EditScoreViewController {
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
        
    @objc func keyboardWillShow(_ notification:Notification) {
        if !flagKeyBoard {
            if editTextTime.isFirstResponder || editTextLocation.isFirstResponder || editTextComment.isFirstResponder {
                view.frame.origin.y -= getKeyboardHeight(notification) - 40 - editTextTime.frame.height - editTextLocation.frame.height - editTextComment.frame.height
            }
            flagKeyBoard = true
        }
        
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if !flagKeyBoard {
            if editTextTime.isFirstResponder || editTextLocation.isFirstResponder || editTextComment.isFirstResponder {
                view.frame.origin.y = 0
            }
        }
    }

    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
}
