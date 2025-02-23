//
//  ActivityHUD.swift
//  CyxbsMobile2019_iOS
//
//  Created by 许晋嘉 on 2023/8/24.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit
import Alamofire

class ActivityHUD: NSObject {
    static let shared = ActivityHUD()
    private var hud: MBProgressHUD?
    private var tapGesture: UITapGestureRecognizer?
    private var swipeGesture: UISwipeGestureRecognizer?
    
    func addProgressHUDView(width: CGFloat, height: CGFloat, text: String, font: UIFont, textColor: UIColor, delay: CGFloat?, backGroundColor: UIColor, cornerRadius: CGFloat, yOffset: Float, completion: (() -> Void)? = nil) {
        let customView = UIView(frame: CGRectMake(0, 0, width, height))
        customView.layer.backgroundColor = backGroundColor.cgColor
        customView.layer.cornerRadius = cornerRadius
        let label = UILabel()
        label.textAlignment = .center
        label.font = font
        label.text = text
        label.textColor = textColor
        customView.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            hud = MBProgressHUD.showAdded(to: window, animated: true)
            hud?.color = .clear
            hud?.mode = .customView
            hud?.customView = customView
            hud?.yOffset = yOffset
            hud?.isUserInteractionEnabled = false
            hud?.hide(true, afterDelay: delay ?? 2)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + (delay ?? 2)) {
            completion?()
        }
    }
    
    func showNetworkError() {
        ActivityHUD.shared.addProgressHUDView(width: 179,
                                              height: 36,
                                              text: "服务君似乎打盹了呢",
                                              font: UIFont(name: PingFangSCMedium, size: 13)!,
                                              textColor: .white,
                                              delay: 2,
                                              backGroundColor: UIColor(hexString: "#2a4e84"),
                                              cornerRadius: 18,
                                              yOffset: Float(-UIScreen.main.bounds.height * 0.368 + Constants.statusBarHeight))
    }
    
    func showNoMoreData() {
        ActivityHUD.shared.addProgressHUDView(width: 138,
                                              height: 36,
                                              text: "暂无更多内容",
                                              font: UIFont(name: PingFangSCMedium, size: 13)!,
                                              textColor: .white,
                                              delay: 2,
                                              backGroundColor: UIColor(hexString: "#2a4e84"),
                                              cornerRadius: 18,
                                              yOffset: Float(-UIScreen.main.bounds.height * 0.368 + Constants.statusBarHeight))
    }
}
