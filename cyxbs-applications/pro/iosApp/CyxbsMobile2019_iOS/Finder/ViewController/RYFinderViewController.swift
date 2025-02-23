//
//  RYFinderViewController.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/9/5.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit
import SnapKit

class RYFinderViewController: UIViewController {
    
    // 适配OC
    // 体育打卡
    lazy var sportsVC = DiscoverSAVC()
    // 电费
    lazy var electricVC = ElectricViewController()
    lazy var ToDoMainPageVC: ToDoFinderVC = {
        let vc = ToDoFinderVC()
        vc.delegate = self
        return vc
    }()
    private var todoHeightConstraint: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(ToDoMainPageVC)
        addChild(sportsVC)
        addChild(electricVC)
        
        view.backgroundColor = .ry(light: "#F2F3F8", dark: "#000000")
        
        view.addSubview(contentScrollView)
        setupUI()
        setupToDo()
        setupElectric()
        setupSA()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //刷新消息中心小圆点
        reloadData()
    }
    
    lazy var contentScrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    lazy var headerView: RYFinderHeaderView = {
        let headerView = RYFinderHeaderView(frame: CGRect(x: marginSpaceForHorizontal, y: Constants.statusBarHeight, width: view.bounds.width - 2 * marginSpaceForHorizontal, height: 55))
        headerView.messageBtnTouched = { theView in
            let vc = MineMessageVC()
            vc.hidesBottomBarWhenPushed = true
            theView.latestViewController?.navigationController?.pushViewController(vc, animated: true)
        }
        headerView.attendanceBtnTouched = { theView in
            let vc = CheckInViewController()
            vc.modalPresentationStyle = .fullScreen
            vc.hidesBottomBarWhenPushed = true
            theView.latestViewController?.present(vc, animated: true)
        }
        return headerView
    }()
    
    lazy var bannerView: FinderBannerView = {
        let aspectRatio: CGFloat = 343.0 / 134.0
        let width = view.bounds.width - 2 * marginSpaceForHorizontal
        let bannerView = FinderBannerView(frame: CGRect(x: marginSpaceForHorizontal, y: headerView.frame.maxY + 6, width: width, height: width / aspectRatio))
        return bannerView
    }()
    
    lazy var newsView: FinderNewsView = {
        let width = view.bounds.width - 2 * marginSpaceForHorizontal
        let newsView = FinderNewsView(frame: CGRect(x: marginSpaceForHorizontal, y: bannerView.frame.maxY + 15, width: width, height: 22))
        return newsView
    }()
    
    lazy var toolsView: FinderToolsView = {
        let width = view.bounds.width - 2 * marginSpaceForHorizontal
        let toolsView = FinderToolsView(frame: CGRect(x: marginSpaceForHorizontal, y: newsView.frame.maxY + 20, width: width, height: 70))
        return toolsView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 1
        stackView.backgroundColor = UIColor.init(light: UIColor(hexString: "#2A4E84", alpha: 0.1), dark: UIColor(hexString: "#2D2D2D", alpha: 0.5))
        // 只切上面的圆角
        let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1000), byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 16, height: 16))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = stackView.bounds
        maskLayer.path = maskPath.cgPath
        stackView.layer.mask = maskLayer
        // 设置阴影
        stackView.layer.shadowOpacity = 0.33
        stackView.layer.shadowColor = UIColor.hex("#AEB6D3").cgColor
        stackView.layer.shadowOffset = CGSize(width: 0, height: -5)
        return stackView
    }()
}

extension RYFinderViewController {
    
    var marginSpaceForHorizontal: CGFloat { 16 }
    
    func setupUI() {
        contentScrollView.addSubview(headerView)
        contentScrollView.addSubview(bannerView)
        contentScrollView.addSubview(newsView)
        contentScrollView.addSubview(toolsView)
        contentScrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalToConstant: SCREEN_WIDTH),
            stackView.topAnchor.constraint(equalTo: toolsView.bottomAnchor, constant: 20)
        ])
    }
    
    func setupToDo() {
        ToDoMainPageVC.view.snp.makeConstraints { make in
            make.height.equalTo(152)
        }
        stackView.addArrangedSubview(ToDoMainPageVC.view)
    }

    func setupElectric() {
        electricVC.view.snp.makeConstraints { make in
            make.height.equalTo(152)
        }
        stackView.addArrangedSubview(electricVC.view)
    }

    func setupSA() {
        sportsVC.view.snp.makeConstraints { make in
            make.height.equalTo(152)
        }
        stackView.addArrangedSubview(sportsVC.view)
    }
    
    func reloadData() {
        headerView.reloadData()
        bannerView.request()
    }
}

extension RYFinderViewController: ToDoFinderVCDelegate {
    func updateContentHeight(height: Double) {
        UIView.animate(withDuration: 0.3) {
            self.ToDoMainPageVC.view.snp.updateConstraints({ make in
                make.height.equalTo(height)
            })
            self.view.layoutIfNeeded() // 强制更新布局
            var contentHeight = self.stackView.frame.maxY
            contentHeight += 107 + Constants.safeDistanceBottom
            self.contentScrollView.contentSize = CGSize(width: self.contentScrollView.frame.width, height: max(contentHeight, self.view.height))
        }
    }
}
