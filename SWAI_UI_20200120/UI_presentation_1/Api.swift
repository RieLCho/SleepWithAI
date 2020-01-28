//
//  Api.swift
//  UI_presentation_1
//
//  Created by 임연지 on 2020/01/26.
//  Copyright © 2020 임연지. All rights reserved.
//

import Foundation

class MyApi: NSObject {
    static let shared = MyApi()

    //비동기 함수에 있는 결과가 완료가 되면 그 완료된 데이터를 다시 알려준다.
    func allMenu(completion: @escaping ([DayData]) -> Void) { //}, onError: @escaping (Error) -> Void) {
        let result = [
            Daydata(day: "2020-01-25")
        ]
        //서버다녀오기나 coreML작업 등 시간이 많이 소요되는 작업을 하면 작업이 끝나고 나서 뷰컨트롤러에 알려줌 다 이런식으로 바꿔서 먼저 작업을 해두자
        completion(result)
    }
}
