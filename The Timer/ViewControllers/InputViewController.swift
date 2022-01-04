//
//  InputViewController.swift
//  The Timer
//
//  Created by Bilge Zerre on 25.12.2021.
//

import UIKit

class InputViewController: BaseViewController {
    
    var playerId: String? = ""
    @IBOutlet weak var startSessionButton: UIButton!
    @IBOutlet weak var inputField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
//    UI functionalities for the input screen and add start session button functionality based on input text field's state
    func initViews() {
        inputField.delegate = self
        inputField.keyboardType = .numberPad
        startSessionButton.isUserInteractionEnabled = true
        startSessionButton.setCorners(8)
        startSessionButton.tap {
            if self.inputField.text == nil {
                return
            }
            if let distanceDouble = Double(self.inputField.text ?? "") {
                self.navigateToSessionScreen(distance: distanceDouble)
            } else {
                
                let alert = UIAlertController(title: "Invalid Distance", message: "Please enter a number for instance (Ex: 100)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Got it!", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
            self.inputField.text = ""
            self.view.endEditing(true)
        }
    }
    
    
//    navigate the session screen with selected playerId and specified distance in input screen
    func navigateToSessionScreen(distance: Double) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "SessionViewController") as! SessionViewController
        vc.playerId = self.playerId ?? ""
        vc.distance = distance
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension InputViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text  == "" {
            startSessionButton.isEnabled = false
        } else {
            startSessionButton.isEnabled = true
        }
        return true
    }
        
}
