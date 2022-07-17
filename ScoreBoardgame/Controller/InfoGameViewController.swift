//
//  InfoGameViewController.swift
//  ScoreBoardgame
//
//  Created by Marcos Mejias on 16/7/22.
//

import UIKit
import MapKit


class InfoGameViewController: UIViewController {
    
    // MARK: Variables and @IBOutlet
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLAbel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var commentsLabel: UITextView!
    
    var game: Game!
    var scoreList: [Score] = []
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .long
        return df
    }()
    
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = game.title
        
        for case let score as Score in game.scores!  {
            scoreList.append(score)
        }
        scoreList = scoreList.sorted(by: { $0.score > $1.score })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if game != nil {
            addComponents()
            zoomRegion()
            addPointAnnotation()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "EditGameSegue" {
            let detailVC = segue.destination as! EditScoreViewController
            detailVC.game = game
        }
    }
    
    
    // MARK: Private Methods
    
    private func addComponents() {
        
        if let creationDate = game.creation_date {
            dateLabel.text = dateFormatter.string(from: creationDate)
        }
        
        location.text = game.geolocation
        timeLAbel.text = "\(game.time!) minuts"
        commentsLabel.text = game.comment
    }

}

// MARK: MapKit delegate

extension InfoGameViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = UIColor.orange
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    fileprivate func zoomRegion() {
        let center = CLLocationCoordinate2D(latitude: game.latitude, longitude: game.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
        mapView.setRegion(region, animated: true)
    }
    
    fileprivate func addPointAnnotation() {
        let myPin: MKPointAnnotation = MKPointAnnotation()
        myPin.coordinate.latitude = game.latitude
        myPin.coordinate.longitude = game.longitude
        myPin.title = game.title
        
        mapView.addAnnotation(myPin)
    }
}


// MARK: TableView delegate

extension InfoGameViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoreList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let score = scoreList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameSocoreViewCell", for: indexPath) as! GameSocoreViewCell
        cell.playerLabel.text = score.player
        cell.scoreLabel.text = String(score.score)
        
        return cell
    }
}
