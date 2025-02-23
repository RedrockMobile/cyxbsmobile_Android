//
//  MarkDownViewController.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/9/25.
//  Copyright © 2023 Redrock. All rights reserved.
//

/* 展示 MarkDown 语法的VC
 设置 url 为 Bundle/Document，会从中读取文本进行加载
 一般来说，我们会使用这个VC和 Navigation 一起使用
 代理不会主动 dismiss，业务方自行决定
 
 ```Swift
 let vc = MarkDownViewController()
 vc.delegate = self
 vc.url = url ?? LoginViewController.agreementURL
 let nav = UINavigationController(rootViewController: vc)
 present(nav, animated: true)
 ```
 */

import UIKit
import MarkdownKit

// MARK: MarkDownViewControllerDelegate

protocol MarkDownViewControllerDelegate: AnyObject {
    
    func mdViewControllerDidCancel(_ controller: MarkDownViewController)
    
    func mdViewControllerDidDown(_ controller: MarkDownViewController)
}

// MARK: MarkDownViewController

class MarkDownViewController: UIViewController {
    
    var url: URL?
    
    weak var delegate: MarkDownViewControllerDelegate?
    
    var textColor: UIColor { .ry(light: "#112C54", dark: "#F0F0F2") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .ry(light: "#F2F3F8", dark: "#000000")
        setNavigationBar()

        view.addSubview(textView)
        asyncShow()
    }
    
    lazy var textView: UITextView = {
        let textView = UITextView(frame: view.bounds)
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.isSelectable = true
        textView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return textView
    }()
}

extension MarkDownViewController {
    
    func setNavigationBar() {
        navigationItem.leftBarButtonItem =  UIBarButtonItem(title: "取消", style: .done, target: self, action: #selector(cancel(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "同意", style: .done, target: self, action: #selector(done(_:)))
        navigationController?.navigationBar.backgroundColor = view.backgroundColor
    }
    
    @objc func cancel(_ sender: UIBarButtonItem) {
        delegate?.mdViewControllerDidCancel(self)
    }
    
    @objc func done(_ sender: UIBarButtonItem) {
        delegate?.mdViewControllerDidDown(self)
    }
    
    func asyncShow() {
        guard let url else { return }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), 
                let string = String(data: data, encoding: .utf8) {
                
                let markdownParser = MarkdownParser(color: .ry(light: "#112C54", dark: "#F0F0F2"))
                markdownParser.header.font = .systemFont(ofSize: 18, weight: .bold)
                
                let attr = markdownParser.parse(string)
                
                DispatchQueue.main.async {
                    self.textView.attributedText = attr
                }
            }
        }
    }
}
