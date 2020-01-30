//
//  SleepSoundUnitDB.swift
//  UI_presentation_1
//
//  Created by WANKI KIM on 2020/01/30.
//  Copyright © 2020 임연지. All rights reserved.
//

import Foundation
import RealmSwift
class SleepSoundUnitDB : Object{
    @objc dynamic var identifier: String = ""
    @objc dynamic var confidence: Double = 0
    @objc dynamic var startedSecond: Double = 0
    @objc dynamic var endedSecond: Double = 0
    
    init(identifier:String, confidence:Double, startedSecond:Double, endedSecond:Double) {
        self.identifier = identifier
        self.confidence = confidence
        self.startedSecond = startedSecond
        self.endedSecond = endedSecond
    }
    
    required init() {
        super.init()
    }
}
