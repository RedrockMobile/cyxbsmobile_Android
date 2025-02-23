//
//  ScheduleCustomEditView.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/10/9.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

class ScheduleCustomEditView: UIView {
    
    var backBtnTaped: ((ScheduleCustomEditView) -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isUserInteractionEnabled = true
        addSubview(promptTitleLab)
        addSubview(titleLab)
        addSubview(titleTextField)
        addSubview(placeLab)
        addSubview(placeTextField)
        addSubview(sectionLab)
        addSubview(sectionCollectionView)
        addSubview(periodLab)
        addSubview(periodPicker)
        addSubview(finishBtn)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var size = size
        size.height = finishBtn.frame.maxY + sectionSpace
        return size
    }
    
    // MARK: lazy
    
    lazy var promptTitleLab: UILabel = {
        let lab = createTitleStyleLab(title: "为你的行程添加")
        lab.frame.origin = CGPoint(x: 18, y: itemSpace)
        return lab
    }()
    
    lazy var titleLab: UILabel = {
        let lab = createTitleStyleLab(title: "一个标题")
        lab.frame.origin = CGPoint(x: promptTitleLab.frame.minX, y: promptTitleLab.frame.maxY)
        return lab
    }()

    lazy var titleTextField: UITextField = {
        let textField = createTextField(placeholder: "例如：自习")
        textField.frame.origin.y = titleLab.frame.maxY + itemSpace
        return textField
    }()
    
    lazy var placeLab: UILabel = {
        let lab = createTitleStyleLab(title: "具体内容")
        lab.frame.origin = CGPoint(x: titleLab.frame.minX, y: titleTextField.frame.maxY + sectionSpace)
        return lab
    }()
    
    lazy var placeTextField: UITextField = {
        let textField = createTextField(placeholder: "例如：红岩网校工作站")
        textField.frame.origin.y = placeLab.frame.maxY + itemSpace
        return textField
    }()
    
    lazy var sectionLab: UILabel = {
        let lab = createTitleStyleLab(title: "选择周数")
        lab.frame.origin = CGPoint(x: placeLab.frame.minX, y: placeTextField.frame.maxY + sectionSpace)
        return lab
    }()
    
    lazy var sectionCollectionView: UICollectionView = {
        let width = bounds.width
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let itemWidth = (width - layout.sectionInset.left - layout.sectionInset.right) / 6 - layout.minimumInteritemSpacing
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 0.62)
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: sectionLab.frame.maxY + itemSpace, width: width, height: layout.itemSize.height * 4 + layout.minimumLineSpacing * 3), collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.bounces = false
        collectionView.allowsMultipleSelection = true
        collectionView.register(ScheduleEditSectionCollectionViewCell.self, forCellWithReuseIdentifier: ScheduleEditSectionCollectionViewCell.identifier)
        return collectionView
    }()
    
    lazy var periodLab: UILabel = {
        let lab = createTitleStyleLab(title: "确定时间")
        lab.frame.origin = CGPoint(x: sectionLab.frame.minX, y: sectionCollectionView.frame.maxY + sectionSpace)
        return lab
    }()
    
    lazy var periodPicker: UIPickerView = {
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: periodLab.frame.maxY, width: bounds.width, height: 216))
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    lazy var finishBtn: UIButton = {
        let btn = UIButton()
        btn.isEnabled = false
        btn.frame.origin.y = periodPicker.frame.maxY + sectionSpace
        btn.frame.size = CGSize(width: 66, height: 66)
        btn.center.x = bounds.width / 2
        btn.layer.cornerRadius = 20
        let image = UIImage(named: "direction_goto_right")?
            .scaled(toHeight: 20)?
            .withRenderingMode(.alwaysOriginal)
        btn.setImage(image, for: .normal)
        btn.addTarget(self, action: #selector(touchUpInside(fishishBtn:)), for: .touchUpInside)
        btn.backgroundColor = .hex("#AABBFF")
        return btn
    }()
}

// MARK: creator

extension ScheduleCustomEditView {
    
    var itemSpace: CGFloat { 10 }
    
    var sectionSpace: CGFloat { 20 }
    
    func createTitleStyleLab(title: String?) -> UILabel {
        let lab = UILabel()
        lab.font = .systemFont(ofSize: 28, weight: .semibold)
        lab.textColor = .ry(light: "#122D55", dark: "#F0F0F2")
        lab.text = title
        lab.sizeToFit()
        return lab
    }
    
