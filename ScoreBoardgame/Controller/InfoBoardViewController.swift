//
//  InfoBoardViewController.swift
//  ScoreBoardgame
//
//  Created by Marcos Mejias on 15/4/22.
//

import UIKit

class InfoBoardViewController: UIViewController {
    
    
    @IBOutlet weak var desciptionView: UITextView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var gameboard: Gameboard!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = gameboard.name
        self.indicatorStatus(status: true)
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
        self.desciptionView.text = gameboard.descriptionPreview?.trimmingCharacters(in: .whitespacesAndNewlines)

    }
    
    private func indicatorStatus(status: Bool) {
        self.indicatorView.startAnimating()
        self.indicatorView.isHidden = !status
    }
    
    
}

extension InfoBoardViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameboard.tableRepresentation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoDetail")!
        
        let row = indexPath.row
        cell.textLabel!.text = gameboard.tableRepresentation[row].title
        cell.detailTextLabel!.text = gameboard.tableRepresentation[row].value
        
        return cell
    }
}
