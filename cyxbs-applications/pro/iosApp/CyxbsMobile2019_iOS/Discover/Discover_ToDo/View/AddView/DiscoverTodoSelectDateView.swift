//
//  DiscoverTodoSelectTimeView.swift
//  CyxbsMobile2019_iOS
//
//  Created by Max Xu on 2024/8/20.
//  Copyright © 2024 Redrock. All rights reserved.
//

import UIKit
import SnapKit
import FSCalendar

protocol DiscoverTodoSelectDateViewDelegate: AnyObject {
    func selectTimeViewSureBtnClicked(date: Date)
    func selectTimeViewCancelBtnClicked()
}

class DiscoverTodoSelectDateView: DiscoverTodoSetRemindBasicView {
    
    weak var delegate: DiscoverTodoSelectDateViewDelegate?
    
    var selectedDate: Date = Date() {
        didSet {
            calendar.select(selectedDate)
            selectTimeView.selectedDate = selectedDate
        }
    }
    
    /// 日历视图
    private lazy var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.dataSource = self
        calendar.delegate = self
        calendar.scope = .month
        // 隐藏自带header
        calendar.headerHeight = 0
        calendar.weekdayHeight = 30
        calendar.placeholderType = .fillHeadTail
        calendar.locale = Locale(identifier: "zh-CN")
        // 日历中每周第一天为周一
        calendar.firstWeekday = 2
        // 设置日历中当天标注的外观
        calendar.appearance.titleTodayColor = UIColor.ry(light: "#2DCCEF", dark: "#2DCCEF")
        calendar.appearance.todayColor = .clear
        calendar.appearance.selectionColor = UIColor.ry(light: "#5552EF", dark: "#5552EF")
        calendar.appearance.titleDefaultColor = UIColor.ry(light: "#15315B", dark: "#FFFFFF")
        calendar.appearance.titlePlaceholderColor = UIColor.ry(light: "#D1D8E4", dark: "#696969")
        calendar.select(Date())
        calendar.isUserInteractionEnabled = true
        return calendar
    }()
    /// 自定义的日历header（20xx年x月）
    private lazy var calendarHeader: UILabel = {
        // 添加自定义header
        let label = UILabel()
        label.font = UIFont(name: PingFangSCSemibold, size: 15)
        label.numberOfLines = 1
        label.textColor = UIColor.ry(light: "#15315B", dark: "#F0F0F2")
        return label
    }()
    /// 向前翻页按钮
    private lazy var prevBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "finder_todo_prev_unable"), for: .disabled)
        button.setImage(UIImage(named: "finder_todo_prev"), for: .normal)
        button.addTarget(self, action: #selector(didTapPrevButton), for: .touchUpInside)
        return button
    }()
    /// 向后翻页按钮
    private lazy var nextBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "finder_todo_next"), for: .normal)
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        return button
    }()
    /// 选择时间的按钮（时、分）
    private lazy var timeBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "direction_right"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: PingFangSCSemibold, size: 15)
        button.titleLabel?.numberOfLines = 1
        button.setTitle("时间", for: .normal)
        button.setTitleColor(UIColor.ry(light: "#15315B", dark: "#FFFFFF"), for: .normal)
        button.titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapTimeButton), for: .touchUpInside)
        return button
    }()
    
    lazy var selectTimeView: DiscoverTodoSelectTimeView = {
        let view = DiscoverTodoSelectTimeView()
        addSubview(view)
        view.delegate = self
        view.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tipView.removeFromSuperview()
        addCalendar()
        addPageControlBtns()
        addTimeBtn()
        cancelBtn.addTarget(self, action: #selector(cancelBtnClicked), for: .touchUpInside)
        sureBtn.addTarget(self, action: #selector(sureBtnClicked), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addCalendar() {
        addSubview(calendar)
        addSubview(calendarHeader)
        let headerFormatter = DateFormatter()
        headerFormatter.dateFormat = "yyyy年MM月"
        calendarHeader.text = headerFormatter.string(from: calendar.currentPage)
        calendarHeader.sizeToFit()
        // 自定义周次显示
        let weekdays = ["一", "二", "三", "四", "五", "六", "日"]
        for (index, label) in calendar.calendarWeekdayView.weekdayLabels.enumerated() {
            label.text = weekdays[index]
            label.textColor = UIColor.ry(light: "#A1ADBD", dark: "#A1ADBD")
        }
        // 使用 SnapKit 设置约束
        calendarHeader.snp.makeConstraints { make in
            make.top.equalTo(self).offset(0.029556650246305*SCREEN_HEIGHT)
            make.left.equalTo(self).offset(0.08*SCREEN_WIDTH)
        }
        calendar.snp.makeConstraints { make in
            make.top.equalTo(calendarHeader.snp.bottom).offset(0.018472906403941*SCREEN_HEIGHT)
            make.left.equalTo(self).offset(0.04*SCREEN_WIDTH)
            make.right.equalTo(self).offset(-0.04*SCREEN_WIDTH)
            make.height.equalTo(0.3 * SCREEN_HEIGHT)
        }
    }
    
    /// 添加日历翻页按钮
    func addPageControlBtns() {
        addSubview(prevBtn)
        addSubview(nextBtn)
        prevBtn.snp.makeConstraints { make in
            make.centerY.equalTo(calendarHeader)
            make.width.height.equalTo(0.04*SCREEN_WIDTH)
            make.right.equalTo(nextBtn.snp.left).offset(-0.08533*SCREEN_WIDTH)
        }
        nextBtn.snp.makeConstraints { make in
            make.centerY.equalTo(calendarHeader)
            make.width.height.equalTo(0.04*SCREEN_WIDTH)
            make.right.equalTo(self.snp.right).offset(-0.08533*SCREEN_WIDTH)
        }
        prevBtn.isEnabled = false
    }
    
    func addTimeBtn() {
        addSubview(timeBtn)
        timeBtn.snp.makeConstraints { make in
            make.top.equalTo(calendar.snp.bottom).offset(0.012315270935961*SCREEN_HEIGHT)
            make.height.equalTo(max(0.025862068965517*SCREEN_HEIGHT, 21))
            make.left.right.equalTo(self)
        }
        timeBtn.imageView?.snp.makeConstraints({ make in
            make.right.equalTo(timeBtn.snp.right)
            make.centerY.equalTo(timeBtn)
            make.height.equalTo(0.015689655172414*SCREEN_HEIGHT)
        })
        timeBtn.titleLabel?.snp.makeConstraints({ make in
            make.left.equalTo(timeBtn.snp.left).offset(0.08*SCREEN_WIDTH)
            make.right.equalTo(timeBtn.snp.left).offset(0.08*SCREEN_WIDTH+30)
            make.centerY.equalTo(timeBtn)
            make.height.equalTo(21)
        })
    }
    
    // MARK: Button Target
    
    /// 向前翻页
    @objc func didTapPrevButton() {
        let currentPage = calendar.currentPage
        guard let prevMonth = Calendar.current.date(byAdding: .month, value: -1, to: currentPage) else {
            return
        }
        calendar.setCurrentPage(prevMonth, animated: true)
    }
    
    /// 向后翻页
    @objc func didTapNextButton() {
        let currentPage = calendar.currentPage
        guard let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: currentPage) else {
            return
        }
        calendar.setCurrentPage(nextMonth, animated: true)
    }
    
    /// 下方的取消按钮点击后调用
    @objc private func cancelBtnClicked() {
        hideView()
        delegate?.selectTimeViewCancelBtnClicked()
    }
    
    /// 下方的确定按钮点击后调用
    @objc private func sureBtnClicked() {
        hideView()
        delegate?.selectTimeViewSureBtnClicked(date: selectedDate)
    }
    
    @objc private func didTapTimeButton() {
        self.endEditing(true)
        self.selectTimeView.showView()
        bringSubviewToFront(selectTimeView)
    }
    
    /// 外界调用，调用后显示出来
    override func showView() {
        print("\(isViewHided), \(self.alpha)")
        if isViewHided == true {
            isViewHided = false
            UIView.animate(withDuration: 0.3) {
                self.alpha = 1
            }
        }
    }
    
    /// 调用后效果如同点击取消按钮，但是不会调用代理方法
    override func hideView() {
        if isViewHided == false {
            isViewHided = true
            UIView.animate(withDuration: 0.5) {
                self.alpha = 0
            }
        }
    }
}

