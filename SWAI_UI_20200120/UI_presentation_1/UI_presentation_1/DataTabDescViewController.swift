//
//  DataTabDescViewController.swift
//  UI_presentation_1
//
//  Created by WANKI KIM on 2020/01/24.
//  Copyright © 2020 임연지. All rights reserved.
//

import UIKit
import Charts

class DataTabDescViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dataDetailPieChartView: PieChartView!
    @IBOutlet weak var wholeSleepLabel: UILabel!
    @IBOutlet weak var lightSleepLabel: UILabel!
    @IBOutlet weak var deepSleepLabel: UILabel!
    
    var dataDetail: DayData? = nil
    
    var pieChartPart: [String] = ["Light sleep", "Deep sleep"]
    
    var pieChartData: [Double] = [0.0, 0.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        titleLabel.text = dataDetail!.day
    }
    
    override func viewDidAppear(_ animated: Bool) {
        buildUI(data: dataDetail!.sleepData)
        customizePieChart(dataPoints: pieChartPart, values: pieChartData)
        let lightSleepHour = Int(pieChartData[0] / 3600)
        let lightSleepMinute = Int(pieChartData[0] / 60) - lightSleepHour
        let lightSleepSecond = Int(pieChartData[0]) - lightSleepHour - lightSleepMinute
        let deepSleepHour = Int(pieChartData[1] / 3600)
        let deepSleepMinute = Int(pieChartData[1] / 60) - deepSleepHour
        let deepSleepSecond = Int(pieChartData[1]) - deepSleepHour - deepSleepMinute

        lightSleepLabel.text = "\(lightSleepHour)h \(lightSleepMinute)m \(lightSleepSecond)s"
        deepSleepLabel.text = "\(deepSleepHour)h \(deepSleepMinute)m \(deepSleepSecond)s"
    }

    var startingX = 16
    
    func creatingData(widthOfData: CGFloat, dataViewColor: UIColor? ){
        let realWidth = widthOfData
        let dataView: UIView = UIView(frame: CGRect(x: startingX, y: 140, width: Int(realWidth), height: 40))
        dataView.tag = 99
        dataView.backgroundColor = dataViewColor
        self.view.addSubview(dataView)
        startingX += Int(realWidth)
    }
    func buildUI(data: [SleepSoundUnit]){
        var allSecond = 0.0
        for i in 0..<data.count {
            allSecond += (data[i].endedSecond - data[i].startedSecond)
        }
        if allSecond != 0.0 {
            let hour = Int(allSecond / 3600)
            let minute = Int(allSecond / 60) - hour
            let second = Int(allSecond) - hour - minute
            wholeSleepLabel.text = "\(hour)h \(minute)m \(second)s"
            for i in 0..<data.count {
                if data[i].identifier == "snoring" {
                    creatingData(widthOfData: CGFloat((350 / allSecond) * (data[i].endedSecond - data[i].startedSecond)) , dataViewColor: .red)
                    self.pieChartData[1] += (data[i].endedSecond - data[i].startedSecond)
                } else if data[i].identifier == "sleeptalking" {
                    creatingData(widthOfData: CGFloat((350 / allSecond) * (data[i].endedSecond - data[i].startedSecond)) , dataViewColor: .orange)
                    self.pieChartData[0] += (data[i].endedSecond - data[i].startedSecond)
                } else if data[i].identifier == "tortion" {
                    creatingData(widthOfData: CGFloat((350 / allSecond) * (data[i].endedSecond - data[i].startedSecond)) , dataViewColor: .yellow)
                    self.pieChartData[0] += (data[i].endedSecond - data[i].startedSecond)
                } else if data[i].identifier == "breathing" {
                    creatingData(widthOfData: CGFloat((350 / allSecond) * (data[i].endedSecond - data[i].startedSecond)) , dataViewColor: .blue)
                    self.pieChartData[1] += (data[i].endedSecond - data[i].startedSecond)
                }
            }
        }else {
        creatingData(widthOfData: 1, dataViewColor: .black)
        }
        
        startingX = 16
    }

    private func colorsOfPieCharts(numbersOfColor: Int) -> [UIColor] {
        let colors: [UIColor] = [.yellow, .blue]
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
        dataDetailPieChartView.data = pieChartData
    }

}
