//
//  SATScores.swift
//  20180326-BrandonBarooah-NYCSchools
//
//  Created by Brandon Barooah on 3/27/18.
//  Copyright © 2018 personal. All rights reserved.
//

import UIKit

class SATScores: NSObject, Codable {

    var dbn: String?
    var schoolName: String?
    var testTakerCount: String?
    var criticalReadingAvg: String?
    var mathAvg: String?
    var writingAvg: String?
    
    enum CodingKeys: String, CodingKey {
        case dbn
        case schoolName = "school_name"
        case testTakerCount = "num_of_sat_test_takers"
        case criticalReadingAvg = "sat_critical_reading_avg_score"
        case mathAvg = "sat_math_avg_score"
        case writingAvg = "sat_writing_avg_score"
    }
}
