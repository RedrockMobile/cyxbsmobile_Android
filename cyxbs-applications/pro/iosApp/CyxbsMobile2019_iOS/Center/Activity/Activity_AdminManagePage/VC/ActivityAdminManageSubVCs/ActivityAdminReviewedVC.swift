//
//  ActivityAdminReviewedVC.swift
//  CyxbsMobile2019_iOS
//
//  Created by 许晋嘉 on 2023/9/23.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit
import JXSegmentedView
import MJRefresh

class ActivityAdminReviewedVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var activities: [Activity] = []
    private var titleParagraphStyle = NSMutableParagraphStyle()
    private var upper_id : Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestReviewedActivities()
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
        tableView.register(ActivityReviewedTableViewCell.self, forCellReuseIdentifier: "reviewedCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    // UITableViewDataSource方法
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewedCell", for: indexPath) as! ActivityReviewedTableViewCell
        cell.titleLabel.attributedText = NSMutableAttributedString(string: activities[indexPath.item].activityTitle, attributes: [NSAttributedString.Key.paragraphStyle: titleParagraphStyle])
        cell.startTimeLabel.text = DateConvert.dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(activities[indexPath.item].activityStartAt)))
        cell.creatorView.contentLabel.text = activities[indexPath.item].activityCreator
        cell.phoneView.contentLabel.text = activities[indexPath.item].phone
        switch activities[indexPath.item].state {
        case "published":
            cell.statusView.image = UIImage(named: "accepted")
            break
        case "rejected":
            cell.statusView.image = UIImage(named: "rejected")
            break
        default: break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 131
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    // UITableViewDelegate方法
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("点击了cell")
        let detailVC = ActivityDetailVC()
        detailVC.activity = activities[indexPath.row]
        detailVC.wantToWatchButton.removeFromSuperview()
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
    
    @objc func requestReviewedActivities() {
        HttpManager.shared.magipoke_ufield_activity_list_examined(upper_id: upper_id).ry_JSON { response in
            switch response {
            case.success(let jsonData):
                let reviewedActivitiesResponse = SearchActivityResponse(from: jsonData)
                self.activities += reviewedActivitiesResponse.data
                if(self.activities.count == reviewedActivitiesResponse.data.count && self.activities.count != 0) {
                    self.upper_id = self.activities[self.activities.count-1].activityId
                    self.tableView.reloadData()
                } else if (reviewedActivitiesResponse.data.count == 0) {
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
                    self.upper_id = self.activities[self.activities.count-1].activityId
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
    
    func addMJFooter() {
        let footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(requestReviewedActivities))
        footer.setTitle("", for: .idle)
        footer.setTitle("正在加载...", for: .refreshing)
        footer.setTitle("已经加载到最底部", for: .noMoreData)
        footer.stateLabel?.textColor = UIColor(red: 0.082, green: 0.192, blue: 0.357, alpha: 0.3)
        tableView.mj_footer = footer
    }
}
// MARK: - JXSegmentedListContainerViewListDelegate，返回containerView展示的视图
extension ActivityAdminReviewedVC: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
