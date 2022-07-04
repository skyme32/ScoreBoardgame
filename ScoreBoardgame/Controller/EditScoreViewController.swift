//
//  EditScoreViewController.swift
//  ScoreBoardgame
//
//  Created by Marcos Mejias on 2/7/22.
//

import UIKit

class EditScoreViewController: UIViewController {
    
    @IBOutlet weak var editTextTime: UITextField!
    @IBOutlet weak var editTextLocation: UITextField!
    @IBOutlet weak var editTextComment: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonSaveSacore(_ sender: Any) {
    }
    
    @IBAction func buttonAddPlayer(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddPlayer") as! AddPlayerViewController
        vc.completionHandler = { name, score in
            self.editTextTime.text = name
            self.editTextLocation.text = score
        }
        present(vc, animated: true)
        
    }
}
