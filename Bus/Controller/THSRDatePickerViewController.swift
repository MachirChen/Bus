//
//  THSRDatePickerViewController.swift
//  Bus
//
//  Created by Machir on 2023/2/1.
//

import UIKit

protocol THSRDatePickerViewControllerDelegate: AnyObject {
    func didReceiveData(data: String, hour: String, minute: String)
}

class THSRDatePickerViewController: UIViewController {
    // MARK: - Property
    
    weak var delegate: THSRDatePickerViewControllerDelegate?
    let apiUrlStr = "https://tdx.transportdata.tw/api/basic/v2/Rail/THSR/DailyTimetable/TrainDates?%24format=JSON"
    var trainDatesData: THSRDailyTimetableTrainDates?
    var selectDateAndTime = String()
    var selectTimeHour = String()
    var selectTimeMinute = String()
    @IBOutlet weak var THSRDatePicker: UIDatePicker!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBlackView() //背景黯淡效果，更專注在選擇日期。
        setCurrentDateAndTime()
        fetchDataAndSetPicker()
        let singleFinger = UITapGestureRecognizer(target: self, action: #selector(hideDatePicker))
        view.addGestureRecognizer(singleFinger)
        
    }
    
    //MARK: - IBAction
    
    @IBAction func checkButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        self.presentingViewController?.view.subviews.last?.removeFromSuperview()
        delegate?.didReceiveData(data: selectDateAndTime, hour: selectTimeHour, minute: selectTimeMinute)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true)
        self.presentingViewController?.view.subviews.last?.removeFromSuperview()
    }
    
    //MARK: - Method
    
    //呼叫dismiss回到前一個viewController，presentingViewController移除blackView。
    @objc private func hideDatePicker() {
        dismiss(animated: true, completion: nil)
        self.presentingViewController?.view.subviews.last?.removeFromSuperview()
    }
    
    @objc private func saveSelectDate() {
        let calendar = Calendar.current
        let hour = String(format: "%02d", calendar.component(.hour, from: THSRDatePicker.date))
        let minute = String(format: "%02d", calendar.component(.minute, from: THSRDatePicker.date))
        self.selectTimeHour = hour
        self.selectTimeMinute = minute
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        self.selectDateAndTime = formatter.string(from: THSRDatePicker.date)
        print("save\(self.selectDateAndTime)")
    }
    
    private func fetchDataAndSetPicker() {
        MenuController.shared.fetchTHSRDailyTimetableTrainDates(urlStr: apiUrlStr) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let trainDatesData):
                    self.trainDatesData = trainDatesData
                    self.setDatePicker()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func setBlackView() {
        let blackView = UIView(frame: UIScreen.main.bounds)
        blackView.backgroundColor = .black
        blackView.alpha = 0
        presentingViewController?.view.addSubview(blackView)
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0) {
            blackView.alpha = 0.5
        }
    }
    
    
    private func setDatePicker() {
        let dateFormatter = DateFormatter()
        let timeZone = TimeZone(identifier: "Asia/Taipei")
        let startDate = self.trainDatesData?.StartDate
        let endDate = self.trainDatesData?.EndDate
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        THSRDatePicker.timeZone = timeZone
        THSRDatePicker.datePickerMode = .dateAndTime
        THSRDatePicker.locale = Locale(identifier: "zh_GB") //pickerView顯示24小時制
        THSRDatePicker.date = Date() //預設當前時間
        THSRDatePicker.addTarget(self, action: #selector(saveSelectDate), for: .valueChanged)
        if let startDate = dateFormatter.date(from: "\(startDate!) 00:00"),
           let endDate = dateFormatter.date(from: "\(endDate!) 23:59") {
            THSRDatePicker.minimumDate = startDate
            THSRDatePicker.maximumDate = endDate
            print("成功")
        }
    }
    
    private func setCurrentDateAndTime() {
        let date = Date()
        let calendar = Calendar.current
        let hour = String(format: "%02d", calendar.component(.hour, from: date))
        let minute = String(format: "%02d", calendar.component(.minute, from: date))
        self.selectTimeHour = hour
        self.selectTimeMinute = minute
        print("現在時間\(hour):\(minute)")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        let now = Date()
        let formattedDate = dateFormatter.string(from: now)
        self.selectDateAndTime = formattedDate
    }

}

