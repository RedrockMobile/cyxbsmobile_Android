//
//  ActivityTypePickerVC.swift
//  CyxbsMobile2019_iOS
//
//  Created by 许晋嘉 on 2023/8/27.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

protocol ActivityTypePickerDelegate: AnyObject {
    func didSelectActivityType(_ type: String)
}

enum ActivityTypeSelection {
    case culture
    case sports
    case education
}

class ActivityTypePickerVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    weak var delegate: ActivityTypePickerDelegate?
    
    let activityTypes = ["文娱活动", "体育活动", "教育活动"]
    var activityType: ActivityTypeSelection?
    
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView(frame: CGRectMake(0, 10, UIScreen.main.bounds.width, 180))
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
        self.view.backgroundColor = .clear
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
        let indicatorImgView = UIImageView(frame: CGRectMake(52, 96, 6, 8))
        indicatorImgView.image = UIImage(named: "指示标")
        contentView.addSubview(indicatorImgView)
        contentView.addSubview(separator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contentView.transform = CGAffineTransform(translationX: 0, y: 285)
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
            self.view.backgroundColor = .clear
            self.contentView.transform = .identity
            self.contentView.frame.origin.y = self.view.frame.height
        } completion: { _ in
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    @objc func confirmButtonTapped() {
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        let selectedType = activityTypes[selectedRow]
        delegate?.didSelectActivityType(selectedType)
        UIView.animate(withDuration: 0.3) {
            self.view.backgroundColor = .clear
            self.contentView.transform = .identity
            self.contentView.frame.origin.y = self.view.frame.height
        } completion: { _ in
            // After the animation completes, remove contentView from the view hierarchy
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    

    // MARK: - UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return activityTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if pickerView.subviews.count > 2{
            pickerView.subviews[1].isHidden = true
            pickerView.subviews[2].isHidden = true
        }else{
            pickerView.subviews[1].backgroundColor = .clear
        } //去除选中行的默认背景
        let label = UILabel()
        label.text = activityTypes[row]
        label.textColor = UIColor(hexString: "#15315B", alpha: 1)
        label.textAlignment = .center
        label.font = UIFont(name: PingFangSCSemibold, size: 20)
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50 // Adjust the row height as needed
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return activityTypes[row]
    }
    
    func selectDefaultRows() {
        // 设置picker view默认选中的活动类型
        switch activityType {
        case .none: break
        case .culture: pickerView.selectRow(0, inComponent: 0, animated: false)
        case .sports: pickerView.selectRow(1, inComponent: 0, animated: false)
        case .education: pickerView.selectRow(2, inComponent: 0, animated: false)
        }
    }
}




