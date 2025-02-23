//
//  BaseTextFiledViewController.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/9/22.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

class BaseTextFiledViewController: UIViewController {
    
    static let forgotQQGroup = "570919844"
    
    // MARK: use
    
    /* DismissAction
     when you dismiss, use dismiss action
     */
    typealias DismissAction = (_ shouldPresent: Bool, _ optionalVC: BaseTextFiledViewController?) -> ()
    var dismissAction: DismissAction?
    
    /* space
     the space for each TextFiled
     */
    var heightForItem: CGFloat { 48 }
    var marginSpaceForHorizontal: CGFloat { 27 }
    
    /* count Down
     something for countDown
     */
    open var countDownPromptText: String { "重新发送" }
    open func shouldCountDown() -> Bool { true }
    
    // MARK: lazyvar
    
    lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        lab.text = " "
        lab.textColor = UIColor.ry(light: "#15315B", dark: "#F0F0F0")
        lab.font = .systemFont(ofSize: 34, weight: .semibold)
        return lab
    }()
    
    lazy var contentLab: UILabel = {
        let lab = UILabel()
        lab.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        lab.text = " "
        lab.textColor = UIColor.ry(light: "#6C809B", dark: "#909090")
        lab.font = .systemFont(ofSize: 18, weight: .semibold)
        return lab
    }()
    
    // MARK: 不用管

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .ry(light: "#F8F9FC", dark: "#000000")
        view.addSubview(contentView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    lazy var contentView: UIView = {
        let view = UIView(frame: view.bounds)
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var addNotification: Void = {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowNotification(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideNotification(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }()
}

// MARK: useable

extension BaseTextFiledViewController {
    
    static func afterCallAction(showVC shouldShow: Bool, action: @escaping DismissAction) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if shouldShow {
                
                let vc = RYLoginViewController()
                vc.dismissAction = action
                action(true, vc)
            } else {
                
                action(false, nil)
            }
        }
    }
    
    func askToQQGroup() {
        let vc = UIAlertController(title: "无法找回密码", message: "你从未绑定过你的邮箱，也未绑定过问题，请添加我们的QQ群，联系相关人员进行找回。QQ群:" + RYLoginViewController.forgotQQGroup, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "确定", style: .cancel)
        vc.addAction(cancel)
        present(vc, animated: true)
    }
}

// MARK: fact

extension BaseTextFiledViewController {
    
    func createLoginTypeTextFiled(placeholder: String, leftImgName: String) -> UITextField {
        let textField = UITextField(frame: CGRect(x: marginSpaceForHorizontal, y: 0, width: view.bounds.width - 2 * marginSpaceForHorizontal, height: heightForItem))
        textField.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        textField.backgroundColor = .clear
        textField.attributedPlaceholder =
        NSAttributedString(string: placeholder, attributes: [
            .font: UIFont.systemFont(ofSize: 14, weight: .medium),
            .foregroundColor: UIColor.ry(light: "#8B8B8B", dark: "#C2C2C2")
        ])
        textField.textColor = .ry(light: "#242424", dark: "#E9E9E9")
        textField.font = .systemFont(ofSize: 16, weight: .bold)
        
        let leftBackView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: textField.bounds.height))
        let leftImgView = UIImageView(frame: leftBackView.bounds)
        leftImgView.autoresizingMask = [.flexibleHeight]
        leftImgView.contentMode = .left
        leftImgView.image = UIImage(named: leftImgName)?.scaled(toWidth: 20)
        leftBackView.addSubview(leftImgView)
        textField.leftView = leftBackView
        textField.leftViewMode = .always
        
        let line = UIView(frame: CGRect(x: 0, y: heightForItem - 1, width: textField.bounds.width, height: 1))
        line.backgroundColor = .ry(light: "#E2EDFB", dark: "#7C7C7C")
        
        return textField
    }
    
    func createForgotTypeTextFiled(placeholder: String?, leftImgName: String?, countDown: Bool = false) -> UITextField {
        let textField = UITextField(frame: CGRect(x: marginSpaceForHorizontal, y: 0, width: view.bounds.width - 2 * marginSpaceForHorizontal, height: heightForItem))
        textField.layer.cornerRadius = 15
        textField.backgroundColor = .ry(light: "#F2F3F7", dark: "#2D2D2D")
        textField.font = .systemFont(ofSize: 18, weight: .semibold)
        textField.textColor = .ry(light: "#15315B", dark: "#F0F0F2")
        textField.placeholder = placeholder
        
        let leftBackView = UIView(frame: CGRect(x: 0, y: 0, width: 17, height: 0))
        textField.leftView = leftBackView
        textField.leftViewMode = .always
        if let leftImgName {
            view.frame.size.width = 40
            let leftImgView = UIImageView(frame: leftBackView.bounds)
            leftImgView.autoresizingMask = [.flexibleHeight]
            leftImgView.contentMode = .left
            leftImgView.image = UIImage(named: leftImgName)?.scaled(toWidth: 20)
            leftBackView.addSubview(leftImgView)
        }
        
        if countDown {
            let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: textField.bounds.height))
            
            let btn = UIButton(frame: rightView.bounds)
            btn.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            btn.setTitle(countDownPromptText, for: .normal)
            btn.setTitleColor(.label, for: .normal)
            btn.titleLabel?.textAlignment = .center
            btn.titleLabel?.font = .systemFont(ofSize: 14)
            btn.addTarget(self, action: #selector(openCountdown(btn:)), for: .touchUpInside)
            btn.setTitleColor(.hex("#3C3C3C"), for: .normal)
            
            rightView.addSubview(btn)
            
            textField.rightView = rightView
            textField.rightViewMode = .always
        }
        
        textField.delegate = self
        return textField
    }
    
    func createSureButton(size: CGSize,
                          title: String?,
                          touchUpInside: Selector) -> UIButton {
        let btn = UIButton()
        btn.frame.size = size
        btn.layer.cornerRadius = size.height / 2
        btn.clipsToBounds = true
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        btn.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        btn.backgroundColor = .ry(light: "#C2CBFE", dark: "#AFBAD6")
        btn.addTarget(self, action: touchUpInside, for: .touchUpInside)
        return btn
    }
    
    func createSmallBtn(title: String?, touchUpInsideAction action: Selector) -> UIButton {
        let btn = UIButton()
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        btn.setTitleColor(.hex("#4841E2"), for: .normal)
        btn.sizeToFit()
        btn.frame.origin = CGPoint(x: view.bounds.width - 17, y: Constants.statusBarHeight + 10)
        btn.backgroundColor = .ry(light: "#F2F3F8", dark: "#000000").withAlphaComponent(0.6)
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.addTarget(self, action: action, for: .touchUpInside)
        return btn
    }
    
    func createDetailBtn(title: String?, touchUpInsideAction action: Selector) -> UIButton {
        let btn = UIButton()
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(.gray, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 14)
        btn.addTarget(self, action: action, for: .touchUpInside)
        btn.sizeToFit()
        return btn
    }
}

