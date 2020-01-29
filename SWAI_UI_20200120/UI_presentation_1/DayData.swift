//
//  DayData.swift
//  MakingDayDataView
//
//  Created by 임연지 on 2020/01/29.
//  Copyright © 2020 임연지. All rights reserved.
//

import Foundation

struct SleepSoundUnit {
    var identifier: String
    var startedSecond: Double
    var endedSecond: Double
}

let recorded:[SleepSoundUnit] = [
    SleepSoundUnit(identifier: "sleeptalking", startedSecond: 1.5425396825396824, endedSecond: 8.855034013605442),
    SleepSoundUnit(identifier: "snoring", startedSecond: 8.855034013605442, endedSecond: 9.342539682539682),
    SleepSoundUnit(identifier: "tortion", startedSecond: 9.342539682539682, endedSecond: 10.805034013605443),
    SleepSoundUnit(identifier: "breathing", startedSecond: 10.805034013605443, endedSecond: 13.730045351473922),
    SleepSoundUnit(identifier: "sleeptalking", startedSecond: 13.730045351473922, endedSecond: 14.217551020408163),
    SleepSoundUnit(identifier: "snoring", startedSecond: 14.217551020408163, endedSecond: 15.680045351473924)
]


