//
//  THSROToDFareResponse.swift
//  Bus
//
//  Created by Machir on 2023/3/1.
//

import Foundation

struct THSROToDFareResponse: Codable {
    let OriginStationID: String
    let OriginStationName: OriginStationNameDetail
    let DestinationStationID: String
    let DestinationStationName: DestinationStationNameDetail
    let Direction: Int
    let Fares: [FaresDetail]
    let SrcUpdateTime: String
    let UpdateTime: String
    let VersionID: Int
}

struct OriginStationNameDetail: Codable {
    let Zh_tw: String
    let En: String
}

struct DestinationStationNameDetail: Codable {
    let Zh_tw: String
    let En: String
}

struct FaresDetail: Codable {
    let TicketType: Int
    let FareClass: Int
    let CabinClass: Int
    let Price: Int
}

/*
 [
   {
     "OriginStationID": "1000",
     "OriginStationName": {
       "Zh_tw": "台北",
       "En": "Taipei"
     },
     "DestinationStationID": "1060",
     "DestinationStationName": {
       "Zh_tw": "台南",
       "En": "Tainan"
     },
     "Direction": 0,
     "Fares": [
       {
         "TicketType": 1,
         "FareClass": 1,
         "CabinClass": 1,
         "Price": 1350
       },
       {
         "TicketType": 1,
         "FareClass": 1,
         "CabinClass": 2,
         "Price": 2230
       },
       {
         "TicketType": 1,
         "FareClass": 1,
         "CabinClass": 3,
         "Price": 1305
       },
       {
         "TicketType": 1,
         "FareClass": 9,
         "CabinClass": 1,
         "Price": 675
       },
       {
         "TicketType": 1,
         "FareClass": 9,
         "CabinClass": 2,
         "Price": 1115
       },
       {
         "TicketType": 1,
         "FareClass": 9,
         "CabinClass": 3,
         "Price": 650
       },
       {
         "TicketType": 8,
         "FareClass": 1,
         "CabinClass": 1,
         "Price": 1280
       },
       {
         "TicketType": 8,
         "FareClass": 1,
         "CabinClass": 2,
         "Price": 2115
       }
     ],
     "SrcUpdateTime": "2022-03-14T14:59:47+08:00",
     "UpdateTime": "2022-11-03T10:19:52+08:00",
     "VersionID": 10
   }
 ]
 */
