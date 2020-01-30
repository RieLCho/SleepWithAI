//
//  MainViewController.swift
//  UI_presentation_1
//
//  Created by 임연지 on 2020/01/21.
//  Copyright © 2020 임연지. All rights reserved.
//

import UIKit
import UserNotifications

class MainViewController: UIViewController {

    @IBAction func unwindToMain(segue: UIStoryboardSegue) {
    }
    
    @IBOutlet weak var HomeDatePicker: UIDatePicker!
    
    @IBOutlet weak var HomeTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        HomeDatePicker.timeZone = NSTimeZone.local
//        HomeDatePicker.layer.cornerRadius = 5.0
//        HomeDatePicker.layer.shadowOpacity = 0.5
//        HomeDatePicker.backgroundColor = UIColor.yellow
        HomeDatePicker.addTarget(self, action: #selector(onDidChangeDate(sender:)), for: .valueChanged)
    }
    
   @objc func onDidChangeDate(sender: UIDatePicker)->([String]){ // Generate the format.
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a" // Obtain the date according to the format.
        let selectedDate: String = dateFormatter.string(from: sender.date)
        let str = selectedDate.components(separatedBy: " ")
        let ampm = str[1]
        let time = str[0]
        let realTime = time.components(separatedBy: ":")
        let hour:String = realTime[0]
        let minute:String = realTime[1]
//        if hour == "12" && ampm == "AM"
//        {
//            hour = "00"
//        }
        self.HomeTextField.text =  hour + " " + ":" + " " + minute + " " + ampm
        //함수 반환으로 24시간으로 계산된 시각과 분 전달.
        let returnDateFormatter: DateFormatter = DateFormatter()
        returnDateFormatter.dateFormat = "kk mm"
        let returnSelectedDate: String = returnDateFormatter.string(from: sender.date)
        let returnStr = returnSelectedDate.components(separatedBy: " ")
//        let returnHour = Int(returnStr[0]) ?? 0
//        let returnMin = Int(returnStr[1]) ?? 0
        print(returnStr)
        return returnStr
    }

    

    @IBAction func HomeSleepNowButtonClicked(_ sender: Any) {
       
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
