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
    var flagKeyBoard = false;
    var score: Score!
    
    public var completionHandler: ((String?, String?, Int?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        subscribeToKeyboardNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
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

// MARK: KeyBoard controller

extension AddPlayerViewController {
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if !flagKeyBoard {
            if editTextName.isFirstResponder || editTextScore.isFirstResponder {
                view.frame.origin.y -= getKeyboardHeight(notification) - editTextScore.frame.height - editTextName.frame.height
            }
            flagKeyBoard = true
        }
        
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if !flagKeyBoard {
            if editTextName.isFirstResponder || editTextScore.isFirstResponder {
                view.frame.origin.y = 0
            }
        }
    }

    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
}
