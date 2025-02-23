//
//  ActivityMessageVC.swift
//  CyxbsMobile2019_iOS
//
//  Created by 许晋嘉 on 2023/11/8.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit
import SnapKit

class ActivityMessageVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @objc var activityMessageModel: ActivityMessageModel!
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(light: UIColor(hexString: "#F8F9FC"), dark: .black)
        view.addSubview(tableView)
        tableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - Constants.statusBarHeight - 94)
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        tableView.backgroundColor = UIColor(light: UIColor(hexString: "#F8F9FC"), dark: .black)
        tableView.register(ActivityMessageCell.self, forCellReuseIdentifier: "messageCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshData()
    }
    
    // UITableViewDataSource方法
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! ActivityMessageCell
        switch activityMessageModel.activityMessages[indexPath.item].messageType {
        case "examine_report_pass":
            cell.statusView.image = UIImage(named: "accepted")
            cell.dateLabel.text = DateConvert.dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(activityMessageModel.activityMessages[indexPath.item].examineTimestamp!)))
            cell.messageTypeLabel.text = "审核通知"
            cell.firstLabel.text = "活动名称： \(activityMessageModel.activityMessages[indexPath.item].activityInfo.activityTitle)"
            cell.secondLabel.removeFromSuperview()
            break
        case "examine_report_reject":
            cell.statusView.image = UIImage(named: "rejected")
            cell.dateLabel.text = DateConvert.dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(activityMessageModel.activityMessages[indexPath.item].examineTimestamp!)))
            cell.messageTypeLabel.text = "审核通知"
            cell.firstLabel.text = "活动名称： \(activityMessageModel.activityMessages[indexPath.item].activityInfo.activityTitle)"
            cell.secondLabel.text = "驳回原因： \(activityMessageModel.activityMessages[indexPath.item].rejectReason!)"
            break
        case "activity_report":
            cell.dateLabel.text = DateConvert.dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(activityMessageModel.activityMessages[indexPath.item].wantToWatchTimestamp!)))
            cell.messageTypeLabel.text = "活动通知"
            cell.firstLabel.text = "活动名称： \(activityMessageModel.activityMessages[indexPath.item].activityInfo.activityTitle)"
            cell.secondLabel.text = "活动地点： \(activityMessageModel.activityMessages[indexPath.item].activityInfo.activityPlace)"
            break
        default: break
        }
        cell.isClicked = activityMessageModel.activityMessages[indexPath.item].clicked
//        if(!activityMessageModel.activityMessages[indexPath.item].clicked) {
//            cell.contentView.addSubview(cell.dot)
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(activityMessageModel.activityMessages[indexPath.item].messageType == "examine_report_pass") {
            return 88
        } else {
            return 112
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityMessageModel.activityMessages.count
    }
    
    // UITableViewDelegate方法
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        HttpManager.shared.magipoke_ufield_action_click(message_id: activityMessageModel.activityMessages[indexPath.item].messageId).ry_JSON { response in
            switch response {
            case .success(let jsonData):
                if(jsonData["status"].intValue == 10000) {
                    print("消息已读成功")
                } else {
                    print("消息已经已读")
                }
                break
            case .failure(let error):
                print("消息已读失败")
                print(error)
                break
            }
        }
        let detailVC = ActivityDetailVC()
        HttpManager.shared.magipoke_ufield_activity(activity_id: activityMessageModel.activityMessages[indexPath.item].activityInfo.activityId).ry_JSON { response in
            switch response {
            case .success(let jsonData):
                let activityResponse = ActivityResponse(from: jsonData)
                if(activityResponse.status == 10000) {
                    detailVC.activity = activityResponse.data
                    detailVC.wantToWatchButton.removeFromSuperview()
                    detailVC.numOfIndexPath = indexPath.row
                    self.navigationController?.pushViewController(detailVC, animated: true)
                    tableView.deselectRow(at: indexPath, animated: true)
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func refreshData() {
        activityMessageModel.requestActivityMessages(lower_id: nil) {
            self.tableView.reloadData()
        } failure: { error in
            print(error as Any)
        }
    }
    
    @objc func readAllMessage() {
        for message in activityMessageModel.activityMessages {
            HttpManager.shared.magipoke_ufield_action_click(message_id: message.messageId).ry_JSON { response in
                switch response {
                case .success(let jsonData):
                    if(jsonData["status"].intValue == 10000) {
                        print("ID:\(message.messageId)消息已读成功")
                    } else {
                        print("ID:\(message.messageId)消息已经已读")
                    }
                    break
                case .failure(let error):
                    print("ID:\(message.messageId)消息已读失败")
                    print(error)
                    break
                }
            }
        }
    }
    
    struct DateConvert {
        static let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "zh_CN")
            formatter.dateFormat = "yyyy.MM.dd"
            return formatter
        }()
    }
}
