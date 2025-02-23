//
//  DiscoverTodoSelectRepeatView.swift
//  CyxbsMobile2019_iOS
//
//  Created by Max Xu on 2024/8/19.
//  Copyright © 2024 Redrock. All rights reserved.
//

import UIKit
import SnapKit

protocol DiscoverTodoSelectRepeatViewDelegate: AnyObject {
    func selectRepeatViewSureBtnClicked(_ view: DiscoverTodoSelectRepeatView)
    func selectRepeatViewCancelBtnClicked()
}

class DiscoverTodoSelectRepeatView: DiscoverTodoSetRemindBasicView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: - Properties
    var dateArr: [String] = []
    var repeatMode: TodoDataModelRepeatMode = .NO
    weak var delegate: DiscoverTodoSelectRepeatViewDelegate?
    var btnArr: [DLTimeSelectedButton] = []
    /// 数据选择器
    private lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    /// 周几的数组
    private let week: [String] = ["周日", "周一", "周二", "周三", "周四", "周五", "周六"]
    private lazy var addBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "加号"), for: .normal)
        button.addTarget(self, action: #selector(addBtnClicked), for: .touchUpInside)
        return button
    }()
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.contentSize.height = scrollView.height
        return scrollView
    }()
    private lazy var scrContenView: UIView = {
        let view = UIView()
        return view
    }()
    private var selectedCntOfcom: [Int] = Array(repeating: 0, count: 3)
    /// 本次新增的重复个数
    private var increseCnt: Int = 0
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    
    func refreshUI(repeatMode: TodoDataModelRepeatMode, dateArr: [String]) {
        self.repeatMode = repeatMode
        self.dateArr = dateArr
        
        scrContenView.subviews.forEach { $0.removeFromSuperview() }
        btnArr.removeAll()
        
        switch repeatMode {
        case .NO:
            break
        case .day:
            pickerView.selectRow(0, inComponent: 0, animated: true)
            selectedCntOfcom[0] = 0
            let btn = DLTimeSelectedButton()
            btnArr.append(btn)
            scrContenView.addSubview(btn)
            btn.setTitle("每天", for: .normal)
            btn.delegate = self
            break
        case .week:
            pickerView.selectRow(1, inComponent: 0, animated: true)
            selectedCntOfcom[0] = 1
            for dateStr in dateArr {
                if let weekNum = Int(dateStr) {
                    let titleStr = week[ChinaWeekToForeignWeek(weekNum) - 1]
                    let btn = DLTimeSelectedButton()
                    btnArr.append(btn)
                    scrContenView.addSubview(btn)
                    btn.setTitle(titleStr, for: .normal)
                    btn.delegate = self
                }
            }
            break
        case .month:
            pickerView.selectRow(2, inComponent: 0, animated: true)
            selectedCntOfcom[0] = 2
            for dateStr in dateArr {
                let titleStr = "每月\(dateStr)日"
                let btn = DLTimeSelectedButton()
                btnArr.append(btn)
                scrContenView.addSubview(btn)
                btn.setTitle(titleStr, for: .normal)
                btn.delegate = self
            }
        default:
            break
        }
        reLayoutAllBtn()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let x = self.scrollView.contentSize.width - SCREEN_WIDTH
            if x > 60 {
                UIView.animate(withDuration: 0.6, animations: {
                    self.scrollView.contentOffset = CGPoint(x: x + 4, y: 0)
                }, completion: { _ in
                    UIView.animate(withDuration: 0.4) {
                        self.scrollView.contentOffset = CGPoint(x: x, y: 0)
                    }
                })
            }
        }
    }
    
    private func setupUI() {
        addSubview(pickerView)
        pickerView.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(0.039 * SCREEN_HEIGHT)
            make.bottom.equalTo(self).offset(-0.147 * SCREEN_HEIGHT)
        }
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.left.right.equalTo(self)
            make.top.equalTo(self).offset(0.01724137931 * SCREEN_HEIGHT)
            make.height.equalTo(0.04433497537 * SCREEN_HEIGHT)
        }
        scrollView.addSubview(scrContenView)
        scrContenView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
        }
        tipView.snp.makeConstraints { make in
            make.centerY.equalTo(pickerView)
            make.right.equalTo(pickerView.snp.left)
        }
        addSubview(addBtn)
        addBtn.snp.makeConstraints { make in
            make.left.equalTo(pickerView.snp.right)
            make.centerY.equalTo(pickerView)
            make.width.height.equalTo(0.058 * SCREEN_WIDTH)
        }
        cancelBtn.addTarget(self, action: #selector(cancelBtnClicked), for: .touchUpInside)
        sureBtn.addTarget(self, action: #selector(sureBtnClicked), for: .touchUpInside)
    }
    
    // MARK: - UIPickerViewDataSource & UIPickerViewDelegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return selectedCntOfcom[0] > 1 ? selectedCntOfcom[0] : selectedCntOfcom[0] + 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 3
        }
        switch selectedCntOfcom[0] {
        case 0: return 3
        case 1: return 7
        case 2: return 31
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if #available(iOS 14.0, *) {
            pickerView.subviews[1].backgroundColor = .clear
        }
        switch component {
        case 0: return ["每天", "每周", "每月"][row]
        case 1:
            if selectedCntOfcom[0] == 1 {
                return week[row]
            }
            fallthrough
        default: return "\(row + 1)"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0, !btnArr.isEmpty, row != selectedCntOfcom[component] {
            pickerView.selectRow(selectedCntOfcom[component], inComponent: 0, animated: true)
            RemindHUD.shared().showDefaultHUD(withText: "只能选择一种重复模式～")
            return
        }
        selectedCntOfcom[component] = row
        resetData()
    }
    
    private func resetData() {
        let componentCnt = numberOfComponents(in: pickerView)
        for i in 0..<componentCnt {
            let rowCnt = pickerView(pickerView, numberOfRowsInComponent: i)
            if selectedCntOfcom[i] >= rowCnt {
                selectedCntOfcom[i] = rowCnt - 1
            }
        }
        pickerView.reloadAllComponents()
        for i in 0..<componentCnt {
            pickerView.selectRow(selectedCntOfcom[i], inComponent: i, animated: true)
        }
    }
    
    // MARK: - Button Actions
    @objc private func cancelBtnClicked() {
        hideView()
        delegate?.selectRepeatViewCancelBtnClicked()
    }
    
    @objc private func sureBtnClicked() {
        UIView.animate(withDuration: 0.3) {
            self.alpha = 0
        }
        increseCnt = 0
        isViewHided = true
        delegate?.selectRepeatViewSureBtnClicked(self)
    }
    
    @objc func addBtnClicked() {
        var titleStr: String?
        
        switch selectedCntOfcom[0] {
        case 0:
            if !btnArr.isEmpty {
                return
            }
            repeatMode = .day
            titleStr = "每天"
            
        case 1:
            let dateStr = "\(ForeignWeekToChinaWeek(Int(selectedCntOfcom[1]) + 1))"
            if dateArr.contains(where: { $0 == dateStr }) {
                return
            }
            dateArr.append(dateStr)
            repeatMode = .week
            titleStr = week[Int(selectedCntOfcom[1])]
            
        case 2:
            let dateStr = "\(selectedCntOfcom[1] + 1)"
            if dateArr.contains(where: { $0 == dateStr }) {
                return
            }
            dateArr.append(dateStr)
            repeatMode = .month
            titleStr = "每月\(selectedCntOfcom[1] + 1)日"
            
        default:
            break
        }
        
        let btn = DLTimeSelectedButton()
        btnArr.append(btn)
        scrContenView.addSubview(btn)
        
        btn.setTitle(titleStr, for: .normal)
        btn.delegate = self
        
        reLayoutAllBtn()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let x = self.scrollView.contentSize.width - SCREEN_WIDTH
            if x > 60 {
                UIView.animate(withDuration: 0.6, animations: {
                    self.scrollView.contentOffset = CGPoint(x: x + 4, y: 0)
                }, completion: { _ in
                    UIView.animate(withDuration: 0.4) {
                        self.scrollView.contentOffset = CGPoint(x: x, y: 0)
                    }
                })
            }
        }
        increseCnt += 1
    }

    
    func reLayoutAllBtn() {
        var lastConstraint = scrContenView.snp.left
        
        for btn in btnArr {
            btn.snp.remakeConstraints { make in
                make.height.equalTo(0.04433497537 * SCREEN_HEIGHT)
                make.top.bottom.equalTo(scrContenView)
                make.left.equalTo(lastConstraint).offset(0.03733333333 * SCREEN_WIDTH)
            }
            lastConstraint = btn.snp.right
        }
        
        if btnArr.isEmpty {
            return
        }
        
        btnArr.last?.snp.makeConstraints { make in
            make.right.equalTo(scrContenView).offset(-0.03733333333 * SCREEN_WIDTH)
        }
    }
    
    /// 外界调用，调用后显示出来
    override func showView() {
        if isViewHided {
            isViewHided = false
            UIView.animate(withDuration: 0.3) {
                self.alpha = 1
                for subView in self.subviews {
                    subView.alpha = 1
                }
            }
            increseCnt = 0
        }
    }

    /// 调用后效果如同点击取消按钮，但是不会调用代理方法
    override func hideView() {
        if !isViewHided {
            isViewHided = true
            UIView.animate(withDuration: 0.3) {
                self.alpha = 0
            }

            for _ in 0..<increseCnt {
                if let lastButton = btnArr.popLast() {
                    lastButton.removeFromSuperview()
                }
                dateArr.removeLast()
            }
            reLayoutAllBtn()
        }
    }
}

