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

    var appDelegate = UIApplication.shared.delegate as? AppDelegate
    @IBAction func unwindToMain(segue: UIStoryboardSegue) {
    }
    
    @IBAction func HomeSleepNowButtonClicked(_ sender: Any) {
        let allowedTimeError:Int = 60 * 20 //20분을 오차수용범위라 세팅
        let sleepCycle:Int = 5400 //1시간 30분이 한 싸이클
        let currentDate = Date()
        let calendar = Calendar.current
        let currentHour = calendar.component(.hour, from: currentDate)
        let currentMin = calendar.component(.minute, from: currentDate) //현재 시각 받음
        let currentTimeAsSecond = (currentHour*60*60)+(currentMin*60) //00:00부터 현재시각까지의 시간을 초로 합해서 계산함
        let setTime = self.onDidChangeDate(sender: HomeDatePicker) //datepicker에서 바뀐 값 가져옴
        let setHour = Int(setTime[0]) ?? 0 //string 배열로 온 값을 int로 형변환
        let setMin = Int(setTime[1]) ?? 0
        let setTimeAsSecond:Int = (setHour*60*60)+(setMin*60) //00:00부터 datepicker에서 받은 시각까지의 시간을 초로 합해서 계산함.
        
        func isWakeUpTimeSameDay(inputTime:Int, startTime: Int) -> Int {
            var mustWakeUpTime:Int
            if (inputTime == startTime){
                return (60*60*24)
            }
            if (inputTime < startTime){ //다른날이라 다음날로 알람을 넘겨야 됨
                mustWakeUpTime = ((60 * 60 * 24) - startTime) + inputTime
            }
            else{ //같은날이니깐 단순하게 그날 알람 울리면 됨
                mustWakeUpTime = inputTime - startTime
            }
            return mustWakeUpTime
        }
        
        let temp = isWakeUpTimeSameDay(inputTime: setTimeAsSecond, startTime: currentTimeAsSecond)
        
        func cycleDuringSleep(wakeUpTime:Int)->(Int) { //수면시간 취침싸이클 조절
            if (wakeUpTime < allowedTimeError){
                return wakeUpTime
            }
            let leftOverTime = (wakeUpTime % sleepCycle)
            if (leftOverTime <= allowedTimeError){ //셋팅된 시각보다 전에 싸이클이 끝날경우에
                return (wakeUpTime - leftOverTime) //싸이클 맞추기
            }
            else{
                return wakeUpTime
            }
        }

        let mustWakeUpTime = cycleDuringSleep(wakeUpTime: temp)
        print(mustWakeUpTime)
        self.appDelegate?.scheduleNotification(wakeUpTimeSec: Double(mustWakeUpTime))
//        print(temp)
//        self.appDelegate?.scheduleNotification(wakeUpTimeSec: Double(temp)) //cycleduringsleep함수 고치면 지우면됨.
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
        return returnStr
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
