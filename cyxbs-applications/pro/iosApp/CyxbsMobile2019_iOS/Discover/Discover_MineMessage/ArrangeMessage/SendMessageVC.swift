//
//  SendMessageVC.swift
//  CyxbsMobile2019_iOS
//
//  Created by coin on 2023/10/8.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit
import JXSegmentedView

class SendMessageVC: UIViewController {
    
    private var messageAry: [ArrangeMessageItem] = []
    /// 点击的按钮对应的消息id
    private var selectedMessageID: Int = 0
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        getSentMessage()
        
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
    
    private func getSentMessage() {
        
        ArrangeMessageModel.getSentMessage { groupModel in
            self.messageAry = groupModel.messageAry
            self.tableView.reloadData()
        } failure: { error in
            print(error)
        }
    }
    
    @objc private func clickCancelReminderBtn(_ sender: UIButton) {
        selectedMessageID = sender.tag
        let vc = CancelReminderAlertVC()
        vc.modalPresentationStyle = .overFullScreen
        vc.delegate = self
        view.window?.rootViewController?.present(vc, animated: false, completion: nil)
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

extension SendMessageVC: JXSegmentedListContainerViewListDelegate {
    
    func listView() -> UIView {
        return view
    }
}

// MARK: - UITableViewDataSource

extension SendMessageVC: UITableViewDataSource {

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
        let titleTextColor: UIColor
        let statusImageName: String
        let buttonImageName: String
        let contentTextColor: UIColor
        let timeTextColor: UIColor
        
        // 若行程未取消
        if !message.hasCancel {
            titleTextColor = UIColor(hexString: "#15315B", alpha: 1)
            contentTextColor = UIColor(hexString: "#2D4D80", alpha: 1)
            timeTextColor = UIColor(hexString: "#ABB5C4", alpha: 1)
            buttonImageName = "取消提醒日程"
            // 若行程已结束
            if message.hasEnd {
                statusImageName = "已结束"
                cell.button.isUserInteractionEnabled = false
            // 若行程未开始
            } else {
                statusImageName = "未开始"
                cell.button.isUserInteractionEnabled = true
                cell.button.addTarget(self, action: #selector(clickCancelReminderBtn(_:)), for: .touchUpInside)
                cell.button.tag = message.messageID
            }
        // 若行程已取消
        } else {
            statusImageName = message.hasStart ? "已结束" : "未开始_灰色"
            titleTextColor = UIColor(hexString: "#8F9CAF", alpha: 1)
            contentTextColor = UIColor(hexString: "#ABB5C4", alpha: 1)
            timeTextColor = UIColor(hexString: "#ABB5C4", alpha: 0.7)
            buttonImageName = "已取消日程"
            cell.button.isUserInteractionEnabled = false
        }
        
        cell.titleLab.text = "活动通知"
        cell.titleLab.textColor = titleTextColor
        cell.statusImgView.image = UIImage(named: statusImageName)
        cell.contentLab.textColor = contentTextColor
        cell.timeLab.textColor = timeTextColor
        cell.button.setImage(UIImage(named: buttonImageName), for: .normal)
        cell.contentLab.text = message.content
        
        let date = Date(timeIntervalSince1970: TimeInterval(messageAry[sequence].publishTime))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd HH:mm"
        cell.timeLab.text = dateFormatter.string(from: date)
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SendMessageVC: UITableViewDelegate {

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

extension SendMessageVC: CancelReminderAlertVCDelegate {
    func confirmCancel() {
        let parameters = ["id": selectedMessageID]
        HttpTool.share().request(Discover_PUT_cancalArrange_API,
                                 type: .put,
                                 serializer: .HTTP,
                                 bodyParameters: parameters,
                                 progress: nil,
                                 success: { task, object in
            self.getSentMessage()
        },
                                 failure: { task, error in
            print(error)
        })
    }
}
