//
//  XBSAlertController.swift
//  CyxbsMobile2019_iOS
//
//  Created by Max Xu on 2024/9/29.
//  Copyright © 2024 Redrock. All rights reserved.
//  掌邮风格的AlertController

import UIKit
import SnapKit

class XBSAlertController: UIViewController {

    // MARK: - Properties
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .ry(light: "#FFFFFF", dark: "#2C2C2C")
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .ry(light: "#15315B", dark: "#F0F0F2")
        label.textAlignment = .center
        return label
    }()
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .ry(light: "#15315B", dark: "#F0F0F2")
        label.textAlignment = .center
        return label
    }()
    private let cancelButton: UIButton = {
        // Configure buttons
        let button = UIButton()
        button.layer.cornerRadius = 18
        button.clipsToBounds = true
        button.backgroundColor = .ry(light: "#C3D4EE", dark: "#515151")
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        return button
    }()
    private let confirmButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 18
        button.clipsToBounds = true
        button.backgroundColor = .ry(light: "#C3D4EE", dark: "#5852FF")
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        return button
    }()
    
    private var confirmAction: (() -> Void)?
    private var cancelAction: (() -> Void)?

    // MARK: - Life Cycle
    init(title: String?, titleFont: UIFont = .systemFont(ofSize: 15), message: String?, messageFont: UIFont = .systemFont(ofSize: 15), confirmTitle: String = "确定", cancelTitle: String = "取消", confirmAction: (() -> Void)?, cancelAction: (() -> Void)?) {
        super.init(nibName: nil, bundle: nil)
        
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .overFullScreen
        
        self.confirmAction = confirmAction
        self.cancelAction = cancelAction
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.addSubview(backgroundView)
        backgroundView.addSubview(titleLabel)
        backgroundView.addSubview(messageLabel)
        backgroundView.addSubview(cancelButton)
        backgroundView.addSubview(confirmButton)
        
        titleLabel.text = title
        titleLabel.font = titleFont
        messageLabel.text = message
        messageLabel.font = messageFont
        cancelButton.setTitle(cancelTitle, for: .normal)
        confirmButton.setTitle(confirmTitle, for: .normal)
        setupConstraints()
        
        let maskTapGes = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        view.addGestureRecognizer(maskTapGes)
        let backgroundTapGes = UITapGestureRecognizer()
        backgroundView.addGestureRecognizer(backgroundTapGes)
        cancelButton.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(handleConfirm), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addBtnGradient(button: confirmButton)
    }
    
    private func setupConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(303)
            make.height.greaterThanOrEqualTo(171)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backgroundView).offset(31)
            make.left.equalTo(backgroundView).offset(16)
            make.right.equalTo(backgroundView).offset(-16)
        }

        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(1)
            make.left.equalTo(backgroundView).offset(16)
            make.right.equalTo(backgroundView).offset(-16)
        }

        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(26.5)
            make.left.equalTo(backgroundView).offset(49.5)
            make.width.equalTo(92)
            make.height.equalTo(36)
        }

        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(26.5)
            make.right.equalTo(backgroundView).offset(-49.5)
            make.width.equalTo(92)
            make.height.equalTo(36)
        }
    }
    
    // MARK: - Methods
    // 给按钮添加渐变
    private func addBtnGradient(button: UIButton) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.init(hexString: "#4741E0").cgColor,
            UIColor.init(hexString: "#5D5EF7").cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = button.bounds
        button.layer.insertSublayer(gradientLayer, at: 0)
    }

    // MARK: - Button Actions
    @objc private func handleConfirm() {
        confirmAction?()
        dismiss(animated: true, completion: nil)
    }

    @objc private func handleCancel() {
        cancelAction?()
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapView(_ tapGes: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}
