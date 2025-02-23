//
//  ToDoFinderVC.swift
//  CyxbsMobile2019_iOS
//
//  Created by Max Xu on 2024/9/2.
//  Copyright © 2024 Redrock. All rights reserved.
//

import UIKit
import SnapKit

protocol ToDoFinderVCDelegate: AnyObject {
    func updateContentHeight(height: Double)
}

class ToDoFinderVC: UIViewController {
    
    weak var delegate: ToDoFinderVCDelegate?
    /// 全部待办数据
    private var entireToDoAry: [TodoDataModel] = []
    
    // MARK: - Lazy
    private lazy var titleLab: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .ry(light: "#15315B", dark: "#F0F0F2")
        label.text = "邮子清单"
        label.frame = CGRectMake(14, 23, 74, 25)
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = 0
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ToDoTopExpiredStyleCellForFinder.self, forCellReuseIdentifier: ToDoTopExpiredStyleCellForFinderReuseIdentifier)
        tableView.register(ToDoTopActiveStyleCellForFinder.self, forCellReuseIdentifier: ToDoTopActiveStyleCellForFinderReuseIdentifier)
        tableView.register(ToDoTopNoDeadlineStyleCellForFinder.self, forCellReuseIdentifier: ToDoTopNoDeadlineStyleCellForFinderReuseIdentifier)
        tableView.register(ToDoNonTopExpiredStyleCellForFinder.self, forCellReuseIdentifier: ToDoNonTopExpiredStyleCellForFinderReuseIdentifier)
        tableView.register(ToDoNonTopActiveStyleCellForFinder.self, forCellReuseIdentifier: ToDoNonTopActiveStyleCellForFinderReuseIdentifier)
        tableView.register(ToDoNonTopNoDeadlineStyleCellForFinder.self, forCellReuseIdentifier: ToDoNonTopNoDeadlineStyleCellForFinderReuseIdentifier)
        tableView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 152)
        return tableView
    }()
    
    private lazy var emptyView: UIView = {
        let label = UILabel(frame: CGRect(x: 70, y: 84, width: 226, height: 25))
        label.text = "还没有待做事项哦~快去添加吧"
        label.textColor = UIColor(light: UIColor(hexString: "#15315B", alpha: 0.6), dark: UIColor(hexString: "#F0F0F2", alpha: 0.38))
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.ry(light: "#F8F9FC", dark: "#1D1D1D")
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(pushToDoVC))
        tapGes.delegate = self
        view.addGestureRecognizer(tapGes)
        view.addSubview(titleLab)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            make.top.equalTo(view.snp.top).offset(57)
            make.bottom.equalTo(view.snp.bottom).offset(-15)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getToDoData()
    }
    
    @objc private func pushToDoVC() {
        let vc = ToDoVC()
        vc.hidesBottomBarWhenPushed = true
        latestViewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    // 获取每种todo待办,置顶的待办在上
    private func getToDoData() {
        entireToDoAry.removeAll()
        var entireNotPinnedAry: [TodoDataModel] = []
        let tool = TodoSyncTool.share()
        for model in tool.getTodoForMainPage() {
            if model.isPinned {
                entireToDoAry.append(model)
            } else{
                entireNotPinnedAry.append(model)
            }
        }
        entireToDoAry.append(contentsOf: entireNotPinnedAry)
        // 只显示前三个
        entireToDoAry = Array(entireToDoAry.prefix(3))
        tableView.reloadData()
        relayoutTableView()
    }
    
    func relayoutTableView() {
        tableView.size.height = tableView.contentSize.height
        delegate?.updateContentHeight(height: max(tableView.contentSize.height + 86.0, 152))
        if entireToDoAry.isEmpty {
            view.addSubview(emptyView)
        } else {
            emptyView.removeFromSuperview()
        }
    }
    
    // 配置左滑的删除按钮
    private func configDeleteButton(_ button: UIButton, model: TodoDataModel) {
        button.backgroundColor = UIColor(.dm, light: UIColor(hexString: "#FF6262", alpha: 1), dark: UIColor(hexString: "#FF6262", alpha: 1))
        
        let cellBtn = UIButton()
        cellBtn.frame = button.frame
        cellBtn.setImage(UIImage(named: "todo删除"), for: .normal)
        cellBtn.setTitle("删除", for: .normal)
        cellBtn.titleLabel?.font = .systemFont(ofSize: 14)
        cellBtn.setTitleColor(UIColor(.dm, light: UIColor(hexString: "#FFFFFF", alpha: 1), dark: UIColor(hexString: "#FFFFFF", alpha: 1)), for: .normal)
        if model.timeStr.isEmpty && model.overdueTimeStr.isEmpty {
            horizontalImgAndTextOnDeleteBtn(cellBtn)
        } else {
            centerImgAndTextOnBtn(cellBtn)
        }
        button.addSubview(cellBtn)
    }
    
    // 配置左滑的置顶按钮
    private func configStickyButton(_ button: UIButton, model: TodoDataModel) {
        button.backgroundColor = UIColor(.dm, light: UIColor(hexString: "#5263FF", alpha: 1), dark: UIColor(hexString: "#5852FF", alpha: 1))
        
        for subview in button.subviews {
            if subview.isKind(of: UILabel.classForCoder())
                || subview.isKind(of: UIImageView.classForCoder()) {
                subview.alpha = 0
            }
        }
        
        let cellBtn = UIButton()
        cellBtn.frame = button.frame
        cellBtn.setImage(UIImage(named: model.isPinned ? "cancelSticky" : "置顶"), for: .normal)
        cellBtn.setTitle(model.isPinned ? "取消置顶" : "置顶", for: .normal)
        cellBtn.titleLabel?.font = .systemFont(ofSize: model.isPinned ? 12 : 14)
        cellBtn.setTitleColor(UIColor(.dm, light: UIColor(hexString: "#FFFFFF", alpha: 1), dark: UIColor(hexString: "#FFFFFF", alpha: 1)), for: .normal)
        if model.timeStr.isEmpty && model.overdueTimeStr.isEmpty {
            horizontalImgAndTextOnStickyBtn(cellBtn)
        } else {
            centerImgAndTextOnBtn(cellBtn)
        }
        button.addSubview(cellBtn)
    }
    
    // 按钮图片文字上下居中
    private func centerImgAndTextOnBtn(_ button: UIButton) {
        let imgSize = button.imageView?.size ?? CGSize.zero
        let titleSize = button.titleLabel?.size ?? CGSize.zero
        button.titleEdgeInsets = UIEdgeInsets(top: imgSize.height / 2, left: -(imgSize.width / 2), bottom: -(imgSize.height / 2), right: imgSize.width / 2)
        button.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height / 2 + 3), left: titleSize.width / 2, bottom: titleSize.height / 2 + 3, right: -(titleSize.width / 2))
    }
    
    // 删除按钮图片文字左右分布
    private func horizontalImgAndTextOnDeleteBtn(_ button: UIButton) {
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: -3)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -3, bottom: 0, right: 3)
    }
    
    // 置顶按钮图片文字左右分布
    private func horizontalImgAndTextOnStickyBtn(_ button: UIButton) {
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -3, bottom: 0, right: 3)
    }
    
    // 删除tableview对应的model
    private func deleteTableViewModel(_ model: TodoDataModel) {
        if let index = self.entireToDoAry.firstIndex(of: model) {
            self.entireToDoAry.remove(at: index)
            self.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        }
    }
}

