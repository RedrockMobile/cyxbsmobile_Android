//
//  DiscoverTodoSheetView.swift
//  CyxbsMobile2019_iOS
//
//  Created by Max Xu on 2024/8/20.
//  Copyright © 2024 Redrock. All rights reserved.
//

import UIKit

protocol DiscoverTodoSheetViewDelegate: AnyObject {
    func sheetViewSaveBtnClicked(_ dataModel: TodoDataModel)
    func sheetViewCancelBtnClicked()
}

class DiscoverTodoSheetView: UIView, UITextFieldDelegate {
    
    // MARK: - Properties
    
    weak var delegate: DiscoverTodoSheetViewDelegate?
    
    /// 带圆角白色背景板
    private let backView = UIView()
    /// 覆盖在蒙版上的透明view，用于实现点击返回逻辑
    private let cancelView = UIView()
    /// 取消按钮
    private lazy var cancelBtn: UIButton = {
        let button = UIButton()
        button.setTitle("取消", for: .normal)
        button.setTitleColor(UIColor.ry(light: "#15315B", dark: "#F0F0F2"), for: .normal)
        button.titleLabel?.font = UIFont(name: PingFangSCSemibold, size: 15)
        button.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        return button
    }()
    /// 保存按钮
    private lazy var saveBtn: UIButton = {
        let button = UIButton()
        button.setTitle("保存", for: .normal)
        button.setTitleColor(UIColor.ry(light: "#15315B", dark: "#F0F0F2"), for: .normal)
        button.alpha = 0.4
        button.titleLabel?.font = UIFont(name: PingFangSCSemibold, size: 15)
        button.addTarget(self, action: #selector(saveBtnClicked), for: .touchUpInside)
        return button
    }()
    /// 设置截止时间按钮
    private let remindTimeBtn = UIButton()
    /// 设置重复按钮
    private let repeatModelBtn = UIButton()
    /// 重复按钮的scrollView
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isDirectionalLockEnabled = true
        scrollView.contentInsetAdjustmentBehavior = .never  // 避免自动调整
        scrollView.contentSize.height = scrollView.height
        return scrollView
    }()
    /// 重复按钮的contentView
    private var scrContenView = UIView()
    /// 重复按钮的数组
    private var btnArr: [DLTimeSelectedButton] = [] {
        didSet {
            if btnArr.isEmpty {
                repeatModelBtn.titleLabel?.alpha = 1
                scrollView.alpha = 0
            }
            reLayoutAllRepeatBtn()
        }
    }
    /// 设置分组按钮
    private let typeBtn = UIButton()
    /// 标题文本输入框
    private lazy var titleInputTextField: TodoTitleInputTextField = {
        let textField = TodoTitleInputTextField()
        textField.delegate = self
        return textField
    }()
    /// 删除按钮
    private let deleteBtn = UIButton()
    
