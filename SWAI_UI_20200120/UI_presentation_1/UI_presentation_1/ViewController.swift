//
//  ViewController.swift
//  UI_presentation_1
//
//  Created by 임연지 on 2020/01/15.
//  Copyright © 2020 임연지. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    let dates = ["2020/01/15","2020/01/16"," 2020/01/17"]
    let images = ["data1","data2","data3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.dataSource = self
        self.tableview.delegate = self

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var tableview: UITableView!
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FirstCustomCell", for: indexPath) as! FirstCustomCell
        
        cell.DateLabel.text = dates[indexPath.row]
        cell.DateChartImageView.image = UIImage(named: images[indexPath.row])
        return cell
    }
}
extension ViewController: UITableViewDelegate {
    
}
