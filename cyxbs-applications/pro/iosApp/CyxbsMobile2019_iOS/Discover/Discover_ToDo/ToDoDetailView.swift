//
//  ToDoDetailView.swift
//  CyxbsMobile2019_iOS
//
//  Created by coin on 2024/8/24.
//  Copyright © 2024 Redrock. All rights reserved.
//

import UIKit

protocol ToDoDetailViewDelegate: AnyObject {
    func returnToPrevious()
    func saveTheChanges()
    func deleteTime()
    func deleteRepeat(str: String)
}

class ToDoDetailView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: ToDoDetailViewDelegate?
    
    var stringMap = [Int: String]()

    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(.dm, light: UIColor(hexString: "#FFFFFF", alpha: 1), dark: UIColor(hexString: "#000000", alpha: 1))
        addSubview(backBtn)
        addSubview(saveBtn)
        addSubview(nameLab)
        addSubview(nameTextFieldBackView)
        nameTextFieldBackView.addSubview(nameTextField)
        addSubview(deadlineLab)
        addSubview(timeLab)
        addSubview(timeForkBtn)
        addSubview(firstSplitLineView)
        addSubview(repeatLab)
        addSubview(repeatScrollView)
        addSubview(secondSplitLineView)
        addSubview(groupLab)
        addSubview(groupBtn)
        addSubview(thirdSplitLineView)
        addSubview(noteLab)
        addSubview(noteTextView)
        addSubview(placeHolderLab)
        addSubview(blackBackView)
        addSubview(whiteBackView)
        whiteBackView.addSubview(selectDateView)
        whiteBackView.addSubview(selectRepeatView)
        whiteBackView.addSubview(selectTypeView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backBtn.frame = CGRect(x: 16, y: statusBarHeight + 16, width: 7, height: 16)
        saveBtn.frame = CGRect(x: self.right - 50 - 15, y: statusBarHeight + 9, width: 50, height: 30)
        nameLab.frame = CGRect(x: 16, y: saveBtn.bottom + 27, width: 83, height: 28)
        nameTextFieldBackView.frame = CGRect(x: 16, y: nameLab.bottom + 12, width: self.width - 16 * 2, height: 40)
        nameTextField.frame = CGRect(x: 24, y: 0, width: nameTextFieldBackView.width - 24 * 2, height: nameTextFieldBackView.height)
        deadlineLab.frame = CGRect(x: 16, y: nameTextFieldBackView.bottom + 32, width: 75, height: 25)
        timeLab.frame = CGRect(x: deadlineLab.left, y: deadlineLab.bottom + 10, width: self.width - deadlineLab.left, height: 21)
        timeForkBtn.frame = CGRect(x: self.right - 14 - 21.8, y: deadlineLab.bottom + 13, width: 14, height: 14)
        firstSplitLineView.frame = CGRect(x: 16, y: timeLab.bottom + 4, width: SCREEN_WIDTH - 16 * 2, height: 1)
        repeatLab.frame = CGRect(x: deadlineLab.left, y: firstSplitLineView.bottom + 28, width: 37, height: 25)
        repeatScrollView.frame = CGRect(x: 11, y: repeatLab.bottom + 6, width: self.width - 11, height: 36)
        secondSplitLineView.frame = CGRect(x: firstSplitLineView.left, y: repeatScrollView.bottom + 6, width: firstSplitLineView.width, height: firstSplitLineView.height)
        groupLab.frame = CGRect(x: repeatLab.left, y: secondSplitLineView.bottom + 28, width: 37, height: 25)
        groupBtn.frame = CGRect(x: self.right - 59, y: secondSplitLineView.bottom + 30, width: 44, height: 21)
        thirdSplitLineView.frame = CGRect(x: secondSplitLineView.left, y: groupLab.bottom + 6, width: secondSplitLineView.width, height: 1)
        noteLab.frame = CGRect(x: groupLab.left, y: thirdSplitLineView.bottom + 28, width: 37, height: 25)
        noteTextView.frame = CGRect(x: noteLab.left, y: noteLab.bottom + 10, width: self.width - noteLab.left * 2, height: 100)
        placeHolderLab.frame = CGRect(x: noteTextView.left, y: noteTextView.top, width: 171, height: 21)
        blackBackView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        whiteBackView.frame = CGRect(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: SCREEN_HEIGHT * 0.562807881773399)
        selectDateView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height:  whiteBackView.height)
        selectRepeatView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 0.5 * SCREEN_HEIGHT)
        selectTypeView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 0.5 * SCREEN_HEIGHT)
    }
    
    // MARK: - Method
    
    @objc private func clickBackBtn() {
        delegate?.returnToPrevious()
    }
    
    @objc private func clickSaveBtn() {
        if nameTextField.text == "" {
            addTipsView(frame: CGRect(x: (self.width - 200) / 2, y: 67, width: 200, height: 36))
        } else {
            delegate?.saveTheChanges()
        }
    }
    
    @objc private func clickTimeForkBtn() {
        timeLab.textColor = UIColor(.dm, light: UIColor(hexString: "#A1ADBC", alpha: 1), dark: UIColor(hexString: "#767677", alpha: 1))
        delegate?.deleteTime()
    }
    
    @objc private func tapTimeLab() {
        saveBtn.isUserInteractionEnabled = true
        saveBtn.setTitleColor(UIColor(.dm, light: UIColor(hexString: "#2923D2", alpha: 1), dark: UIColor(hexString: "#2CDEFF", alpha: 1)), for: .normal)
        selectDateView.showView()
        selectTypeView.hideView()
        selectRepeatView.hideView()
        UIView.animate(withDuration: 0.3) {
            self.blackBackView.alpha = 1
            self.whiteBackView.top = SCREEN_HEIGHT * 0.43
        }
    }
    
    @objc private func tapRepeatScrollView() {
        saveBtn.isUserInteractionEnabled = true
        saveBtn.setTitleColor(UIColor(.dm, light: UIColor(hexString: "#2923D2", alpha: 1), dark: UIColor(hexString: "#2CDEFF", alpha: 1)), for: .normal)
        selectRepeatView.showView()
        selectTypeView.hideView()
        selectDateView.hideView()
        UIView.animate(withDuration: 0.3) {
            self.blackBackView.alpha = 1
            self.whiteBackView.top = SCREEN_HEIGHT * 0.5
        }
    }
    
    @objc private func clickGroupBtn() {
        saveBtn.isUserInteractionEnabled = true
        saveBtn.setTitleColor(UIColor(.dm, light: UIColor(hexString: "#2923D2", alpha: 1), dark: UIColor(hexString: "#2CDEFF", alpha: 1)), for: .normal)
        selectTypeView.showView()
        selectRepeatView.hideView()
        selectDateView.hideView()
        UIView.animate(withDuration: 0.3) {
            self.blackBackView.alpha = 1
            self.whiteBackView.top = SCREEN_HEIGHT * 0.5
        }
    }
    
    func createNotRepeateCell() -> UIView {
        let cell = UIView(frame: CGRect(x: 0, y: 4, width: 120, height: 32))
        cell.layer.cornerRadius = 15
        cell.clipsToBounds = true
        cell.backgroundColor = UIColor(.dm, light: UIColor(hexString: "#F2F5FF", alpha: 1), dark: UIColor(hexString: "#2D2D2D", alpha: 1))
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: cell.width, height: cell.height))
        label.text = "设置重复时间"
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = UIColor(.dm, light: UIColor(hexString: "#7D91B2", alpha: 1), dark: UIColor(hexString: "#B6B6B7", alpha: 1))
        cell.addSubview(label)
        
        return cell
    }
    
    func createRepeatCell(dateStr: String, leftPos: CGFloat, width: CGFloat) -> UIView {
        let cell = UIView(frame: CGRect(x: leftPos, y: 0, width: width, height: 36))
        cell.backgroundColor = .clear
        
        let backView = UIView(frame: CGRect(x: 0, y: 4, width: cell.width - 3, height: cell.height - 4))
        backView.layer.cornerRadius = 15
        backView.clipsToBounds = true
        backView.backgroundColor = UIColor(.dm, light: UIColor(hexString: "#F2F5FF", alpha: 1), dark: UIColor(hexString: "#2D2D2D", alpha: 1))
        cell.addSubview(backView)
        
        let label = UILabel(frame: backView.frame)
        label.text = dateStr
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = UIColor(.dm, light: UIColor(hexString: "#40639D", alpha: 1), dark: UIColor(hexString: "#B6B6B7", alpha: 1))
        cell.addSubview(label)
        
        let button = UIButton(frame: CGRect(x: cell.width - 15, y: 0, width: 15, height: 15))
        button.setBackgroundImage(UIImage(named: "todoFork"), for: .normal)
        button.addTarget(self, action: #selector(clickDeleteRepeat(button:)), for: .touchUpInside)
        cell.addSubview(button)
        
        button.tag = repeatScrollView.subviews.count
        stringMap[button.tag] = dateStr
        
        return cell
    }
    
    @objc private func clickDeleteRepeat(button: UIButton) {
        let str = stringMap[button.tag] ?? ""
        delegate?.deleteRepeat(str: str)
        saveBtn.isUserInteractionEnabled = true
        saveBtn.setTitleColor(UIColor(.dm, light: UIColor(hexString: "#2923D2", alpha: 1), dark: UIColor(hexString: "#2CDEFF", alpha: 1)), for: .normal)
    }
    
    @objc private func nameTextFieldChange() {
        saveBtn.isUserInteractionEnabled = true
        saveBtn.setTitleColor(UIColor(.dm, light: UIColor(hexString: "#2923D2", alpha: 1), dark: UIColor(hexString: "#2CDEFF", alpha: 1)), for: .normal)
    }
    
    private func addTipsView(frame: CGRect) {
        let tipsView = UIView(frame: frame)
        tipsView.layer.cornerRadius = 17
        tipsView.clipsToBounds = true
        tipsView.backgroundColor = UIColor(.dm, light: UIColor(hexString: "#2D4D80", alpha: 1), dark: UIColor(hexString: "#DFDFE3", alpha: 1))
        
        let tipsLab = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        tipsLab.font = .systemFont(ofSize: 13)
        tipsLab.text = "掌友，标题不能为空哦！"
        tipsLab.textColor = UIColor(.dm, light: UIColor(hexString: "#FFFFFF", alpha: 1), dark: UIColor(hexString: "#2D2D2D", alpha: 1))
        tipsLab.textAlignment = .center
        
        tipsView.addSubview(tipsLab)
        addSubview(tipsView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            tipsView.removeFromSuperview()
        }
    }
    
    // MARK: - Lazy
    
    /// 返回按钮
    private lazy var backBtn: MXBackButton = {
        let backBtn = MXBackButton(frame: .zero, isAutoHotspotExpand: true)
        backBtn.setImage(UIImage(named: "todo返回按钮"), for: .normal)
        backBtn.addTarget(self, action: #selector(clickBackBtn), for: .touchUpInside)
        return backBtn
    }()
    /// 保存按钮
    lazy var saveBtn: UIButton = {
        let saveBtn = UIButton()
        saveBtn.setTitle("保存", for: .normal)
        saveBtn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        saveBtn.setTitleColor(UIColor(.dm, light: UIColor(hexString: "#A1ADBC", alpha: 1), dark: UIColor(hexString: "#606161", alpha: 1)), for: .normal)
        saveBtn.addTarget(self, action: #selector(clickSaveBtn), for: .touchUpInside)
        saveBtn.isUserInteractionEnabled = false
        return saveBtn
    }()
    /// '待办名称'文本
    private lazy var nameLab: UILabel = {
        let nameLab = UILabel()
        nameLab.text = "待办名称"
        nameLab.font = .boldSystemFont(ofSize: 20)
        nameLab.textColor = UIColor(.dm, light: UIColor(hexString: "#15315B", alpha: 1), dark: UIColor(hexString: "#F0F0F2", alpha: 1))
        return nameLab
    }()
    /// 名称输入框背景视图
    private lazy var nameTextFieldBackView: UIView = {
        let nameTextFieldBackView = UIView()
        nameTextFieldBackView.layer.cornerRadius = 20
        nameTextFieldBackView.clipsToBounds = true
        nameTextFieldBackView.backgroundColor = UIColor(.dm, light: UIColor(hexString: "#F2F5FF", alpha: 1), dark: UIColor(hexString: "#2D2D2D", alpha: 1))
        return nameTextFieldBackView
    }()
    /// 名称输入框
    lazy var nameTextField: UITextField = {
        let nameTextField = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(.dm, light: UIColor(hexString: "#9195B7", alpha: 1), dark: UIColor(hexString: "#606162", alpha: 1)),
            .font: UIFont.systemFont(ofSize: 16)
        ]
        let attributedPlaceholder = NSAttributedString(string: "输入待办名称", attributes: attributes)
        nameTextField.attributedPlaceholder = attributedPlaceholder
        nameTextField.font = .systemFont(ofSize: 16)
        nameTextField.textColor = UIColor(.dm, light: UIColor(hexString: "#515689", alpha: 1), dark: UIColor(hexString: "#F0F0F2", alpha: 1))
        nameTextField.returnKeyType = .done
        nameTextField.addTarget(self, action: #selector(nameTextFieldChange), for: .editingChanged)
        return nameTextField
    }()
    /// '截止时间'文本
    private lazy var deadlineLab: UILabel = {
        let deadlineLab = UILabel()
        deadlineLab.text = "截止时间"
        deadlineLab.font = .systemFont(ofSize: 18)
        deadlineLab.textColor = UIColor(.dm, light: UIColor(hexString: "#15315B", alpha: 1), dark: UIColor(hexString: "#F0F0F2", alpha: 1))
        return deadlineLab
    }()
    /// 时间文本
    lazy var timeLab: UILabel = {
        let timeLab = UILabel()
        timeLab.font = .systemFont(ofSize: 15)
        timeLab.textColor = UIColor(.dm, light: UIColor(hexString: "#A1ADBC", alpha: 1), dark: UIColor(hexString: "#767677", alpha: 1))
        timeLab.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapTimeLab))
        timeLab.addGestureRecognizer(gesture)
        return timeLab
    }()
    /// 截止时间的叉
    lazy var timeForkBtn: UIButton = {
        let timeForkBtn = UIButton()
        timeForkBtn.setBackgroundImage(UIImage(named: "fork"), for: .normal)
        timeForkBtn.addTarget(self, action: #selector(clickTimeForkBtn), for: .touchUpInside)
        return timeForkBtn
    }()
    /// 第一根分割线
    private lazy var firstSplitLineView: UIView = {
        let firstSplitLineView = UIView()
        firstSplitLineView.backgroundColor = UIColor(.dm, light: UIColor(hexString: "#F2F5FA", alpha: 1), dark: UIColor(hexString: "#262A2F", alpha: 1))
        return firstSplitLineView
    }()
    /// '重复'文本
    private lazy var repeatLab: UILabel = {
        let repeatLab = UILabel()
        repeatLab.text = "重复"
        repeatLab.font = .systemFont(ofSize: 18)
        repeatLab.textColor = UIColor(.dm, light: UIColor(hexString: "#15315B", alpha: 1), dark: UIColor(hexString: "#F0F0F2", alpha: 1))
        return repeatLab
    }()
    /// 重复的时间
    lazy var repeatScrollView: UIScrollView = {
        let repeatScrollView = UIScrollView()
        repeatScrollView.isScrollEnabled = true
        repeatScrollView.showsVerticalScrollIndicator = false
        repeatScrollView.showsHorizontalScrollIndicator = false
        repeatScrollView.contentInsetAdjustmentBehavior = .never
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapRepeatScrollView))
        repeatScrollView.addGestureRecognizer(gesture)
        return repeatScrollView
    }()
    /// 第二根分割线
    private lazy var secondSplitLineView: UIView = {
        let secondSplitLineView = UIView()
        secondSplitLineView.backgroundColor = UIColor(.dm, light: UIColor(hexString: "#F2F5FA", alpha: 1), dark: UIColor(hexString: "#262A2F", alpha: 1))
        return secondSplitLineView
    }()
    /// '分组'文本
    private lazy var groupLab: UILabel = {
        let groupLab = UILabel()
        groupLab.text = "分组"
        groupLab.font = .systemFont(ofSize: 18)
        groupLab.textColor = UIColor(.dm, light: UIColor(hexString: "#15315B", alpha: 1), dark: UIColor(hexString: "#F0F0F2", alpha: 1))
        return groupLab
    }()
    /// 分组按钮
    lazy var groupBtn: UIButton = {
        let groupBtn = UIButton()
        groupBtn.titleLabel?.font = .systemFont(ofSize: 15)
        groupBtn.setTitleColor(UIColor(.dm, light: UIColor(hexString: "#514DEB", alpha: 1), dark: UIColor(hexString: "#5263FF", alpha: 1)), for: .normal)
        groupBtn.setImage(UIImage(named: "todoLeftArrow"), for: .normal)
        groupBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: -9, bottom: 0, right: 9)
        groupBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 33, bottom: 0, right: -33)
        groupBtn.addTarget(self, action: #selector(clickGroupBtn), for: .touchUpInside)
        return groupBtn
    }()
    /// 第三根分割线
    private lazy var thirdSplitLineView: UIView = {
        let thirdSplitLineView = UIView()
        thirdSplitLineView.backgroundColor = UIColor(.dm, light: UIColor(hexString: "#F2F5FA", alpha: 1), dark: UIColor(hexString: "#262A2F", alpha: 1))
        return thirdSplitLineView
    }()
    /// '备注'文本
    private lazy var noteLab: UILabel = {
        let noteLab = UILabel()
        noteLab.text = "备注"
        noteLab.font = .systemFont(ofSize: 18)
        noteLab.textColor = UIColor(.dm, light: UIColor(hexString: "#15315B", alpha: 1), dark: UIColor(hexString: "#F0F0F2", alpha: 1))
        return noteLab
    }()
    /// 备注输入框
    lazy var noteTextView: UITextView = {
        let noteTextView = UITextView()
        noteTextView.autocorrectionType = .no
        noteTextView.autocapitalizationType = .none
        noteTextView.backgroundColor = UIColor(.dm, light: UIColor(hexString: "#FFFFFF", alpha: 1), dark: UIColor(hexString: "#000000", alpha: 1))
        noteTextView.font = .systemFont(ofSize: 15)
        noteTextView.textContainer.lineFragmentPadding = 0
        noteTextView.textColor = UIColor(.dm, light: UIColor(hexString: "#15315B", alpha: 1), dark: UIColor(hexString: "#F0F0F2", alpha: 1))
        return noteTextView
    }()
    /// 输入框的水印文本
    lazy var placeHolderLab: UILabel = {
        let placeHolderLab = UILabel()
        placeHolderLab.text = "添加备注，不超过100字"
        placeHolderLab.font = .systemFont(ofSize: 15)
        placeHolderLab.textColor = UIColor(.dm, light: UIColor(hexString: "#A1ADBC", alpha: 1), dark: UIColor(hexString: "#767677", alpha: 1))
        return placeHolderLab
    }()
    /// 黑色蒙板
    lazy var blackBackView: UIView = {
        let blackBackView = UIView()
        blackBackView.backgroundColor = UIColor(.dm, light: UIColor(hexString: "#000000", alpha: 0.14), dark: UIColor(hexString: "#000000", alpha: 0.5))
        blackBackView.alpha = 0
        return blackBackView
    }()
    /// 圆角背景，非黑暗模式下为白色
    lazy var whiteBackView: UIView = {
        let whiteBackView = UIView()
        whiteBackView.backgroundColor = UIColor(.dm, light: UIColor(hexString: "#FFFFFF", alpha: 1), dark: UIColor(hexString: "#2D2D2D", alpha: 1))
        
        let rect = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT * 0.74)
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 16, height: 16))
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        whiteBackView.layer.mask = layer
        return whiteBackView
    }()
    /// 时间选择
    lazy var selectDateView: DiscoverTodoSelectDateView = {
        let selectDateView = DiscoverTodoSelectDateView()
        selectDateView.separatorLine.removeFromSuperview()
        selectDateView.selectTimeView.separatorLine.removeFromSuperview()
        return selectDateView
    }()
    /// 重复选择
    lazy var selectRepeatView: DiscoverTodoSelectRepeatView = {
        let selectRepeatView = DiscoverTodoSelectRepeatView()
        selectRepeatView.separatorLine.removeFromSuperview()
        return selectRepeatView
    }()
    /// 分组选择
    lazy var selectTypeView: DiscoverTodoSelectTypeView = {
        let selectTypeView = DiscoverTodoSelectTypeView()
        selectTypeView.separatorLine.removeFromSuperview()
        return selectTypeView
    }()
}
