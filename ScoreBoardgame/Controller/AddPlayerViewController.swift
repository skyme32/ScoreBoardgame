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
        
        let num = Int(editTextScore.text ?? "")
        if num != nil && !editTextName.text!.isEmpty && !editTextScore.text!.isEmpty {
            completionHandler?(editTextName.text, editTextScore.text, indexList)
            dismiss(animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Score Alert", message: "The player and score couldn't empty, and score don't accept test, only numbers.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(alert, animated: true, completion: nil)
        }
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
