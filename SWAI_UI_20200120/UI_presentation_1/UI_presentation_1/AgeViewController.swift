//
//  AgeInputController.swift
//  UI_presentation_1
//
//  Created by Yangjin Cho on 2020/01/28.
//  Copyright © 2020 임연지. All rights reserved.
//
import UIKit
import Foundation

var agePlaceholder:String = "Write Age Here"

class AgeViewController: UIViewController {
    @IBOutlet weak var ageInputTextField: UITextField!
    
    //@IBOutlet weak var settedUserAgeLabel: UILabel!
    
    @IBOutlet weak var ageInputSaveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super .viewDidLoad()
        ageInputTextField.placeholder = UserDefaults.standard.string(forKey: "inputAge")
    }
    
@IBAction func showAlert() {
        let alertController = UIAlertController(title: "User Age Saved!", message: "Your age has been saved.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {UIAlertAction in print("Age Saved")}))
        self.present(alertController, animated: true, completion: nil)
    }
    
@IBAction func ageInputSaveButtonClicked(_ sender: Any?) {
    let userAge = ageInputTextField.text!
    UserDefaults.standard.set(userAge, forKey: "inputAge")
        showAlert()
    }
}

