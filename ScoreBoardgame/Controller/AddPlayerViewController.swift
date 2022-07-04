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
    
    public var completionHandler: ((String?, String?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addPlayer(_ sender: Any) {
        
        completionHandler?(editTextName.text, editTextScore.text)
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelAddPlayer(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
}
