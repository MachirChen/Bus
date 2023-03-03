//
//  THSRDailyTimeTableStationToStationResponse.swift
//  Bus
//
//  Created by Machir on 2023/2/26.
//

import Foundation

struct THSRDailyTimetableOToDResponse: Codable {
    let TrainDate: String
    let DailyTrainInfo: DailyTrainInfoDetail
    let OriginStopTime: OriginStopTimeDetail
    let DestinationStopTime: DestinationStopTimeDetail
    let UpdateTime: String
    let VersionID: Int
}

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
    let StationName: StationNameDetail
    let ArrivalTime: String
    let DepartureTime: String
}

/*
[
  {
    "TrainDate": "string",
    "DailyTrainInfo": {
      "TrainNo": "string",
      "Direction": 0,
      "StartingStationID": "string",
      "StartingStationName": {
        "Zh_tw": "string",
        "En": "string"
      },
      "EndingStationID": "string",
      "EndingStationName": {
        "Zh_tw": "string",
        "En": "string"
      },
      "Note": {
        "Zh_tw": "string",
        "En": "string"
      }
    },
 
 
    "OriginStopTime": {
      "StopSequence": 0,
      "StationID": "string",
      "StationName": {
        "Zh_tw": "string",
        "En": "string"
      },
      "ArrivalTime": "string",
      "DepartureTime": "string"
    },
 
 
 
 
 
    "DestinationStopTime": {
      "StopSequence": 0,
      "StationID": "string",
      "StationName": {
        "Zh_tw": "string",
        "En": "string"
      },
      "ArrivalTime": "string",
      "DepartureTime": "string"
    },
    "UpdateTime": "2023-02-26T09:54:39.949Z",
    "VersionID": 0
  }
]
*/


