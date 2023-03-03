//
//  THSRDailyTimetableTrainDates.swift
//  Bus
//
//  Created by Machir on 2023/2/25.
//

import Foundation

struct THSRDailyTimetableTrainDates: Codable {
    let StartDate: String
    let EndDate: String
    let TrainDates: [String]
    let UpdateTime: String
}
