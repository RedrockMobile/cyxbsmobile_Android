//
//  ReceiveMessageVC.swift
//  CyxbsMobile2019_iOS
//
//  Created by coin on 2023/10/8.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit
import JXSegmentedView

class ReceiveMessageVC: UIViewController {
    
    private var messageAry: [ArrangeMessageItem] = []
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        getReceivedMessage()
        
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(0)
            make.right.equalTo(view).inset(16)
            make.bottom.equalTo(view)
        }
    }
    
    // MARK: - Method
    
    private func getReceivedMessage() {
        ArrangeMessageModel.getReceivedMessage { groupModel in
            self.messageAry = groupModel.messageAry
            self.tableView.reloadData()
            // 更改所有信息为已读
            for message in groupModel.messageAry {
                let parameters = ["status": true, "id": message.messageID] as [String : Any]
                HttpTool.share().request(Discover_PUT_changeRead_API,
                                         type: .put,
                                         serializer: .HTTP,
                                         bodyParameters: parameters,
                                         progress: nil,
                                         success: { task, object in
                },
                                         failure: { task, error in
                    print(error)
                })
            }
            
        } failure: { error in
            print(error)
        }
    }
    
    @objc private func clickAddArrangeBtn(_ sender: UIButton) {
        let parameters = ["id": sender.tag]
        HttpTool.share().request(Discover_PUT_addArrange_API,
                                 type: .put,
                                 serializer: .HTTP,
                                 bodyParameters: parameters,
                                 progress: nil,
                                 success: { task, object in
            sender.setImage(UIImage(named: "已添加日程"), for: .normal)
            sender.isUserInteractionEnabled = false
        },
                                 failure: { task, error in
            print(error)
        })
        
        ArrangeMessageModel.getReceivedMessage { groupModel in
            for message in groupModel.messageAry {
                if message.messageID == sender.tag {
                    HttpManager.shared.magipoke_reminder_Person_addTransaction(begin_lesson: message.dateDic["beginLesson"]!, period: message.dateDic["period"]! + 1, day: message.dateDic["day"]! - 1, week: [message.dateDic["week"]!], title: message.title, content: message.content).ry_JSON { response in
                    }
                }
            }
        } failure: { error in
            print(error)
        }
    }
    
    // MARK: - Lazy
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .none
        tableView.register(ArrangeMessageTableViewCell.self, forCellReuseIdentifier: ArrangeMessageTableViewCellReuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
}

// MARK: - JXSegmentedListContainerViewListDelegate

extension ReceiveMessageVC: JXSegmentedListContainerViewListDelegate {
    
    func listView() -> UIView {
        return view
    }
}

// MARK: - UITableViewDataSource

extension ReceiveMessageVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return messageAry.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArrangeMessageTableViewCellReuseIdentifier, for: indexPath) as! ArrangeMessageTableViewCell
        
        let sequence = messageAry.count - indexPath.section - 1
        let message = messageAry[sequence]
        let titleText: String
        let titleTextColor: UIColor
        let statusImageName: String
        let buttonImageName: String
        let contentTextColor: UIColor
        let timeTextColor: UIColor
        
        let date = Date(timeIntervalSince1970: TimeInterval(messageAry[sequence].publishTime))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd HH:mm"
        cell.timeLab.text = dateFormatter.string(from: date)
        
        // 若行程未取消
        if !message.hasCancel {
            titleText = "活动通知"
            titleTextColor = UIColor(hexString: "#15315B", alpha: 1)
            contentTextColor = UIColor(hexString: "#2D4D80", alpha: 1)
            timeTextColor = UIColor(hexString: "#ABB5C4", alpha: 1)
            // 若行程已结束
            if message.hasEnd {
                statusImageName = "已结束"
                buttonImageName = message.hasAdd ? "已添加日程_灰色" : "添加日程_灰色"
                cell.button.isUserInteractionEnabled = false
            // 若行程未开始
            } else {
                statusImageName = "未开始"
                buttonImageName = message.hasAdd ? "已添加日程" : "添加日程"
                cell.button.isUserInteractionEnabled = message.hasAdd ? false : true
                cell.button.addTarget(self, action: #selector(clickAddArrangeBtn), for: .touchUpInside)
                cell.button.tag = message.messageID
                
            }
        // 若行程已取消
        } else {
            statusImageName = message.hasStart ? "已结束" : "未开始_灰色"
            cell.button.isUserInteractionEnabled = false
            // 若此行程已取消
            if !message.content.contains("已取消") {
                titleText = "活动通知"
                titleTextColor = UIColor(hexString: "#8F9CAF", alpha: 1)
                contentTextColor = UIColor(hexString: "#ABB5C4", alpha: 1)
                timeTextColor = UIColor(hexString: "#ABB5C4", alpha: 0.7)
                buttonImageName = message.hasAdd ? "已添加日程_灰色" : "添加日程_灰色"
            // 若为通知行程取消的消息
            } else {
                titleText = "取消通知"
                titleTextColor = UIColor(hexString: "#15315B", alpha: 1)
                contentTextColor = UIColor(hexString: "#2D4D80", alpha: 1)
                timeTextColor = UIColor(hexString: "#ABB5C4", alpha: 1)
                buttonImageName = "已取消日程"
                
                let time = Date(timeIntervalSince1970: TimeInterval(messageAry[sequence].updateTime))
                cell.timeLab.text = dateFormatter.string(from: time)
            }
        }
        
        cell.titleLab.text = titleText
        cell.titleLab.textColor = titleTextColor
        cell.statusImgView.image = UIImage(named: statusImageName)
        cell.contentLab.textColor = contentTextColor
        cell.timeLab.textColor = timeTextColor
        cell.button.setImage(UIImage(named: buttonImageName), for: .normal)
        cell.contentLab.text = message.content
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ReceiveMessageVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 151
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 12
        } else {
            return 0.001
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == (messageAry.count - 1) ? 50 : 8
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        // 如果为最后一个section
        if section == messageAry.count - 1 {
            let label = UILabel(frame: CGRect(x: (tableView.width - 135) / 2, y: 12, width: 135, height: 17))
            label.font = .systemFont(ofSize: 12)
            label.text = "两周之后消息将自动清空"
            label.textColor = UIColor(hexString: "#ABB5C4", alpha: 1)
            footerView.addSubview(label)
        }
        return footerView
    }
}
