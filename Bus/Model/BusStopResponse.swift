//
//  BusStopResponse.swift
//  Bus
//
//  Created by Machir on 2022/9/11.
//

import Foundation

struct BusStopResponse: Codable {
    let StopUID: String
    let StopID: String
    let AuthorityID: String
    let StopName: StopNameType
    let StopPosition: StopPositionType
    let StopAddress: String
    let StationID: String
    let UpdateTime: String
    let VersionID: Int
    
    struct StopNameType: Codable {
        let Zh_tw: String
        let En: String
    }
    
    struct StopPositionType: Codable {
        let PositionLon: Double
        let PositionLat: Double
        let GeoHash: String
    }

}
