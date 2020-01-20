//
//  DateAnalysisViewController.swift
//  UI_presentation_1
//
//  Created by 김완기 on 2020/01/16.
//  Copyright © 2020 임연지. All rights reserved.
//

import UIKit

class DateAnalysisViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.dataSource = self
        tableview.delegate = self
        // Do any additional setup after loading the view.
    }
    let dates = ["2020/01/15","2020/01/16"," 2020/01/17"]
    let dateImages = ["data1","data2","data3"]

    
    
}
// table row 갯수 (menu 배열의 갯수만큼)
extension DateAnalysisViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCellWithIdentifier("FirstCustomCell", forIndexPath: indexPath) as! FirstCustomCell

        cell.tvLabel.text = menus[indexPath.row] cell.tvImageView.image = UIImage(named: images[indexPath.row]) return cell }
    }
    
    // 각 row 마다 데이터 세팅.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return dates.count }
    // 첫 번째 인자로 등록한 identifier, cell은 as 키워드로 앞서 만든 custom cell class화 해준다.
    // 위 작업을 마치면 커스텀 클래스의 outlet을 사용할 수 있다.

extension DateAnalysisViewController: UITableViewDelegate{ }


