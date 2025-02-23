//
//  popUpInformationVC.swift
//  CyxbsMobile2019_iOS
//
//  Created by 潘申冰 on 2023/11/28.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

// MARK: - PopUpInformationVCDelegate
/// 代理协议
protocol PopUpInformationVCDelegate: AnyObject {

    /// 点击取消时调用
    func PopUpInformationVCDidCancel(_ controller: PopUpInformationVC)
    
    /// 点击同意时调用
    func PopUpInformationVCDidConfirm(_ controller: PopUpInformationVC)
}

// MARK: - PopUpInformationVC
class PopUpInformationVC: UIViewController {
    private var informationContentView: UIButton!
    var titleText: String?
    var contentText: NSMutableAttributedString?
    
    /// 代理
    weak var delegate: PopUpInformationVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        popInformation()
    }
    
    private func popInformation() {
        let contentView = UIButton(frame: view.bounds)
        informationContentView = contentView
        contentView.addTarget(self, action: #selector(cancelLearnAbout), for: .touchUpInside)
        view.addSubview(contentView)
        
        let learnView = UIView()
        learnView.translatesAutoresizingMaskIntoConstraints = false
        learnView.layer.cornerRadius = 16
        learnView.backgroundColor = .ry(light: "#FFFFFF", dark: "#2C2C2C")
        view.addSubview(learnView)
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "温馨提示"
        titleLabel.font = UIFont(name: PingFangSCSemibold, size: 18)
        titleLabel.textColor = .ry(light: "#1e4e84", dark: "#FFFFFF")
        learnView.addSubview(titleLabel)
        
        let contentTextView = UITextView()
        contentTextView.translatesAutoresizingMaskIntoConstraints = false
        contentTextView.attributedText = contentText
        contentTextView.font = UIFont(name: PingFangSC, size: 14)
        contentTextView.isEditable = false
        contentTextView.isScrollEnabled = false
        contentTextView.textAlignment = .center
        contentTextView.backgroundColor = .clear
//        contentTextView.textColor = UIColor(red: 0.08, green: 0.19, blue: 0.36, alpha: 0.6)
        learnView.addSubview(contentTextView)
        
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = UIColor(red: 0.16, green: 0.31, blue: 0.55, alpha: 0.1)
        learnView.addSubview(line)
        
        let cancelButton = UIButton()
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitle("不同意", for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.titleLabel?.font = UIFont(name: PingFangSC, size: 14)
        cancelButton.backgroundColor = UIColor.hex("#BFD5F1")
        cancelButton.layer.cornerRadius = 16
        cancelButton.layer.masksToBounds = true
        cancelButton.addTarget(self, action: #selector(cancelLearnAbout), for: .touchUpInside)
        learnView.addSubview(cancelButton)
        
        let confirmButton = UIButton()
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.setTitle("同意并继续", for: .normal)
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.titleLabel?.font = UIFont(name: PingFangSC, size: 14)
        confirmButton.backgroundColor = UIColor(red: 0.28, green: 0.25, blue: 0.89, alpha: 1)
        confirmButton.layer.cornerRadius = 16
        confirmButton.layer.masksToBounds = true
        confirmButton.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
        learnView.addSubview(confirmButton)
        
        NSLayoutConstraint.activate([
            learnView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            learnView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            learnView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            learnView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            
            titleLabel.topAnchor.constraint(equalTo: learnView.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: learnView.centerXAnchor),
            
            contentTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            contentTextView.leadingAnchor.constraint(equalTo: learnView.leadingAnchor, constant: 18),
            contentTextView.trailingAnchor.constraint(equalTo: learnView.trailingAnchor, constant: -18),
            
            line.topAnchor.constraint(equalTo: contentTextView.bottomAnchor, constant: 10),
            line.leadingAnchor.constraint(equalTo: learnView.leadingAnchor),
            line.trailingAnchor.constraint(equalTo: learnView.trailingAnchor),
            line.heightAnchor.constraint(equalToConstant: 1),
            
            cancelButton.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 26),
            cancelButton.leadingAnchor.constraint(equalTo: learnView.leadingAnchor, constant: 20),
            cancelButton.widthAnchor.constraint(equalToConstant: 100),
            cancelButton.heightAnchor.constraint(equalToConstant: 37),
            
            confirmButton.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 26),
            confirmButton.trailingAnchor.constraint(equalTo: learnView.trailingAnchor, constant: -20),
            confirmButton.widthAnchor.constraint(equalToConstant: 100),
            confirmButton.heightAnchor.constraint(equalToConstant: 37),
            confirmButton.leadingAnchor.constraint(equalTo: cancelButton.trailingAnchor, constant: 10)
        ])
        
        learnView.bottomAnchor.constraint(greaterThanOrEqualTo: cancelButton.bottomAnchor, constant: 20).isActive = true
    }
    
    @objc private func cancelLearnAbout() {
        delegate?.PopUpInformationVCDidCancel(self)
    }
    
    @objc private func confirmAction() {
        delegate?.PopUpInformationVCDidConfirm(self)
    }
}
