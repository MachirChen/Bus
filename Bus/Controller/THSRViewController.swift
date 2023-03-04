//
//  THSRViewController.swift
//  Bus
//
//  Created by Machir on 2023/1/27.
//

import UIKit

class THSRViewController: UIViewController {
    
    var data = [THSRDailyTimetableOToDResponse]()
    var apiUrl: String? {
        get {
            let startStationID = userDefault.value(forKey: "userStartStation") as! String
            let stopStationID = userDefault.value(forKey: "userStopStation") as! String
            let startTimeHour = userDefault.value(forKey: "timeHour") as! String
            let startTimeMinute = userDefault.value(forKey: "timeMinute") as! String
            let trainDate = userDefault.value(forKey: "queryDate")
            let inputDateFormatter = DateFormatter()
            inputDateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
            //"yyyy/MM/dd HH:mm"格式轉"yyyy-MM-dd"
            if let inputDate = inputDateFormatter.date(from: trainDate as! String) {
                let outputDateFormatter = DateFormatter()
                outputDateFormatter.dateFormat = "yyyy-MM-dd"
                let outputDateString = outputDateFormatter.string(from: inputDate)
                return "https://tdx.transportdata.tw/api/basic/v2/Rail/THSR/DailyTimetable/OD/\(startStationID)/to/\(stopStationID)/\(outputDateString)?%24filter=OriginStopTime%2FDepartureTime%20ge%20%27\(startTimeHour)%3A\(startTimeMinute)%27&%24format=JSON"
            }
            return nil
        }
        set {
            
        }
    }
    
