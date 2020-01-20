//
//  ViewController.swift
//  UI_presentation_1
//
//  Created by 임연지 on 2020/01/15.
//  Copyright © 2020 임연지. All rights reserved.
//

import UIKit

struct firstcell {
    var dates: String
    var images: String?
}
class ViewController: UIViewController {
    let test:[firstcell]
        = [
            firstcell(dates: "2020/01/15", images: "data1"),
            firstcell(dates: "2020/01/16", images: "data2"),
            firstcell(dates: "2020/01/17", images: "data3")
    ]
    
    @IBOutlet weak var tableView: UITableView!
    //    let dates = ["2020/01/15","2020/01/16"," 2020/01/17"]
//    let images = ["data1","data2","data3"]
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.test.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FirstCustomCell", for: indexPath) as! FirstCustomCell
        let rowData = self.test[indexPath.row]
        cell.DateLabel.text = rowData.dates
        cell.DateChartImageView.image = UIImage(named: rowData.images!)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
}
