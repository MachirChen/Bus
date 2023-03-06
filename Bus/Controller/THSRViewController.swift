//
//  THSRViewController.swift
//  Bus
//
//  Created by Machir on 2023/1/27.
//

import UIKit

class THSRViewController: UIViewController {
    // MARK: - Property
    
    private var data = [THSRDailyTimetableOToDResponse]()
    private var apiUrl: String? {
        guard let startStationID = userDefault.string(forKey: "userStartStation"),
              let stopStationID = userDefault.string(forKey: "userStopStation"),
              let startTimeHour = userDefault.string(forKey: "timeHour"),
              let startTimeMinute = userDefault.string(forKey: "timeMinute"),
              let trainDate = userDefault.string(forKey: "queryDate") else {return nil}
        let outputDateString = convertDateFormat(inputDate: trainDate)
        let apiUrl = "https://tdx.transportdata.tw/api/basic/v2/Rail/THSR/DailyTimetable/OD/\(startStationID)/to/\(stopStationID)/\(outputDateString)?%24filter=OriginStopTime%2FDepartureTime%20ge%20%27\(startTimeHour)%3A\(startTimeMinute)%27&%24format=JSON"
        return apiUrl
    }
    
    private var fareData = [THSROToDFareResponse]()
    private var fareApiUrl: String? {
        get {
            guard let startStationID = userDefault.string(forKey: "userStartStation"),
                  let stopStationID = userDefault.string(forKey: "userStopStation") else {return nil}
            let apiUrl = "https://tdx.transportdata.tw/api/basic/v2/Rail/THSR/ODFare/\(startStationID)/to/\(stopStationID)?%24top=30&%24format=JSON"
            return apiUrl
        }
    }
    
    private let userDefault = UserDefaults.standard
    private var stations: [Station] = [
        Station(name: "Nangang", code: "0990"),
        Station(name: "Taipei", code: "1000"),
        Station(name: "Banqiao", code: "1010"),
        Station(name: "Taoyuan", code: "1020"),
        Station(name: "Hsinchu", code: "1030"),
        Station(name: "Miaoli", code: "1035"),
        Station(name: "Taichung", code: "1040"),
        Station(name: "Changhua", code: "1043"),
        Station(name: "Yunlin", code: "1047"),
        Station(name: "Chiayi", code: "1050"),
        Station(name: "Tainan", code: "1060"),
        Station(name: "Zuoying", code: "1070"),
    ]
    
    private var selectedStartStation: Station? {
        guard let code = userDefault.string(forKey: "userStartStation") else {return nil}
        return stations.first(where: { $0.code == code })
    }
    
    private var selectedStopStation: Station? {
        guard let code = userDefault.string(forKey: "userStopStation") else {return nil}
        return stations.first(where: { $0.code == code })
    }
    
    private var currentTime: String {
        let now = Date()
        let calendar = Calendar.current
        let hour = String(format: "%02d", calendar.component(.hour, from: now))
        let minute = String(format: "%02d", calendar.component(.minute, from: now))
        userDefault.set(hour, forKey: "timeHour")
        userDefault.set(minute, forKey: "timeMinute")
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let formattedDate = formatter.string(from: now)
        return formattedDate
    }
    
    // MARK: - IBOulet
    
    @IBOutlet var startStationButtons: [UIButton]!
    @IBOutlet var stopStationButtons: [UIButton]!
    @IBOutlet weak var queryDateButton: UIButton!
    @IBOutlet weak var currentButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSelectButton()
        
        //設定button圓角邊線
        styleButton(queryDateButton)
        styleButton(currentButton)
        styleButton(searchButton)
        
        //查詢日期預設為現在時間
        initDateButtonTitle()
        