//[Bus.THSRDailyTimetableOToDResponse(TrainDate: "2023-02-27", DailyTrainInfo: Bus.DailyTrainInfoDetail(TrainNo: "0249", Direction: 0, StartingStationID: "0990", StartingStationName: Bus.StartingStationNameDetail(Zh_tw: "南港", En: "Nangang"), EndingStationID: "1070", EndingStationName: Bus.EndingStationNameDetail(Zh_tw: "左營", En: "Zuoying"), Note: Bus.NoteDetail(Zh_tw: nil, En: nil)), OriginStopTime: Bus.OriginStopTimeDetail(StopSequence: 1, StationID: "0990", StationName: Bus.StationNameDetail(Zh_tw: "南港", En: "Nangang"), ArrivalTime: "18:40", DepartureTime: "18:40"), DestinationStopTime: Bus.DestinationStopTimeDetail(StopSequence: 6, StationID: "1070", StationName: Bus.StationNameDetail(Zh_tw: "左營", En: "Zuoying"), ArrivalTime: "20:30", DepartureTime: "20:30"), UpdateTime: "2023-01-27T02:46:52+08:00", VersionID: 1), Bus.THSRDailyTimetableOToDResponse(TrainDate: "2023-02-27", DailyTrainInfo: Bus.DailyTrainInfoDetail(TrainNo: "0853", Direction: 0, StartingStationID: "0990", StartingStationName: Bus.StartingStationNameDetail(Zh_tw: "南港", En: "Nangang"), EndingStationID: "1070", EndingStationName: Bus.EndingStationNameDetail(Zh_tw: "左營", En: "Zuoying"), Note: Bus.NoteDetail(Zh_tw: nil, En: nil)), OriginStopTime: Bus.OriginStopTimeDetail(StopSequence: 1, StationID: "0990", StationName: Bus.StationNameDetail(Zh_tw: "南港", En: "Nangang"), ArrivalTime: "19:00", DepartureTime: "19:00"), DestinationStopTime: Bus.DestinationStopTimeDetail(StopSequence: 12, StationID: "1070", StationName: Bus.StationNameDetail(Zh_tw: "左營", En: "Zuoying"), ArrivalTime: "21:25", DepartureTime: "21:25"), UpdateTime: "2023-01-27T02:46:52+08:00", VersionID: 1), Bus.THSRDailyTimetableOToDResponse(TrainDate: "2023-02-27", DailyTrainInfo: Bus.DailyTrainInfoDetail(TrainNo: "1679", Direction: 0, StartingStationID: "0990", StartingStationName: Bus.StartingStationNameDetail(Zh_tw: "南港", En: "Nangang"), EndingStationID: "1070", EndingStationName: Bus.EndingStationNameDetail(Zh_tw: "左營", En: "Zuoying"), Note: Bus.NoteDetail(Zh_tw: nil, En: nil)), OriginStopTime: Bus.OriginStopTimeDetail(StopSequence: 1, StationID: "0990", StationName: Bus.StationNameDetail(Zh_tw: "南港", En: "Nangang"), ArrivalTime: "19:10", DepartureTime: "19:10"), DestinationStopTime: Bus.DestinationStopTimeDetail(StopSequence: 9, StationID: "1070", StationName: Bus.StationNameDetail(Zh_tw: "左營", En: "Zuoying"), ArrivalTime: "21:20", DepartureTime: "21:20"), UpdateTime: "2023-01-27T02:46:52+08:00", VersionID: 1), Bus.THSRDailyTimetableOToDResponse(TrainDate: "2023-02-27", DailyTrainInfo: Bus.DailyTrainInfoDetail(TrainNo: "0157", Direction: 0, StartingStationID: "0990", StartingStationName: Bus.StartingStationNameDetail(Zh_tw: "南港", En: "Nangang"), EndingStationID: "1070", EndingStationName: Bus.EndingStationNameDetail(Zh_tw: "左營", En: "Zuoying"), Note: Bus.NoteDetail(Zh_tw: nil, En: nil)), OriginStopTime: Bus.OriginStopTimeDetail(StopSequence: 1, StationID: "0990", StationName: Bus.StationNameDetail(Zh_tw: "南港", En: "Nangang"), ArrivalTime: "19:20", DepartureTime: "19:20"), DestinationStopTime: Bus.DestinationStopTimeDetail(StopSequence: 5, StationID: "1070", StationName: Bus.StationNameDetail(Zh_tw: "左營", En: "Zuoying"), ArrivalTime: "21:05", DepartureTime: "21:05"), UpdateTime: "2023-01-27T02:46:52+08:00", VersionID: 1), Bus.THSRDailyTimetableOToDResponse(TrainDate: "2023-02-27", DailyTrainInfo: Bus.DailyTrainInfoDetail(TrainNo: "0681", Direction: 0, StartingStationID: "0990", StartingStationName: Bus.StartingStationNameDetail(Zh_tw: "南港", En: "Nangang"), EndingStationID: "1070", EndingStationName: Bus.EndingStationNameDetail(Zh_tw: "左營", En: "Zuoying"), Note: Bus.NoteDetail(Zh_tw: nil, En: nil)), OriginStopTime: Bus.OriginStopTimeDetail(StopSequence: 1, StationID: "0990", StationName: Bus.StationNameDetail(Zh_tw: "南港", En: "Nangang"), ArrivalTime: "19:35", DepartureTime: "19:35"), DestinationStopTime: Bus.DestinationStopTimeDetail(StopSequence: 9, StationID: "1070", StationName: Bus.StationNameDetail(Zh_tw: "左營", En: "Zuoying"), ArrivalTime: "21:45", DepartureTime: "21:45"), UpdateTime: "2023-01-27T02:46:52+08:00", VersionID: 1), Bus.THSRDailyTimetableOToDResponse(TrainDate: "2023-02-27", DailyTrainInfo: Bus.DailyTrainInfoDetail(TrainNo: "1253", Direction: 0, StartingStationID: "0990", StartingStationName: Bus.StartingStationNameDetail(Zh_tw: "南港", En: "Nangang"), EndingStationID: "1070", EndingStationName: Bus.EndingStationNameDetail(Zh_tw: "左營", En: "Zuoying"), Note: Bus.NoteDetail(Zh_tw: nil, En: nil)), OriginStopTime: Bus.OriginStopTimeDetail(StopSequence: 1, StationID: "0990", StationName: Bus.StationNameDetail(Zh_tw: "南港", En: "Nangang"), ArrivalTime: "19:40", DepartureTime: "19:40"), DestinationStopTime: Bus.DestinationStopTimeDetail(StopSequence: 6, StationID: "1070", StationName: Bus.StationNameDetail(Zh_tw: "左營", En: "Zuoying"), ArrivalTime: "21:30", DepartureTime: "21:30"), UpdateTime: "2023-01-27T02:46:52+08:00", VersionID: 1), Bus.THSRDailyTimetableOToDResponse(TrainDate: "2023-02-27", DailyTrainInfo: Bus.DailyTrainInfoDetail(TrainNo: "0857", Direction: 0, StartingStationID: "0990", StartingStationName: Bus.StartingStationNameDetail(Zh_tw: "南港", En: "Nangang"), EndingStationID: "1070", EndingStationName: Bus.EndingStationNameDetail(Zh_tw: "左營", En: "Zuoying"), Note: Bus.NoteDetail(Zh_tw: nil, En: nil)), OriginStopTime: Bus.OriginStopTimeDetail(StopSequence: 1, StationID: "0990", StationName: Bus.StationNameDetail(Zh_tw: "南港", En: "Nangang"), ArrivalTime: "20:00", DepartureTime: "20:00"), DestinationStopTime: Bus.DestinationStopTimeDetail(StopSequence: 12, StationID: "1070", StationName: Bus.StationNameDetail(Zh_tw: "左營", En: "Zuoying"), ArrivalTime: "22:25", DepartureTime: "22:25"), UpdateTime: "2023-01-27T02:46:52+08:00", VersionID: 1), Bus.THSRDailyTimetableOToDResponse(TrainDate: "2023-02-27", DailyTrainInfo: Bus.DailyTrainInfoDetail(TrainNo: "1685", Direction: 0, StartingStationID: "0990", StartingStationName: Bus.StartingStationNameDetail(Zh_tw: "南港", En: "Nangang"), EndingStationID: "1070", EndingStationName: Bus.EndingStationNameDetail(Zh_tw: "左營", En: "Zuoying"), Note: Bus.NoteDetail(Zh_tw: nil, En: nil)), OriginStopTime: Bus.OriginStopTimeDetail(StopSequence: 1, StationID: "0990", StationName: Bus.StationNameDetail(Zh_tw: "南港", En: "Nangang"), ArrivalTime: "20:10", DepartureTime: "20:10"), DestinationStopTime: Bus.DestinationStopTimeDetail(StopSequence: 9, StationID: "1070", StationName: Bus.StationNameDetail(Zh_tw: "左營", En: "Zuoying"), ArrivalTime: "22:20", DepartureTime: "22:20"), UpdateTime: "2023-01-27T02:46:52+08:00", VersionID: 1), Bus.THSRDailyTimetableOToDResponse(TrainDate: "2023-02-27", DailyTrainInfo: Bus.DailyTrainInfoDetail(TrainNo: "0161", Direction: 0, StartingStationID: "0990", StartingStationName: Bus.StartingStationNameDetail(Zh_tw: "南港", En: "Nangang"), EndingStationID: "1070", EndingStationName: Bus.EndingStationNameDetail(Zh_tw: "左營", En: "Zuoying"), Note: Bus.NoteDetail(Zh_tw: nil, En: nil)), OriginStopTime: Bus.OriginStopTimeDetail(StopSequence: 1, StationID: "0990", StationName: Bus.StationNameDetail(Zh_tw: "南港", En: "Nangang"), ArrivalTime: "20:20", DepartureTime: "20:20"), DestinationStopTime: Bus.DestinationStopTimeDetail(StopSequence: 5, StationID: "1070", StationName: Bus.StationNameDetail(Zh_tw: "左營", En: "Zuoying"), ArrivalTime: "22:05", DepartureTime: "22:05"), UpdateTime: "2023-01-27T02:46:52+08:00", VersionID: 1), Bus.THSRDailyTimetableOToDResponse(TrainDate: "2023-02-27", DailyTrainInfo: Bus.DailyTrainInfoDetail(TrainNo: "0687", Direction: 0, StartingStationID: "0990", StartingStationName: Bus.StartingStationNameDetail(Zh_tw: "南港", En: "Nangang"), EndingStationID: "1070", EndingStationName: Bus.EndingStationNameDetail(Zh_tw: "左營", En: "Zuoying"), Note: Bus.NoteDetail(Zh_tw: nil, En: nil)), OriginStopTime: Bus.OriginStopTimeDetail(StopSequence: 1, StationID: "0990", StationName: Bus.StationNameDetail(Zh_tw: "南港", En: "Nangang"), ArrivalTime: "20:35", DepartureTime: "20:35"), DestinationStopTime: Bus.DestinationStopTimeDetail(StopSequence: 9, StationID: "1070", StationName: Bus.StationNameDetail(Zh_tw: "左營", En: "Zuoying"), ArrivalTime: "22:45", DepartureTime: "22:45"), UpdateTime: "2023-01-27T02:46:52+08:00", VersionID: 1), Bus.THSRDailyTimetableOToDResponse(TrainDate: "2023-02-27", DailyTrainInfo: Bus.DailyTrainInfoDetail(TrainNo: "1257", Direction: 0, StartingStationID: "0990", StartingStationName: Bus.StartingStationNameDetail(Zh_tw: "南港", En: "Nangang"), EndingStationID: "1070", EndingStationName: Bus.EndingStationNameDetail(Zh_tw: "左營", En: "Zuoying"), Note: Bus.NoteDetail(Zh_tw: nil, En: nil)), OriginStopTime: Bus.OriginStopTimeDetail(StopSequence: 1, StationID: "0990", StationName: Bus.StationNameDetail(Zh_tw: "南港", En: "Nangang"), ArrivalTime: "20:40", DepartureTime: "20:40"), DestinationStopTime: Bus.DestinationStopTimeDetail(StopSequence: 6, StationID: "1070", StationName: Bus.StationNameDetail(Zh_tw: "左營", En: "Zuoying"), ArrivalTime: "22:30", DepartureTime: "22:30"), UpdateTime: "2023-01-27T02:46:52+08:00", VersionID: 1), Bus.THSRDailyTimetableOToDResponse(TrainDate: "2023-02-27", DailyTrainInfo: Bus.DailyTrainInfoDetail(TrainNo: "0861", Direction: 0, StartingStationID: "0990", StartingStationName: Bus.StartingStationNameDetail(Zh_tw: "南港", En: "Nangang"), EndingStationID: "1070", EndingStationName: Bus.EndingStationNameDetail(Zh_tw: "左營", En: "Zuoying"), Note: Bus.NoteDetail(Zh_tw: nil, En: nil)), OriginStopTime: Bus.OriginStopTimeDetail(StopSequence: 1, StationID: "0990", StationName: Bus.StationNameDetail(Zh_tw: "南港", En: "Nangang"), ArrivalTime: "21:00", DepartureTime: "21:00"), DestinationStopTime: Bus.DestinationStopTimeDetail(StopSequence: 12, StationID: "1070", StationName: Bus.StationNameDetail(Zh_tw: "左營", En: "Zuoying"), ArrivalTime: "23:25", DepartureTime: "23:25"), UpdateTime: "2023-01-27T02:46:52+08:00", VersionID: 1), Bus.THSRDailyTimetableOToDResponse(TrainDate: "2023-02-27", DailyTrainInfo: Bus.DailyTrainInfoDetail(TrainNo: "0165", Direction: 0, StartingStationID: "0990", StartingStationName: Bus.StartingStationNameDetail(Zh_tw: "南港", En: "Nangang"), EndingStationID: "1070", EndingStationName: Bus.EndingStationNameDetail(Zh_tw: "左營", En: "Zuoying"), Note: Bus.NoteDetail(Zh_tw: nil, En: nil)), OriginStopTime: Bus.OriginStopTimeDetail(StopSequence: 1, StationID: "0990", StationName: Bus.StationNameDetail(Zh_tw: "南港", En: "Nangang"), ArrivalTime: "21:20", DepartureTime: "21:20"), DestinationStopTime: Bus.DestinationStopTimeDetail(StopSequence: 5, StationID: "1070", StationName: Bus.StationNameDetail(Zh_tw: "左營", En: "Zuoying"), ArrivalTime: "23:05", DepartureTime: "23:05"), UpdateTime: "2023-01-27T02:46:52+08:00", VersionID: 1), Bus.THSRDailyTimetableOToDResponse(TrainDate: "2023-02-27", DailyTrainInfo: Bus.DailyTrainInfoDetail(TrainNo: "0693", Direction: 0, StartingStationID: "0990", StartingStationName: Bus.StartingStationNameDetail(Zh_tw: "南港", En: "Nangang"), EndingStationID: "1070", EndingStationName: Bus.EndingStationNameDetail(Zh_tw: "左營", En: "Zuoying"), Note: Bus.NoteDetail(Zh_tw: nil, En: nil)), OriginStopTime: Bus.OriginStopTimeDetail(StopSequence: 1, StationID: "0990", StationName: Bus.StationNameDetail(Zh_tw: "南港", En: "Nangang"), ArrivalTime: "21:30", DepartureTime: "21:30"), DestinationStopTime: Bus.DestinationStopTimeDetail(StopSequence: 9, StationID: "1070", StationName: Bus.StationNameDetail(Zh_tw: "左營", En: "Zuoying"), ArrivalTime: "23:40", DepartureTime: "23:40"), UpdateTime: "2023-01-27T02:46:52+08:00", VersionID: 1), Bus.THSRDailyTimetableOToDResponse(TrainDate: "2023-02-27", DailyTrainInfo: Bus.DailyTrainInfoDetail(TrainNo: "0333", Direction: 0, StartingStationID: "0990", StartingStationName: Bus.StartingStationNameDetail(Zh_tw: "南港", En: "Nangang"), EndingStationID: "1070", EndingStationName: Bus.EndingStationNameDetail(Zh_tw: "左營", En: "Zuoying"), Note: Bus.NoteDetail(Zh_tw: nil, En: nil)), OriginStopTime: Bus.OriginStopTimeDetail(StopSequence: 1, StationID: "0990", StationName: Bus.StationNameDetail(Zh_tw: "南港", En: "Nangang"), ArrivalTime: "21:45", DepartureTime: "21:45"), DestinationStopTime: Bus.DestinationStopTimeDetail(StopSequence: 9, StationID: "1070", StationName: Bus.StationNameDetail(Zh_tw: "左營", En: "Zuoying"), ArrivalTime: "23:55", DepartureTime: "23:55"), UpdateTime: "2023-01-27T02:46:52+08:00", VersionID: 1), Bus.THSRDailyTimetableOToDResponse(TrainDate: "2023-02-27", DailyTrainInfo: Bus.DailyTrainInfoDetail(TrainNo: "0295", Direction: 0, StartingStationID: "0990", StartingStationName: Bus.StartingStationNameDetail(Zh_tw: "南港", En: "Nangang"), EndingStationID: "1070", EndingStationName: Bus.EndingStationNameDetail(Zh_tw: "左營", En: "Zuoying"), Note: Bus.NoteDetail(Zh_tw: nil, En: nil)), OriginStopTime: Bus.OriginStopTimeDetail(StopSequence: 1, StationID: "0990", StationName: Bus.StationNameDetail(Zh_tw: "南港", En: "Nangang"), ArrivalTime: "22:05", DepartureTime: "22:05"), DestinationStopTime: Bus.DestinationStopTimeDetail(StopSequence: 7, StationID: "1070", StationName: Bus.StationNameDetail(Zh_tw: "左營", En: "Zuoying"), ArrivalTime: "23:59", DepartureTime: "23:59"), UpdateTime: "2023-01-27T02:46:52+08:00", VersionID: 1)]
