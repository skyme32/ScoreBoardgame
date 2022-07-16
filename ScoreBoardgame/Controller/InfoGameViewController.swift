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
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .long
        return df
    }()
    
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = game.title
        
        addComponents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    
    // MARK: PRovate Methods
    
    private func addComponents() {
        
        if let creationDate = game.creation_date {
            dateLabel.text = dateFormatter.string(from: creationDate)
        }
        
        location.text = game.geolocation
        timeLAbel.text = "\(game.time!) minuts"
        commentsLabel.text = game.comment
    }

}