// MARK: - UITableViewDataSource

extension ToDoFinderVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entireToDoAry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = entireToDoAry[indexPath.row]
        
        let isTop = data.isPinned ? true : false
        let haveTime: Bool
        var expired = false
        
        if data.overdueTimeStr != "" || data.timeStr != "" {
            haveTime = true
            if data.overdueTime < Int(Date().timeIntervalSince1970) {
                expired = true
            } else {
                expired = false
            }
        } else {
            haveTime = false
        }
        
        let cell: ToDoTableViewCellForFinder
        let identifier: String
        
        if isTop, haveTime, expired {
            identifier = ToDoTopActiveStyleCellForFinderReuseIdentifier
        } else if isTop, haveTime, !expired {
            identifier = ToDoTopActiveStyleCellForFinderReuseIdentifier
        } else if isTop, !haveTime {
            identifier = ToDoTopNoDeadlineStyleCellForFinderReuseIdentifier
        } else if !isTop, haveTime, expired {
            identifier = ToDoNonTopExpiredStyleCellForFinderReuseIdentifier
        } else if !isTop, haveTime, !expired {
            identifier = ToDoNonTopActiveStyleCellForFinderReuseIdentifier
        } else {
            identifier = ToDoNonTopNoDeadlineStyleCellForFinderReuseIdentifier
        }
        
        cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ToDoTableViewCellForFinder
        cell.selectionStyle = .none
        cell.button.tag = indexPath.row
        cell.contentLab.text = data.titleStr
        cell.timeLab.text = data.overdueTimeStr.isEmpty ? data.timeStr : data.overdueTimeStr
