//
//  ActivityDatePickerVC.swift
//  CyxbsMobile2019_iOS
//
//  Created by 许晋嘉 on 2023/8/29.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

protocol ActivityDatePickerDelegate: AnyObject {
    func didSelectStartTime(date: Date)
    func didSelectEndTime(date: Date)
}

enum TimeSelection {
    case startTime
    case endTime
}

class ActivityDatePickerVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    weak var delegate: ActivityDatePickerDelegate?
    
    var timeSelection: TimeSelection = .startTime // 默认为开始时间
    
    var calendar: Calendar!
    let currentDate = Date()
    var minDate: Date?
    var maxDate: Date?
    
    var selectedYear: Int = 2023 // Set initial values
    var selectedMonth: Int = 1
    var selectedDay: Int = 1
    var selectedHour: Int = 0
    var selectedMinute: Int = 0
    var selectedSecond: Int = 0
    
    var selectedDateComponents = DateComponents()
    var minDateComponents: DateComponents!
    var maxDateComponents: DateComponents!
    
    
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView(frame: CGRectMake(40, 10, UIScreen.main.bounds.width - 56, 180))
        pickerView.delegate = self
        pickerView.dataSource = self
//        pickerView.showsSelectionIndicator = false
        return pickerView
    }()
    
    lazy var separator: UIView = {
        var view = UIView()
        view.frame = CGRect(x: 16, y: 185, width: UIScreen.main.bounds.width - 32, height: 1)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(hexString: "#2A4E84", alpha: 0.1).cgColor
        return view
    }()
    
    var contentView: UIView!
    var backgroundView: UIView!
    var confirmButton: UIButton!
    var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar = Calendar.current
        self.view.backgroundColor = .clear
        minDateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: minDate ?? currentDate)
        var dateComponents = DateComponents()
        dateComponents.month = 6
        maxDateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: (minDate ?? calendar.date(byAdding: dateComponents, to: Date()))!)
        setView()
        // Add pickerView to the view
        contentView.addSubview(pickerView)
        confirmButton = GradientButton(frame: CGRectMake((UIScreen.main.bounds.width - 120)/2, 203, 120, 40))
        confirmButton.setTitle("确定", for: .normal)
        confirmButton.titleLabel?.font = UIFont(name: PingFangSCSemibold, size: 18)
        confirmButton.titleLabel?.textColor = .white
        confirmButton.layer.cornerRadius = 20
        contentView.addSubview(confirmButton)
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        cancelButton = UIButton(frame: CGRectMake(UIScreen.main.bounds.width - 42, 15, 28, 20))
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.titleLabel?.font = UIFont(name: PingFangSCMedium, size: 12)
        cancelButton.setTitleColor(UIColor(hexString: "#ABB5C4", alpha: 1), for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        contentView.addSubview(cancelButton)
        let indicatorImgView = UIImageView(frame: CGRectMake(35, 96, 6, 8))
        indicatorImgView.image = UIImage(named: "指示标")
        contentView.addSubview(indicatorImgView)
        contentView.addSubview(separator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contentView.transform = CGAffineTransform(translationX: 0, y: 285)
        UIView.animate(withDuration: 0.3) {
            self.view.backgroundColor = UIColor(hexString: "#000000", alpha: 0.47)
            self.contentView.transform = .identity
        }
        selectDefaultRows()
    }
    
    func setView() {
        contentView = UIView()
        contentView.backgroundColor = .white
        contentView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 285, width: UIScreen.main.bounds.width, height: 285)
        contentView.layer.cornerRadius = 20
        view.addSubview(contentView)
        backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 285))
        backgroundView.backgroundColor = .clear
        view.addSubview(backgroundView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cancelButtonTapped))
        backgroundView.addGestureRecognizer(tapGesture)
    }
    
    @objc func cancelButtonTapped() {
        UIView.animate(withDuration: 0.3) {
            self.contentView.transform = .identity
            self.contentView.frame.origin.y = self.view.frame.height
            self.view.backgroundColor = .clear
        } completion: { _ in
            // After the animation completes, remove contentView from the view hierarchy
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    @objc func confirmButtonTapped() {
        selectedDateComponents.year = selectedYear
        selectedDateComponents.month = selectedMonth
        selectedDateComponents.day = selectedDay
        selectedDateComponents.hour = selectedHour
        selectedDateComponents.minute = selectedMinute
        if let selectedDate = calendar.date(from: selectedDateComponents) {
            // 格式化日期为字符串并输出
            switch timeSelection {
            case .startTime:
                self.delegate?.didSelectStartTime(date: selectedDate)
            case .endTime:
                self.delegate?.didSelectEndTime(date: selectedDate)
            }
            UIView.animate(withDuration: 0.3) {
                self.contentView.transform = .identity
                self.contentView.frame.origin.y = self.view.frame.height
                self.view.backgroundColor = .clear
            } completion: { _ in
                self.dismiss(animated: false, completion: nil)
            }
        } else {
            print("Invalid date components")
        }
    }
    
    

    // MARK: - UIPickerViewDataSource & Delegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 5
    }
    
    // 设定每行有多少列
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0: // Year
            return (maxDateComponents.year! - minDateComponents.year!) + 1
        case 1: // Month
            return 12
        case 2: // Day
            let selectedDateComponents = DateComponents(year: selectedYear, month: selectedMonth)
            let lastDayOfMonth = calendar.range(of: .day, in: .month, for: calendar.date(from: selectedDateComponents)!)?.upperBound ?? 31
            return lastDayOfMonth - 1
        case 3: // Hour
            return 24
        case 4: // Minute
            return 60
        default:
            return 0
        }
    }
    
    // Provide the content for each row in each component
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0: // Year
            return "\(minDateComponents.year! + row)"
        case 1: // Month
            return "\(row + 1)"
        case 2: // Day
            return "\(row + 1)"
        case 3: // Hour
            return "\(row)"
        case 4: // Minute
            return "\(row)"
        default:
            return nil
        }
    }
    
    // Handle selection of a row in the picker
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0: // Year
            selectedYear = calendar.component(.year, from: minDate ?? currentDate) + row
        case 1: // Month
            selectedMonth = row + 1
            pickerView.reloadComponent(2) // Reload day component when month changes
            let lastDayOfMonth = pickerView.numberOfRows(inComponent: 2)
            if selectedDay > lastDayOfMonth {
                selectedDay = lastDayOfMonth
            }
        case 2: // Day
            selectedDay = row + 1
        case 3: // Hour
            selectedHour = row
        case 4: // Minute
            selectedMinute = row
        default:
            break
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50 // Adjust the row height as needed
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if pickerView.subviews.count > 2{
            pickerView.subviews[1].isHidden = true
            pickerView.subviews[2].isHidden = true
        }else{
            pickerView.subviews[1].backgroundColor = .clear
        } //去除选中行的默认背景
        let label = UILabel()
        switch component {
        case 0: // Year
            label.text = "\(minDateComponents.year! + row)"
        case 1: // Month
            label.text = "\(row + 1)"
        case 2: // Day
            label.text = "\(row + 1)"
        case 3: // Hour
            label.text = "\(row)"
        case 4: // Minute
            label.text = "\(row)"
        default:
            label.text = nil
        }
        label.textColor = UIColor(hexString: "#15315B", alpha: 1)
        label.textAlignment = .center
        label.font = UIFont(name: PingFangSCSemibold, size: 20)
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        // Return the desired width for each component
        if component == 0 {
            return 60
        } else if component == 1 {
            return 45
        } else {
            return 45
        }
    }
    
    func selectDefaultRows() {
        // 设置picker view默认选中的时间
        selectedYear = minDateComponents.year!
        selectedMonth = minDateComponents.month!
        selectedDay = minDateComponents.day!
        selectedHour = minDateComponents.hour!
        selectedMinute = minDateComponents.minute!
        pickerView.selectRow(selectedYear - minDateComponents.year!, inComponent: 0, animated: false)
        pickerView.selectRow(selectedMonth - 1, inComponent: 1, animated: false)
        pickerView.selectRow(selectedDay - 1, inComponent: 2, animated: false)
        pickerView.selectRow(selectedHour, inComponent: 3, animated: false)
        pickerView.selectRow(selectedMinute, inComponent: 4, animated: false)
    }
    
}



