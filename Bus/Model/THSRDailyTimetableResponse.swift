//
//  THSRDailyTimetableResponse.swift
//  Bus
//
//  Created by Machir on 2023/1/28.
//

import Foundation

struct THSRDailyTimetableResponse: Codable {
    let TrainDate: String
    let DailyTrainInfo: DailyTrainInfoDetail
    let OriginStopTime: OriginStopTimeDetail
    let DestinationStopTime: DestinationStopTimeDetail
    let UpdateTime: String
    let VersionID: String
    
    struct DailyTrainInfoDetail: Codable {
        let TrainNo: String
        let Direction: Int
        let StartingStationID: String
        let StartingStationName: StartingStationNameDetail
        let EndingStationID: String
        let EndingStationName: EndingStationNameDetail
        let Note: NoteDetail
    }
    
    struct StartingStationNameDetail: Codable {
        let Zh_tw: String
        let En: String
    }
    
    struct EndingStationNameDetail: Codable {
        let Zh_tw: String
        let En: String
    }
    
    struct NoteDetail: Codable {
        let Zh_tw: String?
        let En: String?
    }
    
    struct OriginStopTimeDetail: Codable {
        let StopSequence: Int
        let StationID: String
        let StationName: StationNameDetail
        let ArrivalTime: String
        let DepartureTime: String
    }
    
    struct StationNameDetail: Codable {
        let Zh_tw: String
        let En: String
    }
    
    struct DestinationStopTimeDetail: Codable {
        let StopSequence: Int
        let StationID: String
        let StationName: StationNameDeatil
        let ArrivalTime: String
        let DepartureTime: String
    }
    
    struct StationNameDeatil: Codable {
        let Zh_tw: String
        let En: String
    }
    
}
