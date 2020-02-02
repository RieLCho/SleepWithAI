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
    
    private var dataSourceForWholeData: [DayData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let nibName = UINib(nibName: "CustomCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "customCell")
        //makeWholeData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.dataSource = API.shared.dayData(dayRange: 10)
        self.dataSourceForWholeData = API.shared.dayData(dayRange: 10)
        
        for i in 0..<self.dataSourceForWholeData.count {
            for j in 0..<self.dataSourceForWholeData[i].sleepData.count {
                if self.dataSourceForWholeData[i].sleepData[j].identifier == "snoring" {
                    self.secondsOfIdentifier[0] += (self.dataSourceForWholeData[i].sleepData[j].endedSecond - self.dataSourceForWholeData[i].sleepData[j].startedSecond)
                }else if self.dataSourceForWholeData[i].sleepData[j].identifier == "sleeptalking" {
                    self.secondsOfIdentifier[1] += (self.dataSourceForWholeData[i].sleepData[j].endedSecond - self.dataSourceForWholeData[i].sleepData[j].startedSecond)
                }else if self.dataSourceForWholeData[i].sleepData[j].identifier == "breathing" {
                    self.secondsOfIdentifier[3] += (self.dataSourceForWholeData[i].sleepData[j].endedSecond - self.dataSourceForWholeData[i].sleepData[j].startedSecond)
                }else {
                    print("error")
                }
            }
        }
        
        customizePieChart(dataPoints: identifier, values: secondsOfIdentifier)

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
    
    private func colorsOfPieCharts(numbersOfColor: Int) -> [UIColor] {
        let colors: [UIColor] = [colorOfSnoringData,colorOfSleeptalkingData,colorOfBackgroundData]
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "datatabsegue" {
            let data = sender as? DayData
            if data != nil {
                let detailController = segue.destination as?  DataTabDescViewController
                if detailController != nil {
                    detailController!.dataDetail = data
                }
            }
        }
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
        performSegue(withIdentifier: "datatabsegue", sender: self.dataSource[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView,heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

}