//        cell.delegate = self
        if expired {
            cell.button.setBackgroundImage(UIImage(named: "ToDo过期圆圈"), for: .normal)
        } else {
            cell.button.setBackgroundImage(UIImage(named: "未完成圆圈"), for: .normal)
        }
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ToDoFinderVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let data = entireToDoAry[indexPath.row]
        return (data.timeStr.isEmpty && data.overdueTimeStr.isEmpty) ? 39 : 58
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ToDoDetailVC(model: entireToDoAry[indexPath.row])
        vc.hidesBottomBarWhenPushed = true
        latestViewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let model = self.entireToDoAry[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: " ") { action, sourceView, completionHandler in
            let alertVC = ToDoAlertController { [weak self] in
                guard let self = self else { return }
                self.deleteTableViewModel(self.entireToDoAry[indexPath.row])
                TodoSyncTool.share().deleteTodo(withTodoID: model.todoIDStr, needRecord: true)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.getToDoData()
                    self.relayoutTableView()
                    completionHandler(true)
                }
            } cancelAction: {
                completionHandler(false)
            }
            self.present(alertVC, animated: true)
        }
        deleteAction.backgroundColor = UIColor(.dm, light: UIColor(hexString: "#FF6262", alpha: 1), dark: UIColor(hexString: "#FF6262", alpha: 1))

        let stickyAction = UIContextualAction(style: .destructive, title: model.isPinned ? "aaaaaaaaa" : "  ") { action, sourceView, completionHandler in
            model.isPinned.toggle()
            model.lastModifyTime = Int(Date().timeIntervalSince1970)
            model.resetOverdueTime(NSDate.nowTimestamp())
            TodoSyncTool.share().alterTodo(with: model, needRecord: true)
            self.getToDoData()
            tableView.reloadData()
        }
        stickyAction.backgroundColor = UIColor(.dm, light: UIColor(hexString: "#5263FF", alpha: 1), dark: UIColor(hexString: "#5852FF", alpha: 1))
        
        let action: [UIContextualAction]
        action = [deleteAction, stickyAction]
        let configuration = UISwipeActionsConfiguration(actions: action)
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        let model = entireToDoAry[indexPath.row]
        if #available(iOS 13.0, *) {
            for subView in tableView.subviews {
                if let cellSwipeContainerClass = NSClassFromString("_UITableViewCellSwipeContainerView") {
                    if subView.isKind(of: cellSwipeContainerClass),
                       subView.subviews.count >= 1 {
                        let swipeView = subView.subviews.first
                        swipeView?.backgroundColor = .clear
                        if swipeView?.subviews.count ?? 0 >= 2 {
                            let deleteBtn = swipeView?.subviews[1]
                            let stickyBtn = swipeView?.subviews[0]
                            configDeleteButton(deleteBtn as! UIButton, model: model)
                            configStickyButton(stickyBtn as! UIButton, model: model)
                        }
                    }
                }
            }
            
        } else if #available(iOS 11.0, *) {
            for subView in tableView.subviews {
                if let wrapperClass = NSClassFromString("UITableViewWrapperView") {
                    if subView.isKind(of: wrapperClass) {
                        for actionView in subView.subviews {
                            if let swipeActionPullClass = NSClassFromString("UISwipeActionPullView") {
                                if actionView.isKind(of: swipeActionPullClass) {
                                    actionView.backgroundColor = .clear
                                    if actionView.subviews.count >= 2 {
                                        let deleteBtn = actionView.subviews[1]
                                        let stickyBtn = actionView.subviews[0]
                                        configDeleteButton(deleteBtn as! UIButton, model: model)
                                        configStickyButton(stickyBtn as! UIButton, model: model)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
        } else {
            let tableCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))!
            for subView in tableCell.subviews {
                if let cellDeleteConfirmationClass = NSClassFromString("UITableViewCellDeleteConfirmationView") {
                    if subView.isKind(of: cellDeleteConfirmationClass) {
                        if !model.isPinned,
                           subView.subviews.count >= 2 {
                            let deleteBtn = subView.subviews[1]
                            let stickyBtn = subView.subviews[0]
                            configDeleteButton(deleteBtn as! UIButton, model: model)
                            configStickyButton(stickyBtn as! UIButton, model: model)
                        } else if model.isPinned,
                                  subView.subviews.count >= 1 {
                            let deleteBtn = subView.subviews[0]
                            configDeleteButton(deleteBtn as! UIButton, model: model)
                        }
                    }
                }
            }
        }
    }
}

// MARK: - UIGestureRecognizerDelegate
extension ToDoFinderVC: UIGestureRecognizerDelegate {
    // 处理手势冲突
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let view = touch.view {
            if view.isDescendant(of: tableView) {
               return false
            }
        }
        return true
    }
}
