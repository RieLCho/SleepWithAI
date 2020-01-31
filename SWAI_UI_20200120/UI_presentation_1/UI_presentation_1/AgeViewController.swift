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
    
    @IBOutlet weak var settedUserAgeLabel: UILabel!
    
    @IBOutlet weak var ageInputSaveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super .viewDidLoad()
        ageInputTextField.placeholder = agePlaceholder
    }
    
@IBAction func showAlert() {
        // UIAlertController를 생성해야 한다. style은 .alert로 해준다.
        let alertController = UIAlertController(title: "User Age Saved!", message: "Your age has been saved.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {UIAlertAction in print("Age Saved")}))
        self.present(alertController, animated: true, completion: nil)
    }
    
@IBAction func ageInputSaveButtonClicked(_ sender: Any?) {
        let userAge = ageInputTextField.text
        showAlert()
        ageInputTextField.placeholder = userAge
        agePlaceholder = userAge!
    }
}

