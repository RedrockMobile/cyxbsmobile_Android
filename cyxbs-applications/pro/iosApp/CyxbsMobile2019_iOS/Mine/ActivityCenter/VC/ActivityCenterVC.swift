//
//  ActivityCenterVC.swift
//  CyxbsMobile2019_iOS
//
//  Created by 许晋嘉 on 2023/9/16.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit
import JXSegmentedView

class ActivityCenterVC: UIViewController {
    
    var participatedActivities: [Activity] = []
    var publishedActivities: [Activity] = []
    var reviewingActivities: [Activity] = []
    var wantToWatchActivities: [Activity] = []
    var tableViewControllers: [ActivityCenterTableViewVC] = []
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
        segmentedDataSource.titles = ["我想看","已参与","已发布","待审核"]
        segmentedDataSource.titleNormalFont = UIFont(name: PingFangSCMedium, size: 18)!
        segmentedDataSource.titleNormalColor = UIColor(red: 0.078, green: 0.173, blue: 0.322, alpha: 0.4)
        segmentedDataSource.titleSelectedColor = UIColor(red: 0.067, green: 0.173, blue: 0.329, alpha: 1)
        segmentedDataSource.isTitleColorGradientEnabled = true
        segmentedView.delegate = self
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
        
        requestActivity()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (tableViewControllers[0].activities.count == 0) {
            ActivityHUD.shared.showNoMoreData()
        }
    }
    
    func requestActivity() {
        HttpManager.shared.magipoke_ufield_activity_list_me().ry_JSON { response in
            switch response {
            case .success(let jsonData):
                let mineActivityResponseData = MineActivityResponse(from: jsonData)
                self.wantToWatchActivities = mineActivityResponseData.data.wantToWatch
                self.wantToWatchActivities = mineActivityResponseData.data.wantToWatch
                self.tableViewControllers[0].activities = self.wantToWatchActivities
                self.participatedActivities = mineActivityResponseData.data.participated
                self.tableViewControllers[1].activities = self.participatedActivities
                self.publishedActivities = mineActivityResponseData.data.published
                self.tableViewControllers[2].activities = self.publishedActivities
                self.reviewingActivities = mineActivityResponseData.data.reviewing
                self.tableViewControllers[3].activities = self.reviewingActivities
                //所有子vc的tableView重新载入数据
                for ActivityCenterTableViewVC in self.tableViewControllers {
                    ActivityCenterTableViewVC.tableView.reloadData()
                }
                break
            case .failure(let error):
                print(error)
                ActivityHUD.shared.showNetworkError()
                break
            }
        }
    }
    
    // MARK: - 懒加载
    //顶部视图
    lazy var topView: ActivityCenterTopView = {
        let topView = ActivityCenterTopView(frame: CGRectMake(0, 0, view.bounds.width, 92 + Constants.statusBarHeight))
        topView.backButton.addTarget(self, action: #selector(popController), for: .touchUpInside)
        topView.titleLab.text = "活动中心"
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
        let wantToWatchVC = ActivityCenterTableViewVC()
        wantToWatchVC.title = "我想看"
        addChild(wantToWatchVC)
        tableViewControllers.append(wantToWatchVC)
        
        let participatedVC = ActivityCenterTableViewVC()
        participatedVC.title = "已参与"
        addChild(participatedVC)
        tableViewControllers.append(participatedVC)
        
        let publishedVC = ActivityCenterTableViewVC()
        publishedVC.title = "已发布"
        addChild(publishedVC)
        tableViewControllers.append(publishedVC)
        
        let reviewingVC = ActivityCenterTableViewVC()
        reviewingVC.title = "待审核"
        addChild(reviewingVC)
        tableViewControllers.append(reviewingVC)
    }
    
    @objc func popController() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ActivityCenterVC: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        return 4
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        return tableViewControllers[index]
    }
}

extension ActivityCenterVC: JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        if (tableViewControllers[index].activities.count == 0) {
            ActivityHUD.shared.showNoMoreData()
        }
    }
}



