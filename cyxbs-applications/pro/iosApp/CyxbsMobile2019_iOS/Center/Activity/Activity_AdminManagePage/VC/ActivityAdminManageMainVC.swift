//
//  ActivityAdminManageVC.swift
//  CyxbsMobile2019_iOS
//
//  Created by 许晋嘉 on 2023/9/20.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit
import JXSegmentedView

class ActivityAdminManageMainVC: UIViewController {
    
    var reviewingVC: ActivityAdminReviewingVC!
    var reviewedVC: ActivityAdminReviewedVC!
    var segmentedDataSource: JXSegmentedTitleDataSource!
    var segmentedView: JXSegmentedView!
    var listContainerView: JXSegmentedListContainerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.973, green: 0.976, blue: 0.988, alpha: 1)
        addVCs()
        addTopView()
        //初始化segmentedView
        segmentedView = JXSegmentedView()
        segmentedDataSource = JXSegmentedTitleDataSource()
        segmentedDataSource.titles = ["待处理","已处理"]
        segmentedDataSource.titleNormalFont = UIFont(name: PingFangSCMedium, size: 18)!
        segmentedDataSource.titleNormalColor = UIColor(red: 0.078, green: 0.173, blue: 0.322, alpha: 0.4)
        segmentedDataSource.titleSelectedColor = UIColor(red: 0.067, green: 0.173, blue: 0.329, alpha: 1)
        segmentedDataSource.isTitleColorGradientEnabled = true
        segmentedView.dataSource = segmentedDataSource
        //配置指示器
        let indicator = JXSegmentedIndicatorImageView()
        indicator.indicatorWidth = 66
        indicator.verticalOffset = -5
        indicator.image = UIImage(named: "选中效果2")
        indicator.indicatorColor = .blue
        segmentedView.indicators = [indicator]
        view.addSubview(segmentedView)
        listContainerView = JXSegmentedListContainerView(dataSource: self)
        view.addSubview(listContainerView)
        segmentedView.listContainer = listContainerView
        //布局子控件
        segmentedView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(46 + Constants.statusBarHeight)
        }
        listContainerView.snp.makeConstraints { (make) in
            //可以滑动的容器,在tab的下面,宽度屏幕宽,底部在安全区的最下边
            make.top.equalTo(segmentedView.snp.bottom).offset(10)
            make.width.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    // MARK: - 懒加载
    //顶部视图
    lazy var topView: ActivityCenterTopView = {
        let topView = ActivityCenterTopView(frame: CGRectMake(0, 0, view.bounds.width, 92 + Constants.statusBarHeight))
        topView.backButton.addTarget(self, action: #selector(popController), for: .touchUpInside)
        topView.titleLab.text = "审核中心"
        return topView
    }()
    
    func addTopView() {
        // 添加顶部视图
        view.addSubview(topView)
        
        // 创建圆角路径，将左下角和右下角设置为圆角
        let cornerRadius: CGFloat = 20
        let shadowPath = UIBezierPath(roundedRect: topView.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        // 创建阴影图层
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = shadowPath.cgPath
        shadowLayer.fillColor = UIColor.white.cgColor

        // 设置阴影属性
        shadowLayer.shadowColor = UIColor(red: 0.176, green: 0.325, blue: 0.553, alpha: 0.03).cgColor
        shadowLayer.shadowOpacity = 0.1
        shadowLayer.shadowOffset = CGSize(width: 0, height: 2)
        shadowLayer.shadowRadius = 4

        // 将阴影图层插入到顶部视图的图层中，使阴影位于底部
        topView.layer.insertSublayer(shadowLayer, at: 0)
    }
    
    func addVCs() {
        reviewingVC = ActivityAdminReviewingVC()
        reviewingVC.title = "待处理"
        addChild(reviewingVC)
        reviewedVC = ActivityAdminReviewedVC()
        reviewedVC.title = "已处理"
        addChild(reviewedVC)
    }
    
    @objc func popController() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ActivityAdminManageMainVC: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        return 2
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        switch index {
        case 0: return reviewingVC
        case 1: return reviewedVC
        default: return reviewingVC
        }
    }
}