        fetchData()
        fetchFareData()
    }
    
    //MARK: - IBAction
    
    @IBAction func selectStartStation(_ sender: UIButton) {
        startStationButtons.forEach({$0.isSelected = false})
        if let selectedStation = stations.first(where: { $0.code == "\(sender.tag)" }) {
            setStartStationButton(selected: true, for: selectedStation)
            userDefault.set(selectedStation.code, forKey: "userStartStation")
        } else if let selectedStation = stations.first(where: { $0.code == "0990"}) {
            setStartStationButton(selected: true, for: selectedStation)
            userDefault.set(selectedStation.code, forKey: "userStartStation")
        }
        fetchData()
        fetchFareData()
    }
    
    @IBAction func selectStopStation(_ sender: UIButton) {
        stopStationButtons.forEach({$0.isSelected = false})
        if let selectedStation = stations.first(where: { $0.code == "\(sender.tag)" }) {
            setStopStationButton(selected: true, for: selectedStation)
            userDefault.set(selectedStation.code, forKey: "userStopStation")
        } else if let selectedStation = stations.first(where: { $0.code == "0990"}) {
            setStopStationButton(selected: true, for: selectedStation)
            userDefault.set(selectedStation.code, forKey: "userStopStation")
        }
        fetchData()
        fetchFareData()
    }
    
    @IBAction func changeStartWithStopStation(_ sender: Any) {
        let startStationCode = userDefault.string(forKey: "userStartStation")
        let stopStationCode = userDefault.string(forKey: "userStopStation")
        userDefault.set(stopStationCode, forKey: "userStartStation")
        userDefault.set(startStationCode, forKey: "userStopStation")
        if let newStartStationCode = userDefault.string(forKey: "userStartStation"),
           let newStopStationCode = userDefault.string(forKey: "userStopStation") {
            if let newStartStationButton = startStationButtons.first(where: { $0.tag == Int(newStartStationCode) }) {
                startStationButtons.forEach({$0.isSelected = false})
                newStartStationButton.isSelected = true
                print("start,\(newStartStationCode)")
            } else if let newStartStationButton = startStationButtons.first(where: { $0.tag == 990}) {
                startStationButtons.forEach({$0.isSelected = false})
                newStartStationButton.isSelected = true
            }
            
            if let newStopStationButton = stopStationButtons.first(where: { $0.tag == Int(newStopStationCode) }) {
                stopStationButtons.forEach({$0.isSelected = false})
                newStopStationButton.isSelected = true
                print("stop,\(newStopStationCode)")
            } else if let newStopStationButton = stopStationButtons.first(where: { $0.tag == 990}) {
                stopStationButtons.forEach({$0.isSelected = false})
                newStopStationButton.isSelected = true
            }
        }
        fetchData()
        fetchFareData()
    }
    
    @IBAction func currentTimeButton(_ sender: Any) {
        let now = Date()
        let calendar = Calendar.current
        let hour = String(format: "%02d", calendar.component(.hour, from: now))
        let minute = String(format: "%02d", calendar.component(.minute, from: now))
        userDefault.set(hour, forKey: "timeHour")
        userDefault.set(minute, forKey: "timeMinute")
        userDefault.set(currentTime, forKey: "queryDate")
        if let queryDate = userDefault.string(forKey: "queryDate") {
            queryDateButton.setTitle(queryDate, for: .normal)
        } else {
            print("沒東西")
        }
        fetchData()
    }
    
    //MARK: - Method
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? THSRDatePickerViewController {
            controller.delegate = self
        } else if let controller = segue.destination as? THSRTimeTableViewController {
            print("THSRTimeTableViewController傳資料")
            DispatchQueue.main.async {
                controller.data = self.data
                controller.fareData = self.fareData
            }
        }
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "THSRTimeTableViewController" {
            if userDefault.value(forKey: "userStartStation") as! String == userDefault.value(forKey: "userStopStation") as! String {
                let alert = UIAlertController(title: "溫馨提醒", message: "請選擇不同的起迄站", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "確定", style: .default))
                present(alert, animated: true)
            } else if data.isEmpty {
                let alert = UIAlertController(title: "溫馨提醒", message: "您選擇的時段已無班次，請重新查詢", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "確定", style: .default))
                present(alert, animated: true)
                return false
            } else {
                return true
            }
        }
        return true
    }
    
    private func fetchFareData() {
        MenuController.shared.fetchTHSRODFareData(urlStr: fareApiUrl!) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fareData):
                    self.fareData = fareData
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func fetchData() {
        MenuController.shared.fetchTHSRDailyTimetableStationToStationData(urlStr: apiUrl!) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.data = data
                    print(data.count)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func initDateButtonTitle() {
        userDefault.set(currentTime, forKey: "queryDate")
        queryDateButton.setTitle(currentTime, for: .normal)
    }
    
    //日期轉換func
    private func convertDateFormat(inputDate: String) -> String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        if let inputDate = inputDateFormatter.date(from: inputDate) {
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "yyyy-MM-dd"
            return outputDateFormatter.string(from: inputDate)
        }
        return ""
    }
    
    private func styleButton(_ button: UIButton) {
        button.layer.borderWidth = 3.0
        button.layer.borderColor = UIColor.blue.cgColor
        button.layer.cornerRadius = button.bounds.height / 2
    }
    
    private func initSelectButton() {
        //車站起始點和終點選擇相關
        if let startStation = selectedStartStation {
            setStartStationButton(selected: true, for: startStation)
        } else {
            setStartStationButton(selected: true, for: stations.first!)
            userDefault.set(stations.first!.code, forKey: "userStartStation")
        }
        
        if let stopStation = selectedStopStation {
            setStopStationButton(selected: true, for: stopStation)
        } else {
            setStartStationButton(selected: true, for: stations.first!)
            userDefault.set(stations.first!.code, forKey: "userStopStation")
        }
    }
    
    private func setStartStationButton(selected: Bool, for station: Station) {
        if let button = startStationButtons.first(where: { $0.tag == Int(station.code) }){
            button.isSelected = selected
        } else if let button = startStationButtons.first(where: { $0.tag == 990 }) {
            button.isSelected = selected
        }
    }
    
    private func setStopStationButton(selected: Bool, for station: Station) {
        if let button = stopStationButtons.first(where: { $0.tag == Int(station.code) }){
            button.isSelected = selected
        } else if let button = stopStationButtons.first(where: { $0.tag == 990 }) {
            button.isSelected = selected
        }
    }
}

//MARK: - PickerViewDelegate

extension THSRViewController: THSRDatePickerViewControllerDelegate {
    func didReceiveData(data: String, hour: String, minute: String) {
        userDefault.set(data, forKey: "queryDate")
        userDefault.set(hour, forKey: "timeHour")
        userDefault.set(minute, forKey: "timeMinute")
        queryDateButton.setTitle(userDefault.string(forKey: "queryDate"), for: .normal)
        fetchData()
    }
}