    private lazy var selectDateView: DiscoverTodoSelectDateView = {
        let view = DiscoverTodoSelectDateView()
        backView.addSubview(view)
        view.delegate = self
        view.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0.562807881773399 * SCREEN_HEIGHT)
        }
        return view
    }()
    
    private lazy var selectRepeatView: DiscoverTodoSelectRepeatView = {
        let view = DiscoverTodoSelectRepeatView()
        backView.addSubview(view)
        view.delegate = self
        view.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0.4729064039 * SCREEN_HEIGHT)
        }
        return view
    }()
    
    private lazy var selectTypeView: DiscoverTodoSelectTypeView = {
        let view = DiscoverTodoSelectTypeView()
        backView.addSubview(view)
        view.delegate = self
        view.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0.4729064039 * SCREEN_HEIGHT)
        }
        return view
    }()
    
    // 带收纳图标，显示todo类型的按钮
    private lazy var typeDetialButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: PingFangSCMedium, size: 15)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -13, bottom: 0, right: 0)
        button.setTitleColor(UIColor.ry(light: "#514DEB", dark: "#2CAEC5"), for: .normal)
        button.addTarget(self, action: #selector(typeBtnClicked), for: .touchUpInside)
        return button
    }()
    
    lazy var typeDetialImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "图标-收纳")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var dataModel = TodoDataModel()

    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.setupViews()
        // 默认选中项为其他
        dataModel.typeMode = .other
        setupTypeDetailButton(dataModel.typeMode)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        self.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: SCREEN_WIDTH, height: 1.782019704433498 * SCREEN_HEIGHT))
        }
        self.addSubview(backView)
        backView.backgroundColor = UIColor.ry(light: "#FFFFFF", dark: "#2C2C2C")
        backView.layer.mask = createRoundedCornerMask()
        backView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(SCREEN_HEIGHT * 0.782019704433498)
        }
        self.addSubview(cancelView)
        cancelView.backgroundColor = .clear
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(cancel))
        cancelView.addGestureRecognizer(tapGes)
        cancelView.snp.makeConstraints { make in
            make.left.right.top.equalTo(self)
            make.bottom.equalTo(backView.snp.top)
        }
        backView.addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { make in
            make.left.equalTo(backView).offset(SCREEN_WIDTH * 0.04)
            make.top.equalTo(backView).offset(SCREEN_WIDTH * 0.02586)
        }
        backView.addSubview(saveBtn)
        saveBtn.snp.makeConstraints { make in
            make.right.equalTo(backView).offset(-SCREEN_WIDTH * 0.04)
            make.top.equalTo(backView).offset(SCREEN_WIDTH * 0.02586)
        }
        backView.addSubview(titleInputTextField)
        titleInputTextField.snp.makeConstraints { make in
            make.left.equalTo(backView).offset(SCREEN_WIDTH * 0.048)
            make.top.equalTo(backView).offset(SCREEN_HEIGHT * 0.09236)
            make.width.equalTo(SCREEN_WIDTH * 0.904)
            make.height.equalTo(SCREEN_WIDTH * 0.11733)
        }
        setupRemindTimeButton()
        setupRepeatModelButton()
        setupTypeButton()
        setupDeleteButton()
        setupScrollView()
    }
    
    private func createRoundedCornerMask() -> CAShapeLayer {
        let rect = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT * 0.782019704433498)
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 16, height: 16))
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        return layer
    }
    
    private func setupRemindTimeButton() {
        setupStandardButton(remindTimeBtn, title: "设置截止时间", imageName: "todo提醒的小铃铛")
        remindTimeBtn.addTarget(self, action: #selector(remindTimeBtnClicked), for: .touchUpInside)
        backView.addSubview(remindTimeBtn)
        remindTimeBtn.snp.makeConstraints { make in
            make.left.equalTo(backView).offset(SCREEN_WIDTH * 0.08)
            make.top.equalTo(backView).offset(SCREEN_HEIGHT * 0.17611)
        }
        remindTimeBtn.imageView?.snp.makeConstraints { make in
            make.left.equalTo(remindTimeBtn)
            make.centerY.equalTo(remindTimeBtn.titleLabel!)
            make.right.equalTo(remindTimeBtn.titleLabel!.snp.left).offset(-SCREEN_WIDTH * 0.032)
            make.width.equalTo(SCREEN_WIDTH * 0.05333)
            make.height.equalTo(SCREEN_WIDTH * 0.056)
        }
    }
    
    private func setupRepeatModelButton() {
        setupStandardButton(repeatModelBtn, title: "设置重复", imageName: "todo的小闹钟")
        repeatModelBtn.addTarget(self, action: #selector(repeatModelBtnClicked), for: .touchUpInside)
        backView.addSubview(repeatModelBtn)
        repeatModelBtn.snp.makeConstraints { make in
            make.left.equalTo(backView).offset(SCREEN_WIDTH * 0.08)
            make.top.equalTo(backView).offset(SCREEN_HEIGHT * 0.22167)
        }
        
        repeatModelBtn.imageView?.snp.makeConstraints { make in
            make.left.equalTo(repeatModelBtn)
            make.centerY.equalTo(repeatModelBtn.titleLabel!)
            make.right.equalTo(repeatModelBtn.titleLabel!.snp.left).offset(-SCREEN_WIDTH * 0.032)
            make.width.equalTo(SCREEN_WIDTH * 0.05333)
            make.height.equalTo(SCREEN_WIDTH * 0.05778)
        }
    }
    
    private func setupScrollView() {
        backView.addSubview(scrollView)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.snp.makeConstraints { make in
            make.left.equalTo(repeatModelBtn.imageView!.snp.right).offset(SCREEN_WIDTH * 0.04)
            make.height.equalTo(0.04433497537 * SCREEN_HEIGHT)
            make.right.equalTo(backView).offset(-SCREEN_WIDTH * 0.08)
            make.centerY.equalTo(repeatModelBtn)
        }
        scrollView.alpha = 0
        scrollView.addSubview(scrContenView)
        scrContenView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
        }
    }
    
    private func setupTypeButton() {
        setupStandardButton(typeBtn, title: "分组", imageName: "finder_todo_group")
        typeBtn.addTarget(self, action: #selector(typeBtnClicked), for: .touchUpInside)
        backView.addSubview(typeBtn)
        typeBtn.snp.makeConstraints { make in
            make.left.equalTo(backView).offset(SCREEN_WIDTH * 0.08)
            make.top.equalTo(backView).offset(SCREEN_HEIGHT * 0.26724)
        }
        typeBtn.imageView?.snp.makeConstraints { make in
            make.left.equalTo(typeBtn)
            make.centerY.equalTo(typeBtn.titleLabel!)
            make.right.equalTo(typeBtn.titleLabel!.snp.left).offset(-SCREEN_WIDTH * 0.032)
            make.width.equalTo(SCREEN_WIDTH * 0.05333)
            make.height.equalTo(SCREEN_WIDTH * 0.05778)
        }
    }
    
    private func setupTypeDetailButton(_ type: ToDoType) {
        if typeDetialButton.superview == nil && typeDetialImgView.superview == nil {
            backView.addSubview(typeDetialButton)
            backView.addSubview(typeDetialImgView)
            typeDetialButton.snp.makeConstraints { make in
                make.centerY.equalTo(typeBtn)
                make.height.equalTo(21)
                make.width.equalTo(45)
                make.right.equalTo(-0.053333 * SCREEN_WIDTH)
            }
            typeDetialImgView.snp.makeConstraints({ make in
                make.left.equalTo(typeDetialButton.titleLabel!.snp.right).offset(5)
                make.centerY.equalTo(typeDetialButton)
                make.width.equalTo(5)
                make.height.equalTo(9.13)
            })
        }
        var titleString = "学习"
        switch type {
        case .study:
            titleString = "学习"
        case .life:
            titleString = "生活"
        case .other:
            titleString = "其他"
        @unknown default:
            fatalError()
        }
        typeDetialButton.setTitle(titleString, for: .normal)
    }
    
    private func setupDeleteButton() {
        deleteBtn.setTitle("删除", for: .normal)
        deleteBtn.setTitleColor(UIColor.ry(light: "#7BA2E9", dark: "#838385"), for: .normal)
        deleteBtn.titleLabel?.font = UIFont(name: PingFangSCMedium, size: 15)
        deleteBtn.alpha = 0
        deleteBtn.addTarget(self, action: #selector(deleteBtnClicked), for: .touchUpInside)
        
        addSubview(deleteBtn)
        deleteBtn.snp.makeConstraints { make in
            make.centerY.equalTo(remindTimeBtn)
            make.right.equalTo(self).offset(-SCREEN_WIDTH * 0.04)
        }
    }
    
    private func setupStandardButton(_ button: UIButton, title: String, imageName: String) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.ry(light: "#2A4E84", dark: "#EFEFF1").withAlphaComponent(0.4), for: .normal)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.setImage(UIImage(named: imageName), for: .highlighted)
        button.titleLabel?.font = UIFont(name: PingFangSCMedium, size: 15)
    }

    // MARK: - 按钮点击事件
    
    @objc private func cancel() {
        UIView.animate(withDuration: 0.5, animations: {
            self.transform = .identity
            self.backgroundColor = .clear
        }) { _ in
            self.removeFromSuperview()
        }
        delegate?.sheetViewCancelBtnClicked()
    }
    
    @objc private func saveBtnClicked() {
        guard let title = titleInputTextField.text, !title.isEmpty else {
            RemindHUD.shared().showDefaultHUD(withText: " 还没有设置标题～ ")
            return
        }
        dataModel.titleStr = title
        delegate?.sheetViewSaveBtnClicked(dataModel)
        cancel()
    }
    
    @objc private func remindTimeBtnClicked() {
        self.endEditing(true)
        self.selectRepeatView.hideView()
        self.selectTypeView.hideView()
        self.selectDateView.showView()
        self.backView.bringSubviewToFront(selectDateView)
    }
    
    @objc private func repeatModelBtnClicked() {
        self.endEditing(true)
        UIView.animate(withDuration: 0.3) {
            self.scrollView.alpha = 0
            self.repeatModelBtn.titleLabel?.alpha = 1
        }
        self.selectDateView.hideView()
        self.selectTypeView.hideView()
        self.selectRepeatView.showView()
        self.backView.bringSubviewToFront(selectRepeatView)
    }
    
    @objc private func typeBtnClicked() {
        self.endEditing(true)
        self.selectRepeatView.hideView()
        self.selectDateView.hideView()
        self.selectTypeView.showView()
        self.backView.bringSubviewToFront(selectTypeView)
    }
    
    @objc private func deleteBtnClicked() {
        UIView.animate(withDuration: 0.5) {
            self.deleteBtn.alpha = 0
        }
        remindTimeBtn.setTitle("设置提醒时间", for: .normal)
        dataModel.timeStr = ""
    }
    
    /// 重新布局重复日期按钮组
    private func reLayoutAllRepeatBtn() {
        var lastConstraint = scrContenView.snp.left
        
        scrContenView.subviews.forEach { $0.removeFromSuperview() }
        for btn in btnArr {
            scrContenView.addSubview(btn)
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
        
        btnArr.first?.snp.updateConstraints({ make in
            make.left.equalTo(scrContenView.snp.left)
        })
        UIView.animate(withDuration: 0.3) {
            self.scrollView.alpha = 1
        }
    }
    
    // MARK: - UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = (textField.text ?? "") as NSString
        let updatedText = currentText.replacingCharacters(in: range, with: string)
        saveBtn.alpha = updatedText.isEmpty ? 0.4 : 1.0
        return true
    }
    
    // MARK: - Helper Methods
    
    private func updateButton(_ button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.ry(light: "#14305B", dark: "#EFEFF1"), for: .normal)
    }
    
    func showView() {
        UIView.animate(withDuration: 0.5, animations: {
            self.transform = CGAffineTransform(translationX: 0, y: -SCREEN_HEIGHT * 0.782019704433498)
            self.backgroundColor = UIColor(hexString: "#000000", alpha: 0.4)
        })
    }
    
