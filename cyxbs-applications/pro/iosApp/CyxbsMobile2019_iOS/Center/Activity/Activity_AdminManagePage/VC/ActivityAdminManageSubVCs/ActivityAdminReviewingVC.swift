//
//  ActivityAdminReviewingVC.swift
//  CyxbsMobile2019_iOS
//
//  Created by 许晋嘉 on 2023/9/21.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit
import MJRefresh
import JXSegmentedView

class ActivityAdminReviewingVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var activities: [Activity] = []
    private var titleParagraphStyle = NSMutableParagraphStyle()
    private var lower_id: Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestReviewingActivities()
        titleParagraphStyle.lineHeightMultiple = 0.85
        view.addSubview(tableView)
        self.tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        addMJFooter()
    }
    
    //活动展示tableView
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(ActivityReviewingTableViewCell.self, forCellReuseIdentifier: "reviewingCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    // UITableViewDataSource方法
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewingCell", for: indexPath) as! ActivityReviewingTableViewCell
        cell.titleLabel.attributedText = NSMutableAttributedString(string: activities[indexPath.item].activityTitle, attributes: [NSAttributedString.Key.paragraphStyle: titleParagraphStyle])
        cell.startTimeLabel.text = DateConvert.dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(activities[indexPath.item].activityStartAt)))
        switch activities[indexPath.item].activityType {
        case "culture": cell.typeView.contentLabel.text = "文娱活动"
        case "sports": cell.typeView.contentLabel.text = "体育活动"
        case "education": cell.typeView.contentLabel.text = "教育活动"
        default: break
        }
        cell.creatorView.contentLabel.text = activities[indexPath.item].activityCreator
        cell.phoneView.contentLabel.text = activities[indexPath.item].phone
        cell.activityId = activities[indexPath.item].activityId
        cell.agreeButton.addTarget(self, action: #selector(requestReviewingActivities), for: .touchUpInside)
        cell.agreeButtonTappedHandler = { [weak self] activityId in
            self?.agreeButtonTapped(activityId: activityId)
        }
        cell.rejectButtonTappedHandler = { [weak self] activityId in
            self?.rejectButtonTapped(activityId: activityId)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 202
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    // UITableViewDelegate方法
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("点击了cell")
        let detailVC = ActivityDetailVC()
        detailVC.activity = activities[indexPath.row]
        detailVC.numOfIndexPath = indexPath.row
        self.navigationController?.pushViewController(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    struct DateConvert {
        static let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "zh_CN")
            formatter.dateFormat = "yyyy.MM.dd"
            return formatter
        }()
    }
    
    @objc func requestReviewingActivities() {
        HttpManager.shared.magipoke_ufield_activity_tobe_examine(lower_id: lower_id).ry_JSON { response in
            self.tableView.mj_footer?.endRefreshing()
            switch response {
//            case.success(let jsonData):
//                let reviewingActivityResponseData = SearchActivityResponse(from: jsonData)
//                self.activities += reviewingActivityResponseData.data
//                self.tableView.reloadData()
//                if(self.activities.count > 0){
//                    self.lower_id = self.activities[self.activities.count-1].activityId
//                }
//                if reviewingActivityResponseData.data.count == 0 {
//                    ActivityHUD.shared.showNoMoreData()
//                }
//                break
            case.success(let jsonData):
                let reviewingActivityResponseData = SearchActivityResponse(from: jsonData)
                self.activities += reviewingActivityResponseData.data
                if(self.activities.count == reviewingActivityResponseData.data.count && self.activities.count != 0) {
                    self.lower_id = self.activities[self.activities.count-1].activityId
                    self.tableView.reloadData()
                } else if (reviewingActivityResponseData.data.count == 0) {
                    if(self.activities.count == 0) {
                        self.tableView.mj_footer?.endRefreshingWithNoMoreData()
                        ActivityHUD.shared.showNoMoreData()
                    } else {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            self.tableView.mj_footer?.endRefreshingWithNoMoreData()
                            ActivityHUD.shared.showNoMoreData()
                        }
                    }
                } else {
                    self.lower_id = self.activities[self.activities.count-1].activityId
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.tableView.mj_footer?.endRefreshing()
                        self.tableView.reloadData()
                    }
                }
                break
            case.failure(let error):
                print(error)
                ActivityHUD.shared.showNetworkError()
                break
            }
        }
    }
    
    func agreeButtonTapped(activityId: Int) {
        var hudText: String = ""
        //审核活动“同意”网络请求
        HttpManager.shared.magipoke_ufield_activity_examine(activity_id: activityId, decision: "pass").ry_JSON { response in
            switch response {
            case .success(let jsonData):
                let examineResponseData = StandardResponse(from: jsonData)
                if (examineResponseData.status == 10000) {
                    hudText = "审核成功"
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
                }
                break
            case .failure(let error):
                print(error)
                ActivityHUD.shared.showNetworkError()
                break
            }
        }
    }
    
    func rejectButtonTapped(activityId: Int) {
        let vc = ActivityAdminRejectVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        vc.activityId = activityId
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
    func addMJFooter() {
        let footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(requestReviewingActivities))
        footer.setTitle("", for: .idle)
        footer.setTitle("正在加载...", for: .refreshing)
        footer.setTitle("已经加载到最底部", for: .noMoreData)
        footer.stateLabel?.textColor = UIColor(red: 0.082, green: 0.192, blue: 0.357, alpha: 0.3)
        tableView.mj_footer = footer
    }
}
// MARK: - JXSegmentedListContainerViewListDelegate，返回containerView展示的视图
extension ActivityAdminReviewingVC: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
