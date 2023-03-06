//
//  THSRTimeTableViewController.swift
//  Bus
//
//  Created by Machir on 2023/2/27.
//

import UIKit

class THSRTimeTableViewController: UIViewController {
    // MARK: - Property
    
    var apiUrl = String()
    var data: [THSRDailyTimetableOToDResponse] = []
    var fareData = [THSROToDFareResponse]()
    let loadingView = UIActivityIndicatorView()
    let timerInterval: TimeInterval = 0.1
    var timer: Timer?
    deinit {
        timer?.invalidate()
        print("我是deinit")
    }
    
    @IBOutlet weak var THSRTimeTableView: UITableView!
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var coachSeats: UILabel!
    @IBOutlet weak var nonReservedSeats: UILabel!
    @IBOutlet weak var businessSeats: UILabel!
    @IBOutlet weak var seatPriceView: UIView!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setloadingView()
        starTimer()
        setSeatPriceView()
    }
    
    //MARK: - Method
    
    private func setSeatPriceView() {
        seatPriceView.layer.borderWidth = 2
        seatPriceView.layer.borderColor = UIColor.blue.cgColor
    }
    
    private func starTimer() {
        timer = Timer.scheduledTimer(timeInterval: timerInterval, target: self, selector: #selector(checkData), userInfo: nil, repeats: true)
    }
    
    @objc private func checkData() {
        
        if !data.isEmpty && !fareData.isEmpty {
            timer?.invalidate()
            DispatchQueue.main.async {
                self.setDateButton()
                self.setfareLabel()
                self.THSRTimeTableView.reloadData()
            }
            loadingView.stopAnimating()
            loadingView.removeFromSuperview()
        }
    }
    
    
    private func setloadingView() {
        loadingView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        loadingView.center = self.view.center
        loadingView.style = .medium
        loadingView.color = .blue
        view.addSubview(loadingView)
        loadingView.startAnimating()
    }
    
    private func setTableView() {
        THSRTimeTableView.delegate = self
        THSRTimeTableView.dataSource = self
    }
    
    private func setDateButton() {
        
        let date = data[0].TrainDate
        let startStation = data[0].OriginStopTime.StationName.Zh_tw
        let stopStation = data[0].DestinationStopTime.StationName.Zh_tw
        dateButton.setTitle("\(date) \(startStation)→\(stopStation)", for: .normal)
    }
    
    private func setfareLabel() {
        for i in fareData.indices {
            print("viewDidLoad畫面\(fareData[i])")
        }
        let coachSeat = fareData[0].Fares[0].Price
        let nonReservedSeat = fareData[0].Fares[2].Price
        let businessSeat = fareData[0].Fares[1].Price
        coachSeats.text = "$\(coachSeat)"
        nonReservedSeats.text = "$\(nonReservedSeat)"
        businessSeats.text = "$\(businessSeat)"
    }
    
}

// MARK: - TableViewDataSource & TableViewDelegate

extension THSRTimeTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(THSRTimeTableTableViewCell.self)", for: indexPath) as! THSRTimeTableTableViewCell
        
        let data = data[indexPath.row]
        let totalStoppingStations = "(\((data.DestinationStopTime.StopSequence - data.OriginStopTime.StopSequence))站)"

        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let departureTimeStr = data.OriginStopTime.DepartureTime
        let arrivalTimeStr = data.DestinationStopTime.ArrivalTime
        let departureTime = formatter.date(from: departureTimeStr)
        let arrivalTime = formatter.date(from: arrivalTimeStr)
        var travelHour = Int()
        var travelMinute = Int()
        if let departureTime = departureTime,
           let arrivalTime = arrivalTime {
            let travelTimeInSeconds = Int(arrivalTime.timeIntervalSince(departureTime))
            let travelHours = travelTimeInSeconds / 3600
            let travelMinutes = (travelTimeInSeconds % 3600) / 60
            travelHour = travelHours
            travelMinute = travelMinutes
        }
        
        
        
        DispatchQueue.main.async {
            cell.trainNoLabel.text = data.DailyTrainInfo.TrainNo
            cell.totalStoppingStationsLabel.text = totalStoppingStations
            cell.departureTimeLabel.text = data.OriginStopTime.DepartureTime
            cell.arrivalTimeLabel.text = data.DestinationStopTime.ArrivalTime
            if travelHour == 0 {
                cell.journeyTimeLabel.text = "🕓\(travelMinute)分"
            } else {
                cell.journeyTimeLabel.text = "🕓\(travelHour)時\(travelMinute)分"
            }
            print("我是cell資料\(data)")
        }
        
        return cell
    }
    
    
}
