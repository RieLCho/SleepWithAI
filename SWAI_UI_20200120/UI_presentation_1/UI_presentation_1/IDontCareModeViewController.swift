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
    
    var sleepTime:Int = 0
    var userAge:String = ""
    var appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    func IDCNotification(ageAsString:String) -> Int {
        let ageAsInteger = Int(ageAsString) ?? 20
        let sleepCycle:Int = 5400
        var userSleepTime:Int
        let timeToGetSleep:Int = 60 * 20 //잠에 드는 시간
            if (ageAsInteger <= 3){
                userSleepTime = (sleepCycle * 8 + timeToGetSleep)
            }
            else if ((ageAsInteger > 3) && (ageAsInteger <= 6)){
                userSleepTime = (sleepCycle * 7 + timeToGetSleep)
            }
            else if ((ageAsInteger > 6)&&(ageAsInteger <= 14)){
                userSleepTime = (sleepCycle * 6 + timeToGetSleep)
            }
            else if ((ageAsInteger > 14)&&(ageAsInteger <= 18)){
                userSleepTime = (sleepCycle * 6 + timeToGetSleep)
            }
            else if ((ageAsInteger > 18)&&(ageAsInteger <= 26)){
                userSleepTime = (sleepCycle * 6 + timeToGetSleep)
            }
            else if ((ageAsInteger > 26)&&(ageAsInteger <= 64)){
                userSleepTime = (sleepCycle * 5 + timeToGetSleep)
            }
            else{
                userSleepTime = (sleepCycle * 6 + timeToGetSleep)
            }
            print(userSleepTime)
        return userSleepTime
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ageTextField.text = UserDefaults.standard.string(forKey: "inputAge")
        userAge = UserDefaults.standard.string(forKey: "inputAge") ?? "0"
        if(userAge == "0"){
            DispatchQueue.main.async {
            let alert = UIAlertController(title: "Set your Age", message: "You can set your age at Setting. \nWith your age, SWAI can recommend better sleep duration time.", preferredStyle: UIAlertController.Style.alert)
                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//                let defaultAction = UIAlertAction(title: "OK", style: .destructive) { (UIAlertAction) in
//                    performSegue(withIdentifier: "idctohome", sender: IDontCareModeViewController.self)
//                }
            alert.addAction(defaultAction)
            self.present(alert, animated: true)
            }
        }
        else{
        sleepTime = IDCNotification(ageAsString: userAge)
        print(sleepTime)
        }
    }
    
    @IBOutlet weak var ageTextField: UITextField!

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == "iDontCareMode"
            {
                if let destinationVC = segue.destination as? MainModalViewController {
                    destinationVC.sleepTime = sleepTime
                }
            }
    }
    
    @IBAction func IDCModeSleepNowButtonClicked() {
        self.appDelegate?.IDCNotification(ageAsString: ageTextField.text!)
        
    }
}
