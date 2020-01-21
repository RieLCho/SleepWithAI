//
//  MainViewController.swift
//  UI_presentation_1
//
//  Created by 임연지 on 2020/01/21.
//  Copyright © 2020 임연지. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //카이틀 속성설정
        let title = UILabel()
        title.text = "Sleep With AI"
        //title.textAlignment = .left
        title.textColor = UIColor.white
        //title.frame.origin.x = self.view.frame.width - title.frame.width

        if let font = UIFont(name:"Chalkduster" , size: 35) {
                
            let fontMetrics = UIFontMetrics(forTextStyle: .body)
            title.font = fontMetrics.scaledFont(for: font)
        }
        //만들어진 타이틀 레이블을 네비게이션바 안에 들어가게함
        self.navigationItem.titleView = title
        
        //타이틀뷰의 위치를 왼쪽으로 조정하고 싶었지만 되지 않는 코드
        if let titleView = self.navigationItem.titleView{
            titleView.frame.origin.x = self.view.frame.width - titleView.frame.width
        }


        // Do any additional setup after loading the view.
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
