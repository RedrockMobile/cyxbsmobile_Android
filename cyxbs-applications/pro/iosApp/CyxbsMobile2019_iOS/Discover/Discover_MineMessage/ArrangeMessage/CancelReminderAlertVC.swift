//
//  CancelReminderAlertVC.swift
//  CyxbsMobile2019_iOS
//
//  Created by coin on 2023/10/12.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

protocol CancelReminderAlertVCDelegate: AnyObject {
    func confirmCancel()
}

class CancelReminderAlertVC: UIViewController {
    
    weak var delegate: CancelReminderAlertVCDelegate?

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.addSubview(label)
        customView.addSubview(cancelBtn)
        customView.addSubview(confirmBtn)
        view.addSubview(customView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = UIColor(hexString: "000000", alpha: 0.47)
    }
    
    // MARK: - Method
    
    @objc private func clickCancelBtn() {
        dismiss(animated: false, completion: nil)
    }
    
    @objc private func clickConfirmBtn() {
        dismiss(animated: false, completion: nil)
        delegate?.confirmCancel()
    }

    // MARK: - Lazy
    
    /// 容器视图
    private lazy var customView: UIView = {
        let customView = UIView(frame: CGRect(x: (SCREEN_WIDTH - 270) / 2, y: (SCREEN_HEIGHT - 139) / 2 - 50, width: 270, height: 139))//265
        customView.layer.cornerRadius = 12
        customView.clipsToBounds = true
        customView.backgroundColor = .white
        return customView
    }()
    /// 提示文本
    private lazy var label: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 28, width: customView.width, height: 29))
        label.text = "是否撤回此条行程提醒"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15)
        label.textColor = UIColor(hexString: "#15315B", alpha: 1)
        return label
    }()
    /// 取消按钮
    private lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton(frame: CGRect(x: 30.5, y: label.bottom + 20, width: 92, height: 36))
        cancelBtn.layer.cornerRadius = 20
        cancelBtn.clipsToBounds = true
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.titleLabel?.font = .boldSystemFont(ofSize: 15)
        cancelBtn.backgroundColor = UIColor(hexString: "#C3D4EE", alpha: 1)
        cancelBtn.addTarget(self, action: #selector(clickCancelBtn), for: .touchUpInside)
        return cancelBtn
    }()
    /// 确定按钮
    lazy var confirmBtn: UIButton = {
        let confirmBtn = UIButton(frame: CGRect(x: cancelBtn.right + 20, y: cancelBtn.top, width: cancelBtn.width, height: cancelBtn.height))
        confirmBtn.layer.cornerRadius = 20
        confirmBtn.clipsToBounds = true
        confirmBtn.setTitle("确定", for: .normal)
        confirmBtn.titleLabel?.font = .boldSystemFont(ofSize: 15)
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(hexString: "#4741E0", alpha: 1).cgColor,
            UIColor(hexString: "#5D5EF7", alpha: 1).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = confirmBtn.bounds
        confirmBtn.layer.insertSublayer(gradientLayer, at: 0)
        confirmBtn.addTarget(self, action: #selector(clickConfirmBtn), for: .touchUpInside)
        return confirmBtn
    }()
}
