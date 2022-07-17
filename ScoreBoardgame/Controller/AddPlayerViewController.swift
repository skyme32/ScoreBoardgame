//
//  AddPlayerViewController.swift
//  ScoreBoardgame
//
//  Created by Marcos Mejias on 2/7/22.
//

import UIKit

class AddPlayerViewController: UIViewController {

    @IBOutlet weak var editTextName: UITextField!
    @IBOutlet weak var editTextScore: UITextField!
    
    var indexList = -1
    var score: Score!
    
    public var completionHandler: ((String?, String?, Int?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        reloadData()
    }
    
    @IBAction func addPlayer(_ sender: Any) {
        
        completionHandler?(editTextName.text, editTextScore.text, indexList)
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelAddPlayer(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    private func reloadData() {
        
        if (score != nil) {
            editTextName.text = score.player
            editTextScore.text = String(score.score)
        }
    }
    
}
