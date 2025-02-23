//
//  ActivityAdminRejectVC.swift
//  CyxbsMobile2019_iOS
//
//  Created by 许晋嘉 on 2023/9/25.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit
import SnapKit

class ActivityAdminRejectVC: UIViewController {
    
    var activityId: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backGroundView = UIButton(frame: view.frame)
        backGroundView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        backGroundView.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        let contentView = UIView(frame: CGRectMake((UIScreen.main.bounds.width - 255) / 2, 150 + Constants.statusBarHeight, 255, 207))
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = .white
        view.addSubview(backGroundView)
        backGroundView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(reasonTextfield)
        contentView.addSubview(confirmButton)
        contentView.addSubview(cancelButton)
    }
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: CGRectMake(84.5, 34, 86, 25))
        titleLabel.font = UIFont(name: PingFangSCMedium, size: 18)
        titleLabel.textColor = UIColor(red: 0.082, green: 0.192, blue: 0.357, alpha: 1)
        titleLabel.text = "驳回理由"
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    lazy var reasonTextfield: UITextField = {
        let textfield = UITextField(frame: CGRect(x: 25, y: 73, width: 205, height: 44))
        textfield.layer.cornerRadius = 10
        textfield.backgroundColor = UIColor(red: 0.953, green: 0.973, blue: 0.992, alpha: 1)
        textfield.font = UIFont(name: PingFangSCMedium, size: 14)
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 1))
        textfield.leftViewMode = .always
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor(red: 0.082, green: 0.192, blue: 0.357, alpha: 0.4)] // 在这里设置颜色
        textfield.attributedPlaceholder = NSAttributedString(string: "不得超过十个字", attributes: attributes)
        TextManager.shared.setupLimitForTextField(textfield, maxLength: 10)
        return textfield
    }()
    
    lazy var confirmButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 137, y: 139, width: 93, height: 34))
        button.layer.cornerRadius = 17
        button.setAttributedTitle(NSMutableAttributedString(string: "确认", attributes: [NSAttributedString.Key.kern: 0.56]), for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont(name: PingFangSCMedium, size: 14)
        button.backgroundColor = UIColor(red: 0.29, green: 0.27, blue: 0.89, alpha: 1)
        button.addTarget(self, action: #selector(rejectActivity), for: .touchUpInside)
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 25, y: 139, width: 93, height: 34))
        button.layer.cornerRadius = 17
        button.setAttributedTitle(NSMutableAttributedString(string: "取消", attributes: [NSAttributedString.Key.kern: 0.56]), for: .normal)
        button.titleLabel?.textColor = UIColor(red: 0.765, green: 0.831, blue: 0.933, alpha: 1)
        button.titleLabel?.font = UIFont(name: PingFangSCMedium, size: 14)
        button.backgroundColor = UIColor(red: 0.96, green: 0.98, blue: 1, alpha: 1)
        button.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        return button
    }()

    
    @objc func cancel() {
        self.dismiss(animated: true)
    }
    
    @objc func rejectActivity() {
        if let text = reasonTextfield.text, !text.isEmpty {
            var hudText: String = ""
            //审核活动“驳回”网络请求
            
            HttpManager.shared.magipoke_ufield_activity_examine(activity_id: activityId!, decision: "reject", reject_reason: reasonTextfield.text).ry_JSON { response in
                switch response {
                case .success(let jsonData):
                    let examineResponseData = StandardResponse(from: jsonData)
                    if (examineResponseData.status == 10000) {
                        hudText = "驳回成功"
                    } else {
                        hudText = examineResponseData.info
                    }
                    ActivityHUD.shared.addProgressHUDView(width: TextManager.shared.calculateTextWidth(text: hudText, font: UIFont(name: PingFangSCMedium, size: 13)!)+40,
                                                          height: 36,
                                                          text: hudText,
                                                          font: UIFont(name: PingFangSCMedium, size: 13)!,
                                                          textColor: .white,
                                                          delay: 2,
                                                          backGroundColor: UIColor(hexString: "#2a4e84"),
                                                          cornerRadius: 18,
                                                          yOffset: (Float(-UIScreen.main.bounds.height * 0.5 + Constants.statusBarHeight) + 90)) {
                        self.dismiss(animated: true)
                    }
                    break
                case .failure(let error):
                    print(error)
                    ActivityHUD.shared.showNetworkError()
                    break
                }
            }
        } else {
            ActivityHUD.shared.addProgressHUDView(width: 179,
                                                        height: 36,
                                                        text: "请输入驳回理由",
                                                        font: UIFont(name: PingFangSCMedium, size: 13)!,
                                                        textColor: .white,
                                                        delay: 2,
                                                        backGroundColor: UIColor(hexString: "#2a4e84"),
                                                        cornerRadius: 18,
                                                        yOffset: Float(-UIScreen.main.bounds.height * 0.5 + Constants.statusBarHeight) + 90)
        }
    }
}
