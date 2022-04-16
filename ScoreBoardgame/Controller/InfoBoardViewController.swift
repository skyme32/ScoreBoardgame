//
//  InfoBoardViewController.swift
//  ScoreBoardgame
//
//  Created by Marcos Mejias on 15/4/22.
//

import PDFKit
import UIKit

class InfoBoardViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var desciptionView: UITextView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var rulesButton: UIBarButtonItem!
    
    var gameboard: Gameboard!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = gameboard.name
        self.indicatorStatus(status: true)
        self.downloadPosterImage()
        self.descriptionHidden(textDesc: gameboard.descriptionPreview!)
        toggleBarButton(favoriteButton, enabled: false)
        
        if gameboard.rulesUrl == nil {
            rulesButton.isEnabled = false
        } else {
            rulesButton.isEnabled = true
        }
    }
    
    // MARK: Actions
    
    @IBAction func goToRules(_ sender: Any) {
        if gameboard.rulesUrl != nil {
            UIApplication.shared.open(URL(string: gameboard.rulesUrl!)!)
        }
    }
    
    @IBAction func ishaveToFavorite(_ sender: Any) {
        toggleBarButton(favoriteButton, enabled: true)
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
        if let posterPath = gameboard.imageUrl {
            AtlasClient.downloadPosterImage(path: posterPath) { data, error in
                guard let data = data else {
                    return
                }
                let image = UIImage(data: data)
                self.imageView.image = image
                self.indicatorStatus(status: false)
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
