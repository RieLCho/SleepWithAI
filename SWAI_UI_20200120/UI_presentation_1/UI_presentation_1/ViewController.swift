//
//  ViewController.swift
//  UI_presentation_1
//
//  Created by 임연지 on 2020/01/15.
//  Copyright © 2020 임연지. All rights reserved.
//
import UIKit
import Charts

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var wholeDataChartView: PieChartView!
    @IBOutlet weak var backgroundView: UIView!
    
    var segueIndex = 0
    var index: Int?
    
    var secondsOfIdentifier = [1.0, 1.0, 1.0, 1.0]
    
    private var dataSource:[DayData] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let nibName = UINib(nibName: "CustomCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "customCell")
        makeWholeData()
        customizePieChart(dataPoints: wholeData.identifier, values: secondsOfIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.dataSource = API.shared.dayData(dayRange: 10)
    }
    
    
    
    @IBAction func switchSegmentedCtrlViewAction(_ sender: UISegmentedControl) {
        //self.index = sender.selectedSegmentIndex
        //tableView.reloadData()
        if sender.selectedSegmentIndex == 1 {
            self.view.bringSubviewToFront(backgroundView)
            self.view.bringSubviewToFront(wholeDataChartView)
        } else {
            self.view.bringSubviewToFront(tableView)
        }
    }
    
    func makeWholeData() {
        let allDayData = self.dataSource
        //print(self.dataSource.count)
        
        /*for j in 0..<allDayData.count {
            for i in 0..<allDayData[j].sleepData.count {
                if allDayData[j].sleepData[i].identifier == "snoring" {
                    self.wholeData.secondsOfIdentifier[0] += (allDayData[j].sleepData[i].endedSecond - allDayData[j].sleepData[i].startedSecond)
                    //print("OK")
                    
                } else if allDayData[j].sleepData[i].identifier == "sleeptalking" {
                    self.wholeData.secondsOfIdentifier[1] += (allDayData[j].sleepData[i].endedSecond - allDayData[j].sleepData[i].startedSecond)
                    
                } else if allDayData[j].sleepData[i].identifier == "tortion" {
                    self.wholeData.secondsOfIdentifier[2] += (allDayData[j].sleepData[i].endedSecond - allDayData[j].sleepData[i].startedSecond)
                
                } else if allDayData[j].sleepData[i].identifier == "breathing" {
                    self.wholeData.secondsOfIdentifier[3] += (allDayData[j].sleepData[i].endedSecond - allDayData[j].sleepData[i].startedSecond)
                
                } else{
                    print("error")
                }
            }
        }*/
    }
    
    private func colorsOfPieCharts(numbersOfColor: Int) -> [UIColor] {
        let colors: [UIColor] = [.red, .orange, .yellow, .blue]
        /*for _ in 0..<numbersOfColor {
          let red = Double(arc4random_uniform(256))
          let green = Double(arc4random_uniform(256))
          let blue = Double(arc4random_uniform(256))
          let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
          colors.append(color)
        }*/
        return colors
    }
        
    func customizePieChart(dataPoints: [String], values: [Double]) {
          // TO-DO: customize the chart here
            // 1. Set ChartDataEntry
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
        }
        // 2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        pieChartDataSet.colors = colorsOfPieCharts(numbersOfColor: dataPoints.count)
        // 3. Set ChartData
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        // 4. Assign it to the chart’s data
        wholeDataChartView.data = pieChartData
    }

}
    
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return data[self.index ?? 0].count
        return self.dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomCell
        
        //let str = data[self.index ?? 0][indexPath.row].components(separatedBy: " ")
        //cell.custominit(text: str[1], accessoryText: str[0])
        cell.prepareForReuse()
        cell.titleLabel.text = self.dataSource[indexPath.row].day
        cell.buildUI(data: self.dataSource[indexPath.row].sleepData)
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        segueIndex=indexPath.row
        performSegue(withIdentifier: "datatabsegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView,heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

}
