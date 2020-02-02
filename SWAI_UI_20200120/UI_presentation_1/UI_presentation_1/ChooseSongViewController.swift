//
//  ChooseSongViewController.swift
//  UI_presentation_1
//
//  Created by sheepjin99 on 2020/02/02.
//  Copyright © 2020 임연지. All rights reserved.
//

import Foundation
import UIKit

class ChooseSongViewController: UIViewController{
    
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    
    @IBAction func showAlert() {
        let alertController = UIAlertController(title: "Alarm Sound Changed", message: "Your alarm sound has been changed.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {UIAlertAction in print("Song changed")}))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func firstButtonClicked(_ sender: Any) {
        UserDefaults.standard.set(1, forKey: "song")
        showAlert()
    }
    @IBAction func secondButtonClicked(_ sender: Any) {
        UserDefaults.standard.set(2, forKey: "song")
        showAlert()
    }
    @IBAction func thirdButtonClicked(_ sender: Any) {
        UserDefaults.standard.set(3, forKey: "song")
        showAlert()
    }
    
}