extension DiscoverTodoSelectRepeatView {
    // 从 [1, 2, ... 7] 转化为 [2, 3, ... 1]
    func ChinaWeekToForeignWeek(_ week: Int) -> Int {
        return (week % 7) + 1
    }

    // 从 [2, 3, ... 1] 转化为 [1, 2, ... 7]
    func ForeignWeekToChinaWeek(_ week: Int) -> Int {
        return ((week + 5) % 7) + 1
    }
}

extension DiscoverTodoSelectRepeatView: DLTimeSelectedButtonDelegate {
    func deleteButton(with button: DLTimeSelectedButton) {
        button.removeFromSuperview()
        // 避免在每天重复的情况下出问题
        if !dateArr.isEmpty {
            // 移除日期数组中对应日期
            if let index = btnArr.firstIndex(of: button) {
                dateArr.remove(at: index)
            }
        }
        // 从按钮数组中移除按钮
        if let index = btnArr.firstIndex(of: button) {
            btnArr.remove(at: index)
        }
        reLayoutAllBtn()
        // 调整按钮增加计数
        if increseCnt >= 0 {
            increseCnt -= 1
        }
    }

    // MARK: - DLTimeSelectedButtonDelegate
    func timeSelectedButtonClicked(_ btn: DLTimeSelectedButton) {
        guard let index = btnArr.firstIndex(of: btn) else { return }
        
        btnArr.remove(at: index)
        btn.removeFromSuperview()
        
        if btnArr.isEmpty {
            increseCnt = 0
        }
        
        if selectedCntOfcom[0] == 3 {
            dateArr.remove(at: index)
        } else {
            dateArr.remove(at: index)
        }
        
        reLayoutAllBtn()
    }
}
