//
//  ViewController.swift
//  CustomTableView
//
//  Created by dgulinc on 2020/01/09.
//  Copyright © 2020 dgulinc. All rights reserved.
//

import UIKit

struct AlarmTime {
    var day: String
    var timeMin: Int
    var timeSec: Int
}

class ViewController: UIViewController {

    let timeSet:[AlarmTime] = [
        AlarmTime(day: "월요일", timeMin: 07, timeSec: 30),
        AlarmTime(day: "화요일", timeMin: 07, timeSec: 40),
        AlarmTime(day: "수요일", timeMin: 08, timeSec: 50),
        AlarmTime(day: "목요일", timeMin: 09, timeSec: 00),
        AlarmTime(day: "금요일", timeMin: 10, timeSec: 10),
        AlarmTime(day: "토요일", timeMin: 09, timeSec: 20),
        AlarmTime(day: "일요일", timeMin: 08, timeSec: 30)
    ]
    
    @IBOutlet weak var timeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeTableView.dataSource = self
        timeTableView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "timeDetail" {
            let time = sender as? AlarmTime
            if time != nil {
                let detailController = segue.destination as? TimeDetailViewControllerViewController
                if detailController != nil {
                    detailController?.timeDetail = time
                }
            }
        }
    }
    
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.timeSet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlarmTimeCell", for: indexPath) as! AlarmTimeCell //cell을 alram뭐시기 셀로 취급해줘라라는 뜻
        let rowData = self.timeSet[indexPath.row]
        cell.dayLabel.text = rowData.day
        cell.timeLabel.text = "\(rowData.timeMin):\(rowData.timeSec)"
        return cell
    }
    
    
    
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "timeDetail", sender: self.timeSet[indexPath.row])
    }
}
