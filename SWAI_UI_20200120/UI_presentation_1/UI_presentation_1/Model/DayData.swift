//
//  DayData.swift
//  UI_presentation_1
//
//  Created by WANKI KIM on 2020/02/01.
//  Copyright © 2020 임연지. All rights reserved.
//

import Foundation
import UIKit

struct DayData: Hashable {
    var day: String
    var sleepData: [SleepSoundUnit]
}

let colorOfSnoringData = UIColor(red: 255/255, green: 151/255, blue: 133/255, alpha: 1)
let colorOfSleeptalkingData = UIColor(red: 226/255, green: 81/255, blue: 133/255, alpha: 1)
let colorOfBackgroundData = UIColor(red: 255/255, green: 212/255, blue: 121/255, alpha: 1)
let colorOfLightSleepData = UIColor(displayP3Red: 114/255, green: 167/255, blue: 255/255, alpha: 1)
let colorOfDeepSleepData = UIColor(displayP3Red: 114/255, green: 17/255, blue: 255/255, alpha: 1)

let identifier = ["snoring","sleeptalking","breaking"]