//    func configure(with dataModel: TodoDataModel) {
//        self.dataModel = dataModel
//        titleInputTextField.text = dataModel.titleStr
//        if let remindTime = dataModel.getTimeStrDate() {
//            updateButton(remindTimeBtn, title: "提醒时间：" + remindTime.stringWithFormat("yyyy/MM/dd HH:mm"))
//        }
//        if let repeatModel = dataModel.repeatModel {
//            updateButton(repeatModelBtn, title: "重复：" + repeatModel)
//        }
//        deleteBtn.alpha = 1
//    }
}

extension DiscoverTodoSheetView: DiscoverTodoSelectDateViewDelegate {
    // MARK: - DiscoverTodoSelectTimeViewDelegate
    func selectTimeViewSureBtnClicked(date: Date) {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyyy年M月d日 HH:mm"
        let btnString = dateFormatter1.string(from: date)
        remindTimeBtn.setTitle(btnString, for: .normal)
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "yyyy年M月d日HH:mm"
        let modelTimeStr = dateFormatter2.string(from: date)
        self.dataModel.timeStr = modelTimeStr
        UIView.animate(withDuration: 0.5) {
            self.deleteBtn.alpha = 1
        }
    }
    
    func selectTimeViewCancelBtnClicked() {
        
    }
    
    
}