// MARK: interactive

extension BaseTextFiledViewController {
    
    // 倒计时
    @objc
    func openCountdown(btn: UIButton) {
        
        if !shouldCountDown() { return }
        
        var time = 59 // 倒计时时间
        weak var timerBtn = btn // 防止btn没了，但timer还在
        let queue = DispatchQueue.global(qos: .default)
        let timer = DispatchSource.makeTimerSource(queue: queue)
        timer.schedule(deadline: .now(), repeating: .seconds(1))

        timer.setEventHandler {
            if time <= 0 { // 倒计时结束，关闭
                timer.cancel()
                DispatchQueue.main.async {
                    // 设置按钮的样式
                    timerBtn?.setTitle(self.countDownPromptText, for: .normal)
                    timerBtn?.setTitleColor(.hex("#3C3C3C"), for: .normal)
                    timerBtn?.isUserInteractionEnabled = true
                }
            } else {
                let seconds = time % 60
                DispatchQueue.main.async {
                    // 设置按钮显示读秒效果
                    timerBtn?.setTitle(String(format: self.countDownPromptText + "(%.2d)", seconds), for: .normal)
                    timerBtn?.setTitleColor(.hex("#979797"), for: .normal)
                    timerBtn?.isUserInteractionEnabled = false
                }
                time -= 1
            }
        }

        timer.resume()
    }
    
    @objc
    func keyboardWillShowNotification(_ notification: Notification) {
        if let info = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            if let textField = UIResponder.firstResponder as? UITextField {
                let bottom = view.convert(info, to: view).minY
                if textField.frame.maxY + marginSpaceForHorizontal <= bottom {
                    UIView.animate(withDuration: 0.3) {
                        self.contentView.frame.origin.y = 0
                    }
                    return
                }
                UIView.animate(withDuration: 0.3) {
                    self.contentView.frame.origin.y -= (textField.frame.maxY - (bottom - self.marginSpaceForHorizontal))
                }
            }
        }
    }
    
    @objc
    func keyboardWillHideNotification(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.contentView.frame.origin.y = 0
        }
    }
}

// MARK: UITextFieldDelegate

extension BaseTextFiledViewController: UITextFieldDelegate {
    
}
