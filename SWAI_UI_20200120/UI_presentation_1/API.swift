//
//  API.swift
//  UI_presentation_1
//
//  Created by WANKI KIM on 2020/02/01.
//  Copyright © 2020 임연지. All rights reserved.
//

import Foundation
import RealmSwift

class API: NSObject {
    static let shared = API()
    
    fileprivate let realm:Realm = try! Realm()
    
    var dateFormatter:DateFormatter {
        let today = DateFormatter()
        today.dateFormat = "yyyy-MM-dd"
        today.timeZone = TimeZone.autoupdatingCurrent
        today.locale = Locale.current
        return today
    }
    //var temp: Int
    
    func dayData(dayRange: Int) -> [DayData] {
        var result:[DayData] = []
        // 1. day 라벨에 쓸 날짜 배열
        guard let recent = self.realm.objects(SleepSoundUnitDB.self).sorted(byKeyPath: "sleepDate", ascending: false).first?.sleepDate else {
            return []
        }
        let recentDate = ((dateFormatter.date(from: recent)) ?? (Date() - 86400)) + 9*60*60
        var days:[Date] = []
        
        var start:Date = recentDate
        for _ in 1...dayRange {
            days.append(start)
            start -= 86400
        }
        // 2. (1) 에 맞는 SleepUnitRealm 받아와서 SleepSoundUnit 으로 변환
        
        for day in days {
            let dayString = dateFormatter.string(from: day)
            let units:[SleepSoundUnit] = realm
                .objects(SleepSoundUnitDB.self).filter("sleepDate = '\(dayString)'").sorted(byKeyPath: "date", ascending: true)
                .map { SleepSoundUnit(identifier: $0.identifier, startedSecond: $0.startedSecond, endedSecond: $0.endedSecond) }
            // 3. (1) + (2) 로 DayData 생성 및 append()
            
            result.append(DayData(day: dayString, sleepData: units))
        }
        return result
    }
}