extension DiscoverTodoSheetView: DiscoverTodoSelectRepeatViewDelegate {
    func selectRepeatViewSureBtnClicked(_ view: DiscoverTodoSelectRepeatView) {
        btnArr = []
        // 相当于对view的repeatMode按钮数组做浅拷贝
        for button in view.btnArr {
            let btn = DLTimeSelectedButton()
            btnArr.append(btn)
            btn.setTitle(button.title(for: .normal), for: .normal)
            btn.addTarget(self, action: #selector(repeatModelBtnClicked), for: .touchUpInside)
            btn.delegate = self
        }
        dataModel.repeatMode = view.repeatMode
        switch view.repeatMode {
        case .week:
            dataModel.weekArr = view.dateArr
            break
        case .month:
            dataModel.dayArr = view.dateArr
            break
//        case .year:
//            dataModel.dateArr = view.dateArr.compactMap { $0 as? [String: String] }
//            break
        default:
            break
        }
        if !btnArr.isEmpty {
            UIView.animate(withDuration: 0.3) {
                self.repeatModelBtn.titleLabel?.alpha = 0
                self.scrollView.alpha = 1
            }
        }
    }
    
    func selectRepeatViewCancelBtnClicked() {
        if !btnArr.isEmpty {
            UIView.animate(withDuration: 0.3) {
                self.repeatModelBtn.titleLabel?.alpha = 0
                self.scrollView.alpha = 1
            }
        }
    }
}

extension DiscoverTodoSheetView: DLTimeSelectedButtonDelegate {
    func deleteButton(with button: DLTimeSelectedButton) {
        button.removeFromSuperview()
        // 避免在每天重复的情况下出问题
        if dataModel.repeatMode != .day {
            // 移除日期数组中对应日期
            if let index = btnArr.firstIndex(of: button) {
                selectRepeatView.dateArr.remove(at: index)
                switch dataModel.repeatMode {
                case .week:
                    dataModel.weekArr.remove(at: index)
                    break
                case .month:
                    dataModel.dayArr.remove(at: index)
                    break
//                case .year:
//                    dataModel.dateArr.remove(at: index)
                default:
                    break
                }
            }
        }
        // 从按钮数组中移除按钮
        if let index = btnArr.firstIndex(of: button) {
            selectRepeatView.btnArr[index].removeFromSuperview()
            selectRepeatView.btnArr.remove(at: index)
            btnArr.remove(at: index)
        }
        selectRepeatView.reLayoutAllBtn()
        reLayoutAllRepeatBtn()
    }
}

extension DiscoverTodoSheetView: DiscoverTodoSelectTypeViewDelegate {
    func selectTypeViewSureBtnClicked(_ type: ToDoType) {
        dataModel.typeMode = type
        setupTypeDetailButton(dataModel.typeMode)
    }
    
    func selectTypeViewCancelBtnClicked() {
        
    }
}