    func createTextField(placeholder: String?, leftSpace: CGFloat = 16) -> UITextField {
        let textField = UITextField(frame: CGRect(x: leftSpace, y: 0, width: bounds.width - 2 * leftSpace, height: 50))
        textField.layer.cornerRadius = 15
        textField.backgroundColor = .ry(light: "#F2F3F7", dark: "#2D2D2D")
        textField.font = .systemFont(ofSize: 18, weight: .semibold)
        textField.textColor = .ry(light: "#15315B", dark: "#F0F0F2")
        textField.placeholder = placeholder
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 17, height: 0))
        textField.leftViewMode = .always
        textField.delegate = self
        return textField
    }
}

// MARK: useable

extension ScheduleCustomEditView {
    
    var title: String {
        titleTextField.text ?? ""
    }
    
    var place: String {
        placeTextField.text ?? ""
    }
    
    var sections: IndexSet {
        IndexSet(
            sectionCollectionView.indexPathsForSelectedItems?.map { $0.item + 1 } ?? []
        )
    }
    
    var inWeek: Int {
        periodPicker.selectedRow(inComponent: 0) + 1
    }
    
    var period: ClosedRange<Int> {
        (periodPicker.selectedRow(inComponent: 1) + 1) ...
        (periodPicker.selectedRow(inComponent: 1) + periodPicker.selectedRow(inComponent: 2) + 1)
    }
}

// MARK: interactive

extension ScheduleCustomEditView {
    
    func prepare(title: String? = nil, place: String? = nil, sections: IndexSet = [], inWeek: Int, location: Int, lenth: Int = 1) {
        titleTextField.text = title
        placeTextField.text = place
        for section in sections {
            sectionCollectionView.selectItem(at: IndexPath(item: max(0, section - 1), section: 0), animated: true, scrollPosition: .right)
        }
        let inWeek = min(max(1, inWeek), 7)
        periodPicker.selectRow(inWeek - 1, inComponent: 0, animated: false)
        
        let location = min(max(1, location), 12)
        periodPicker.selectRow(location - 1, inComponent: 1, animated: false)
        periodPicker.reloadComponent(2)
        
        let lenth = min(max(1, lenth), periodPicker.numberOfRows(inComponent: 2))
        periodPicker.selectRow(lenth - 1, inComponent: 2, animated: false)
    }
    
    var isInfoVisable: Bool {
        title.count > 0 &&
        place.count > 0 &&
        sections.count > 0
    }
    
    func checkInfoVisable() {
        finishBtn.isEnabled = isInfoVisable
        if isInfoVisable {
            finishBtn.backgroundColor = .hex("#4841E2")
        } else {
            finishBtn.backgroundColor = .hex("#AABBFF")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
        checkInfoVisable()
    }
    
    @objc
    func touchUpInside(fishishBtn: UIButton) {
        backBtnTaped?(self)
    }
}

// MARK: UITextFieldDelegate

extension ScheduleCustomEditView: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        checkInfoVisable()
    }
}

// MARK: UICollectionViewDataSource

extension ScheduleCustomEditView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScheduleEditSectionCollectionViewCell.identifier, for: indexPath) as! ScheduleEditSectionCollectionViewCell
        
        cell.title = ScheduleDataFetch.sectionString(withSection: indexPath.item + 1)
        
        return cell
    }
}

// MARK: UICollectionViewDelegate

extension ScheduleCustomEditView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        checkInfoVisable()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        checkInfoVisable()
    }
}

// MARK: UIPickerViewDataSource

extension ScheduleCustomEditView: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
            case 0: return 7
            case 1: return 12
            case 2: return 12 - pickerView.selectedRow(inComponent: 1)
            default: return 0
        }
    }
}

// MARK: UIPickerViewDelegate

extension ScheduleCustomEditView: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var str: String? = nil
        switch component {
            case 0:
                switch row {
                    case 0: str = "星期一"
                    case 1: str = "星期二"
                    case 2: str = "星期三"
                    case 3: str = "星期四"
                    case 4: str = "星期五"
                    case 5: str = "星期六"
                    case 6: str = "星期天"
                    default: break
                }
            case 1:
                str = "从第\(row + 1)节"
            case 2:
                str = "到第\(pickerView.selectedRow(inComponent: 1) + row + 1)节"
            default: break
        }
        guard let str else { return nil }
        return NSAttributedString(string: str, attributes: [
            .font: UIFont.systemFont(ofSize: 12, weight: .medium),
            .foregroundColor: UIColor.ry(light: "#15315B", dark: "#F0F0F2")
        ])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 1 {
            pickerView.reloadComponent(2)
        }
    }
}