    var fareData = [THSROToDFareResponse]()
    var fareApiUrl: String? {
        get {
            let startStationID = userDefault.value(forKey: "userStartStation") as! String
            let stopStationID = userDefault.value(forKey: "userStopStation") as! String
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
        guard let code = userDefault.string(forKey: "userStartStation") else {
            return nil
        }
        return stations.first(where: { $0.code == code })
    }
    
    private var selectedStopStation: Station? {
        guard let code = userDefault.string(forKey: "userStopStation") else {
            return nil
        }
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
    
    private func setQueryDateButton() {
        queryDateButton.layer.borderWidth = 3.0
        queryDateButton.layer.borderColor = UIColor.blue.cgColor
        queryDateButton.layer.cornerRadius = queryDateButton.bounds.height / 2
    }
    
    private func setCurrentButton() {
        currentButton.layer.borderWidth = 3.0
        currentButton.layer.borderColor = UIColor.blue.cgColor
        currentButton.layer.cornerRadius = currentButton.bounds.height / 2
    }
    
    private func setSearchButton() {
        searchButton.layer.borderWidth = 3.0
        searchButton.layer.borderColor = UIColor.blue.cgColor
        searchButton.layer.cornerRadius = searchButton.bounds.height / 2
    }
    
    @IBOutlet var startStationButtons: [UIButton]!
    @IBOutlet var stopStationButtons: [UIButton]!
    @IBOutlet weak var queryDateButton: UIButton!
    @IBOutlet weak var currentButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        setQueryDateButton()
        setCurrentButton()
        setSearchButton()
        
        //查詢日期預設為現在時間
        queryDateButton.setTitle(currentTime, for: .normal)
        userDefault.set(currentTime, forKey: "queryDate")
        
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
        
        
//原程式碼
//        //StartStation
//        if let userStartStation = userDefault.string(forKey: "userStartStation") {
//            for button in startStationButtons {
//                if "\(button.tag)" == userStartStation {
//                    button.isSelected = true
//                    print(userStartStation)
//                } else if "0\(button.tag)" == userStartStation{
//                    button.isSelected = true
//                    print("0990")
//                }
//            }
//        } else {
//            startStationButtons.first?.isSelected = true
//            self.userStartStation = "0\(startStationButtons.first!.tag)"
//            print("預設值\(self.userStartStation)")
//        }
        
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
    
    @IBAction func selectStartStation(_ sender: UIButton) {
        
        startStationButtons.forEach({$0.isSelected = false})
        if let selectedStation = stations.first(where: { $0.code == "\(sender.tag)" }) {
            setStartStationButton(selected: true, for: selectedStation)
            userDefault.set(selectedStation.code, forKey: "userStartStation")
        } else if let selectedStation = stations.first(where: { $0.code == "0990"}) {
            setStartStationButton(selected: true, for: selectedStation)
            userDefault.set(selectedStation.code, forKey: "userStartStation")
        }
        MenuController.shared.fetchTHSRDailyTimetableStationToStationData(urlStr: apiUrl!) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.data = data
                case .failure(let error):
                    print(error)
                }
            }
        }
        
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
//原程式碼
//        startStationButtons.forEach({$0.isSelected = false})
//        sender.isSelected = true
//        if sender.tag == 990 {
//            self.userDefault.set("0\(sender.tag)", forKey: "userStartStation")
//        } else {
//            self.userDefault.set("\(sender.tag)", forKey: "userStartStation")
//        }
//
//        let index = startStationButtons.firstIndex(of: sender)!
//        print(index)
//        print(sender.tag)
//        if let userStartStation = userDefault.string(forKey: "userStartStation") {
//            self.userStartStation = userStartStation
//            print(self.userStartStation)
//        }
        
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
        MenuController.shared.fetchTHSRDailyTimetableStationToStationData(urlStr: apiUrl!) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.data = data
                case .failure(let error):
                    print(error)
                }
            }
        }
        
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
    
    @IBAction func changeStartWithStopStation(_ sender: Any) {
        let startStationCode = userDefault.string(forKey: "userStartStation")
        let stopStationCode = userDefault.string(forKey: "userStopStation")
        userDefault.set(stopStationCode, forKey: "userStartStation")
        userDefault.set(startStationCode, forKey: "userStopStation")
        
        print(userDefault.string(forKey: "userStartStation"))
        print(userDefault.string(forKey: "userStopStation"))
        
        
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
        print("我是交換前\(fareApiUrl)")
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
        print("我是fareApiUrl\(fareApiUrl)")
    }
    
    @IBAction func currentTimeButton(_ sender: Any) {
        let now = Date()
        let calendar = Calendar.current
        let hour = String(format: "%02d", calendar.component(.hour, from: now))
        let minute = String(format: "%02d", calendar.component(.minute, from: now))
        userDefault.set(hour, forKey: "timeHour")
        userDefault.set(minute, forKey: "timeMinute")
        userDefault.set(currentTime, forKey: "queryDate")
        if let queryDate = userDefault.value(forKey: "queryDate") as? String {
            queryDateButton.setTitle(queryDate, for: .normal)
        } else {
            print("沒東西")
        }
        MenuController.shared.fetchTHSRDailyTimetableStationToStationData(urlStr: apiUrl!) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.data = data
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
        
//    @IBAction func searchButton(_ sender: UIButton) {
//        performSegue(withIdentifier: "THSRTimeTableViewController", sender: self)
//    }
    
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension THSRViewController: THSRDatePickerViewControllerDelegate {
    func didReceiveData(data: String, hour: String, minute: String) {
        userDefault.set(data, forKey: "queryDate")
        userDefault.set(hour, forKey: "timeHour")
        userDefault.set(minute, forKey: "timeMinute")
        queryDateButton.setTitle(userDefault.value(forKey: "queryDate") as? String, for: .normal)
        MenuController.shared.fetchTHSRDailyTimetableStationToStationData(urlStr: apiUrl!) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.data = data
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? THSRDatePickerViewController {
            controller.delegate = self
        } else if let controller = segue.destination as? THSRTimeTableViewController {
            print("THSRTimeTableViewController傳資料")
            DispatchQueue.main.async {
                controller.data = self.data
                controller.fareData = self.fareData
                //controller.THSRTimeTableView.reloadData()
            }
        }
    }
}





//ChatGPT優化程式碼
/*
struct Station {
    let name: String
    let code: String
}

class THSRViewController: UIViewController {

    private let userDefaults = UserDefaults.standard

    private var stations: [Station] = [
        Station(name: "Taipei", code: "0990"),
        Station(name: "Banqiao", code: "1000"),
        Station(name: "Taoyuan", code: "1010"),
        Station(name: "Hsinchu", code: "1020"),
        // add more stations as needed
    ]

    private var selectedStartStation: Station? {
        guard let code = userDefaults.string(forKey: "userStartStation") else {
            return nil
        }
        return stations.first(where: { $0.code == code })
    }

    private var selectedStopStation: Station? {
        guard let code = userDefaults.string(forKey: "userStopStation") else {
            return nil
        }
        return stations.first(where: { $0.code == code })
    }

    @IBOutlet var stationButtons: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let startStation = selectedStartStation {
            setButton(selected: true, for: startStation)
        } else {
            setButton(selected: true, for: stations.first!)
            userDefaults.set(stations.first!.code, forKey: "userStartStation")
        }

        // add similar code for stop station selection
    }

    @IBAction func selectStation(_ sender: UIButton) {
        guard let selectedStation = stations.first(where: { $0.code == "\(sender.tag)" }) else {
            return
        }
        setButton(selected: true, for: selectedStation)
        userDefaults.set(selectedStation.code, forKey: "userStartStation")
        // add similar code for stop station selection
    }

    private func setButton(selected: Bool, for station: Station) {
        let button = stationButtons.first(where: { $0.tag == Int(station.code) })
        button?.isSelected = selected
    }
}
*/
