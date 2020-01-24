//
//  ViewController.swift
//  UI_presentation_1
//
//  Created by 임연지 on 2020/01/15.
//  Copyright © 2020 임연지. All rights reserved.
//
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var segueIndex = 0
    var index: Int?
    var data =
        [
        ["🙁 날씨?",       "⛳️ Golf",      "🏀 Basketball",    "🏈 American Football",
         "⚾️ Baseball",     "🎾 Tennis",    "🏐 Valleyball",    "🏸 Badminton"],
        ["🍎 Apple",        "🍐 Pear",      "🍓 Strawberry",    "🥑 Avocado",
         "🍌 Banana",       "🍇 Grape",     "🍈 Melon",         "🍊 Orange",
         "🍑 Peach",         "🥝 Kiwi"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibName = UINib(nibName: "CustomCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "customCell")
    }
    @IBAction func switchSegmentedCtrlViewAction(_ sender: UISegmentedControl) {
        self.index = sender.selectedSegmentIndex
        tableView.reloadData()
    }
    
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[self.index ?? 0].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomCell
        let str = data[self.index ?? 0][indexPath.row].components(separatedBy: " ")
        cell.custominit(text: str[1], accessoryText: str[0])
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        segueIndex=indexPath.row
        performSegue(withIdentifier: "datatabsegue", sender: self)
    }
}
