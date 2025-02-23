//
//  UFieldActivityAddScrollView.swift
//  CyxbsMobile2019_iOS
//
//  Created by 许晋嘉 on 2023/8/27.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit
import SnapKit

class ActivityUploadScrollView: UIScrollView {
    
    var textFields: [UITextField] = []
    
    // MARK: - 懒加载
    lazy var coverImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "addCover")
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.082, green: 0.192, blue: 0.357, alpha: 1)
        label.font = UIFont(name: PingFangSCMedium, size: 16)
        label.attributedText = NSMutableAttributedString(string: "活动名称", attributes: [NSAttributedString.Key.kern: 0.48])
        return label
    }()
    
    lazy var titleTextfield: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor(red: 0.082, green: 0.192, blue: 0.357, alpha: 1)
        textField.backgroundColor = UIColor(red: 0.946, green: 0.954, blue: 0.962, alpha: 1)
        textField.font = UIFont(name: PingFangSCMedium, size: 14)
        textField.layer.cornerRadius = 4
        textField.clipsToBounds = true
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 1))
        textField.leftViewMode = .always
        let attributedPlaceholder = NSMutableAttributedString(string: "不超过12个字")
        attributedPlaceholder.addAttribute(.foregroundColor, value: UIColor(red: 0.082, green: 0.192, blue: 0.357, alpha: 0.4), range: NSRange(location: 0, length: attributedPlaceholder.length))
        textField.attributedPlaceholder = attributedPlaceholder
        return textField
    }()
    
    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.082, green: 0.192, blue: 0.357, alpha: 1)
        label.font = UIFont(name: PingFangSCMedium, size: 16)
        label.attributedText = NSMutableAttributedString(string: "活动类型", attributes: [NSAttributedString.Key.kern: 0.48])
        return label
    }()
    
    lazy var typeButton: UIButton = {
        let button = UIButton()
        button.setTitle("请选择", for: .normal)
        button.titleLabel?.font = UIFont(name: PingFangSCMedium, size: 14)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -13, bottom: 0, right: 0)
        button.setTitleColor(UIColor(red: 0.161, green: 0.129, blue: 0.82, alpha: 0.6), for: .normal)
        return button
    }()
    
    lazy var typeImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "图标-收纳")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var startTimeView: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.082, green: 0.192, blue: 0.357, alpha: 0.6)
        label.font = UIFont(name: PingFangSCMedium, size: 16)
        label.attributedText = NSMutableAttributedString(string: "开始时间", attributes: [NSAttributedString.Key.kern: 0.48])
        return label
    }()
    
    lazy var endTimeView: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.082, green: 0.192, blue: 0.357, alpha: 0.6)
        label.font = UIFont(name: PingFangSCMedium, size: 16)
        label.attributedText = NSMutableAttributedString(string: "结束时间", attributes: [NSAttributedString.Key.kern: 0.48])
        return label
    }()
    
    lazy var startTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.082, green: 0.192, blue: 0.357, alpha: 0.8)
        label.font = UIFont(name: PingFangSCMedium, size: 14)
        label.text = "请选择开始时间"
        return label
    }()
    
    lazy var endTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.082, green: 0.192, blue: 0.357, alpha: 0.8)
        label.font = UIFont(name: PingFangSCMedium, size: 14)
        label.text = "请选择结束时间"
        return label
    }()
    
    lazy var informationLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.082, green: 0.192, blue: 0.357, alpha: 1)
        label.font = UIFont(name: PingFangSCMedium, size: 16)
        label.attributedText = NSMutableAttributedString(string: "活动信息", attributes: [NSAttributedString.Key.kern: 0.48])
        return label
    }()
    
    lazy var placeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.082, green: 0.192, blue: 0.357, alpha: 0.6)
        label.font = UIFont(name: PingFangSCMedium, size: 16)
        label.attributedText = NSMutableAttributedString(string: "活动地点", attributes: [NSAttributedString.Key.kern: 0.48])
        return label
    }()
    
    lazy var registrationLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.082, green: 0.192, blue: 0.357, alpha: 0.6)
        label.font = UIFont(name: PingFangSCMedium, size: 16)
        label.attributedText = NSMutableAttributedString(string: "报名方式", attributes: [NSAttributedString.Key.kern: 0.48])
        return label
    }()
    
    lazy var organizerLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.082, green: 0.192, blue: 0.357, alpha: 0.6)
        label.font = UIFont(name: PingFangSCMedium, size: 16)
        label.attributedText = NSMutableAttributedString(string: "主办单位", attributes: [NSAttributedString.Key.kern: 0.48])
        return label
    }()
    
    lazy var contactLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.082, green: 0.192, blue: 0.357, alpha: 0.6)
        label.font = UIFont(name: PingFangSCMedium, size: 16)
        label.attributedText = NSMutableAttributedString(string: "创建人联系方式", attributes: [NSAttributedString.Key.kern: 0.48])
        return label
    }()
    
    lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.082, green: 0.192, blue: 0.357, alpha: 1)
        label.font = UIFont(name: PingFangSCMedium, size: 16)
        label.attributedText = NSMutableAttributedString(string: "活动介绍", attributes: [NSAttributedString.Key.kern: 0.48])
        return label
    }()
    
    lazy var placeTextfield: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor(red: 0.082, green: 0.192, blue: 0.357, alpha: 1)
        textField.backgroundColor = UIColor(red: 0.946, green: 0.954, blue: 0.962, alpha: 1)
        textField.font = UIFont(name: PingFangSCMedium, size: 14)
        textField.layer.cornerRadius = 4
        textField.clipsToBounds = true
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 1))
        textField.leftViewMode = .always
        let attributedPlaceholder = NSMutableAttributedString(string: "不超过10个字")
        attributedPlaceholder.addAttribute(.foregroundColor, value: UIColor(red: 0.082, green: 0.192, blue: 0.357, alpha: 0.4), range: NSRange(location: 0, length: attributedPlaceholder.length))
        textField.attributedPlaceholder = attributedPlaceholder
        return textField
    }()
    
    lazy var registrationTextfield: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor(red: 0.082, green: 0.192, blue: 0.357, alpha: 1)
        textField.backgroundColor = UIColor(red: 0.946, green: 0.954, blue: 0.962, alpha: 1)
        textField.font = UIFont(name: PingFangSCMedium, size: 14)
        textField.layer.cornerRadius = 4
        textField.clipsToBounds = true
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 1))
        textField.leftViewMode = .always
        let attributedPlaceholder = NSMutableAttributedString(string: "不超过15个字")
        attributedPlaceholder.addAttribute(.foregroundColor, value: UIColor(red: 0.082, green: 0.192, blue: 0.357, alpha: 0.4), range: NSRange(location: 0, length: attributedPlaceholder.length))
        textField.attributedPlaceholder = attributedPlaceholder
        return textField
    }()
    
    lazy var organizerTextfield: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor(red: 0.082, green: 0.192, blue: 0.357, alpha: 1)
        textField.backgroundColor = UIColor(red: 0.946, green: 0.954, blue: 0.962, alpha: 1)
        textField.font = UIFont(name: PingFangSCMedium, size: 14)
        textField.layer.cornerRadius = 4
        textField.clipsToBounds = true
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 1))
        textField.leftViewMode = .always
        let attributedPlaceholder = NSMutableAttributedString(string: "不超过10个字")
        attributedPlaceholder.addAttribute(.foregroundColor, value: UIColor(red: 0.082, green: 0.192, blue: 0.357, alpha: 0.4), range: NSRange(location: 0, length: attributedPlaceholder.length))
        textField.attributedPlaceholder = attributedPlaceholder
        return textField
    }()
    
    lazy var contactTextfield: UITextField = {
        let textField = UITextField()
        textField.textColor = .red
        textField.backgroundColor = UIColor(red: 0.946, green: 0.954, blue: 0.962, alpha: 1)
        textField.font = UIFont(name: PingFangSCMedium, size: 14)
        textField.layer.cornerRadius = 4
        textField.clipsToBounds = true
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 1))
        textField.leftViewMode = .always
        textField.keyboardType = .numberPad
        let attributedPlaceholder = NSMutableAttributedString(string: "请填写手机号码")
        attributedPlaceholder.addAttribute(.foregroundColor, value: UIColor(red: 0.082, green: 0.192, blue: 0.357, alpha: 0.4), range: NSRange(location: 0, length: attributedPlaceholder.length))
        textField.attributedPlaceholder = attributedPlaceholder
        return textField
    }()
    
    lazy var detailTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: PingFangSCMedium, size: 14)
        textView.backgroundColor = UIColor(red: 0.946, green: 0.954, blue: 0.962, alpha: 1)
        textView.textColor = UIColor(red: 0.082, green: 0.192, blue: 0.357, alpha: 1)
        textView.layer.cornerRadius = 4
        textView.clipsToBounds = true
        textView.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 12)
        textView.placeholder = "关于活动的简介(不超过100个字）"
        textView.placeholderColor = UIColor(red: 0.082, green: 0.192, blue: 0.357, alpha: 0.4)
        return textView
    }()
    
    // MARK: - 设置子控件位置
    func setupUI() {
        
        self.coverImgView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview()
            make.width.equalTo(106)
            make.height.equalTo(106)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(138)
            make.top.equalToSuperview()
            make.width.equalTo(66)
            make.height.equalTo(22)
        }
        
        self.titleTextfield.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(28)
            make.left.equalTo(coverImgView.snp.right).offset(16)
            make.height.equalTo(35)
            make.width.equalTo(UIScreen.main.bounds.width - 154)
        }
        
        self.typeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(138)
            make.top.equalToSuperview().offset(77)
            make.width.equalTo(66)
            make.height.equalTo(22)
        }
        
        self.typeButton.snp.makeConstraints { make in
            make.left.equalTo(self.typeLabel.snp.right).offset(8)
            make.top.equalToSuperview().offset(78)
            make.width.equalTo(58)
            make.height.equalTo(20)
        }
        
        self.typeImgView.snp.makeConstraints { make in
            make.left.equalTo(self.typeLabel.snp.right).offset(55)
            make.top.equalToSuperview().offset(84.5)
            make.width.equalTo(5)
            make.height.equalTo(9.13)
        }
        
        self.startTimeView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(136)
            make.width.equalTo(66)
            make.height.equalTo(22)
        }
        
        self.startTimeLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(95)
            make.top.equalToSuperview().offset(136)
            make.height.equalTo(22)
        }
        
        self.endTimeView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(174)
            make.width.equalTo(66)
            make.height.equalTo(20)
        }
        
        self.endTimeLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(95)
            make.top.equalToSuperview().offset(174)
            make.height.equalTo(20)
        }
        
        self.informationLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(233)
            make.width.equalTo(66)
            make.height.equalTo(22)
        }
        
        self.placeLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(285)
            make.width.equalTo(66)
            make.height.equalTo(22)
        }
        
        self.registrationLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(339)
            make.width.equalTo(66)
            make.height.equalTo(22)
        }
        
        self.organizerLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(393)
            make.width.equalTo(66)
            make.height.equalTo(22)
        }
        
        self.contactLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(448)
            make.width.equalTo(116)
            make.height.equalTo(22)
        }
        
        self.detailLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(513)
            make.width.equalTo(66)
            make.height.equalTo(22)
        }
        
        self.placeTextfield.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(279)
            make.left.equalTo(placeLabel.snp.right).offset(12)
            make.height.equalTo(35)
            make.width.equalTo(UIScreen.main.bounds.width - 110)
        }
        
        self.registrationTextfield.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(333)
            make.left.equalTo(registrationLabel.snp.right).offset(12)
            make.height.equalTo(35)
            make.width.equalTo(UIScreen.main.bounds.width - 110)
        }
        
        self.organizerTextfield.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(387)
            make.left.equalTo(organizerLabel.snp.right).offset(12)
            make.height.equalTo(35)
            make.width.equalTo(UIScreen.main.bounds.width - 110)
        }
        
        self.contactTextfield.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(441)
            make.left.equalTo(contactLabel.snp.right).offset(12)
            make.height.equalTo(35)
            make.width.equalTo(UIScreen.main.bounds.width - 158)
        }
        
        self.detailTextView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(549)
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(147)
            make.width.equalTo(UIScreen.main.bounds.width - 32)
        }

        // 设置 UIScrollView 只能纵向滚动
        isDirectionalLockEnabled = true
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(coverImgView)
        addSubview(titleLabel)
        addSubview(titleTextfield)
        textFields.append(titleTextfield)
        addSubview(typeLabel)
        addSubview(typeButton)
        addSubview(typeImgView)
        addSubview(startTimeView)
        addSubview(endTimeView)
        addSubview(startTimeLabel)
        addSubview(endTimeLabel)
        addSubview(informationLabel)
        addSubview(placeLabel)
        addSubview(registrationLabel)
        addSubview(organizerLabel)
        addSubview(contactLabel)
        addSubview(detailLabel)
        addSubview(placeTextfield)
        textFields.append(placeTextfield)
        addSubview(registrationTextfield)
        textFields.append(registrationTextfield)
        addSubview(organizerTextfield)
        textFields.append(organizerTextfield)
        addSubview(contactTextfield)
        textFields.append(contactTextfield)
        addSubview(detailTextView)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