extension DiscoverTodoSelectDateView: FSCalendarDataSource {
    func minimumDate(for calendar: FSCalendar) -> Date {
        // 不可选当前之前的日期
        return Date()
    }
}

extension DiscoverTodoSelectDateView: FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.snp.updateConstraints { (make) in
            make.height.equalTo(bounds.height)
            make.width.equalTo(bounds.width)
            // Do other updates
        }
        self.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
        selectedDate = date
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        let headerFormatter = DateFormatter()
        headerFormatter.dateFormat = "yyyy年MM月"
        calendarHeader.text = headerFormatter.string(from: calendar.currentPage)
        calendarHeader.sizeToFit()
        if calendar.currentPage > calendar.minimumDate {
            prevBtn.isEnabled = true
        } else {
            prevBtn.isEnabled = false
        }
    }
    
    // 隐藏下月日期的titleLabel
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
        if monthPosition == .next {
            cell.titleLabel.alpha = 0
        } else {
            cell.titleLabel.alpha = 1
        }
    }
}

extension DiscoverTodoSelectDateView: DiscoverTodoSelectTimeViewDelegate {
    func selectTimeViewSureBtnClicked(date: Date) {
        selectedDate = date
    }
    
    func selectTimeViewCancelBtnClicked() {
        
    }
}

