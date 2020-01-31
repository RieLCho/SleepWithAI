//
//  IDontCareModeViewController.swift
//  UI_presentation_1
//
//  Created by sheepjin99 on 2020/01/31.
//  Copyright © 2020 임연지. All rights reserved.
//

import UIKit
import Foundation


class IDontCareModeViewController: UIViewController {
    
    var appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ageTextField.text = UserDefaults.standard.string(forKey: "inputAge")
    }
    
    
    @IBOutlet weak var ageTextField: UITextField!

    
    @IBAction func IDCModeSleepNowButtonClicked() {
        self.appDelegate?.IDCNotification(ageAsString: ageTextField.text!)
        
    }
}
