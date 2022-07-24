//
//  SearchViewController.swift
//  ScoreBoardgame
//
//  Created by Marcos Mejias on 3/4/22.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!

    
    var currentSearchTask: URLSessionDataTask?
    var gameboards = [Gameboard]()
    var selectedIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "infoBoardgame" {
            let detailVC = segue.destination as! InfoBoardViewController
            detailVC.gameboard = DetailBoardgame(gameboard: gameboards[selectedIndex])
        }
    }
    
    
    // MARK: Private Methods
    
    private func indicatorStatus(status: Bool) {
        self.indicatorView.startAnimating()
        self.indicatorView.isHidden = !status
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.indicatorStatus(status: true)
        
        if searchText == "" {
            gameboards.removeAll()
            self.tableView.reloadData()
            self.indicatorStatus(status: false)
            return
        }
        
        AtlasClient.getSearchGameboardList(query: searchText) { gamerboards, error in
            self.gameboards = gamerboards
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.indicatorStatus(status: false)
            }
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameboards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameTableViewCell")!
        
        let gameboard = gameboards[indexPath.row]
        cell.textLabel?.text = "\(gameboard.name)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "infoBoardgame", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
