//
//  InfoBoardViewController.swift
//  ScoreBoardgame
//
//  Created by Marcos Mejias on 15/4/22.
//

import PDFKit
import UIKit
import CoreData

class InfoBoardViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var desciptionView: UITextView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var rulesButton: UIBarButtonItem!
    
    var gameboard: DetailBoardgame!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = gameboard.name
        self.descriptionHidden(textDesc: gameboard.descriptionPreview)
        
        if (gameboard.imageGame == nil) {
            self.indicatorStatus(status: true)
            self.downloadPosterImage()
        } else {
            self.imageView.image = UIImage(data: gameboard.imageGame)
        }
        
        if gameboard.rulesUrl.isEmpty {
            rulesButton.isEnabled = false
        } else {
            rulesButton.isEnabled = true
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "linkEditBoardgame" {
            let detailVC = segue.destination as! EditScoreViewController
            detailVC.gameboard = gameboard
        }
    }
    
    // MARK: Actions
    
    @IBAction func goToRules(_ sender: Any) {
        if !gameboard.rulesUrl.isEmpty {
            UIApplication.shared.open(URL(string: gameboard.rulesUrl)!)
        }
    }
    
    // MARK: UI Methods
    
    private func indicatorStatus(status: Bool) {
        self.indicatorView.startAnimating()
        self.indicatorView.isHidden = !status
    }
    
    private func descriptionHidden(textDesc: String) {
        self.desciptionView.text = textDesc.trimmingCharacters(in: .whitespacesAndNewlines)
                
        if self.desciptionView.text == "" {
            self.desciptionView.isHidden = true
            self.descriptionLabel.isHidden = true
        }
    }
    
    private func downloadPosterImage() {
        
        if !gameboard.imageUrl.isEmpty {
            AtlasClient.downloadPosterImage(path: gameboard.imageUrl) { data, error in
                guard let data = data else {
                    return
                }
                self.imageView.image = UIImage(data: data)
                self.indicatorStatus(status: false)
                self.gameboard.imageGame = data
            }
        }
    }
    
    private func toggleBarButton(_ button: UIBarButtonItem, enabled: Bool) {
        if enabled {
            button.tintColor = UIColor.accentColor
        } else {
            button.tintColor = UIColor.gray
        }
    }
}

// MARK:

extension InfoBoardViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameboard.tableRepresentation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoDetail", for: indexPath) as! InfoDetailViewCell

        let row = indexPath.row
        cell.cellKey.text = gameboard.tableRepresentation[row].title
        cell.cellValue!.text = gameboard.tableRepresentation[row].value
        cell.cellImage.image = UIImage(systemName: gameboard.tableRepresentation[row].image)
        
        return cell
    }
}
