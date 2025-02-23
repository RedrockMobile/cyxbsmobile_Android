//
//  WebAllowController.swift
//  CyxbsMobile2019_iOS
//
//  Created by 潘申冰 on 2023/11/10.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

// MARK: - WebAllowControllerDelegate
/// WebAllowController的代理协议
protocol WebAllowControllerDelegate: AnyObject {

    /// 点击取消时调用
    func webAllowControllerDidCancel(_ controller: WebAllowController)
    
    /// 点击同意时调用
    func webAllowControllerDidConfirm(_ controller: WebAllowController)
}

// MARK: - WebAllowController
/// 显示网页并带有取消和同意按钮的ViewController
class WebAllowController: UIViewController {

    /// 要加载的网页URL
    var url: URL?
    
    /// 代理
    weak var delegate: WebAllowControllerDelegate?
    
    /// 内部使用的WKWebView
    private let webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置导航栏按钮
        setNavigationBarButtons()
        
        // 添加WKWebView
        view.addSubview(webView)
        
        // 加载网页
        webView.load(URLRequest(url: url!))
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    /// 设置导航栏上的按钮
    private func setNavigationBarButtons() {
        // 左侧取消按钮
        let leftButton = UIBarButtonItem(title: "取消", style: .done, target: self, action: #selector(cancel))
        navigationItem.leftBarButtonItem = leftButton
        
        // 右侧同意按钮
        let rightButton = UIBarButtonItem(title: "同意", style: .done, target: self, action: #selector(confirm))
        navigationItem.rightBarButtonItem = rightButton
        
        // 设置导航栏背景色
        navigationController?.navigationBar.backgroundColor = view.backgroundColor
    }

    /// 点击取消按钮的回调
    @objc private func cancel() {
        delegate?.webAllowControllerDidCancel(self)
    }

    /// 点击同意按钮的回调
    @objc private func confirm() {
        delegate?.webAllowControllerDidConfirm(self)
    }

}
