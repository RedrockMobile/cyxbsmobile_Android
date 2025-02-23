//
//  ToDoVC.swift
//  CyxbsMobile2019_iOS
//
//  Created by coin on 2024/8/13.
//  Copyright © 2024 Redrock. All rights reserved.
//

import UIKit
import JXSegmentedView

class ToDoVC: UIViewController {
    
    enum CurrentView {
        case entireView
        case studyView
        case lifeView
        case otherView
    }
    
    // MARK: - Properties
    
    /// 全部待办数据
    private var entireToDoAry: [TodoDataModel] = []
    /// 学习待办数据
    private var studyToDoAry: [TodoDataModel] = []
    /// 生活待办数据
    private var lifeToDoAry: [TodoDataModel] = []
    /// 其他待办数据
    private var otherToDoAry: [TodoDataModel] = []
    /// 当前的视图
    var currentView: CurrentView = .entireView
    /// 是否正在批量管理
    private var isBeingManage: Bool = false
    /// 批量管理下对应row的cell是否选中
    private var isRowSelected: [Bool] = []
    /// 批量管理下所有选中的model
    private var selectedModel: [TodoDataModel] = []
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(topView)
        view.addSubview(segmentedView)
        view.addSubview(listContainerView)
        view.addSubview(addToDoBtn)
        view.backgroundColor = UIColor(.dm, light: UIColor(hexString: "#FFFFFF", alpha: 1), dark: UIColor(hexString: "#000000", alpha: 1))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        topView.frame = CGRect(x: 0, y: statusBarHeight, width: SCREEN_WIDTH, height: 58)
        segmentedView.frame = CGRect(x: 0, y: topView.bottom, width: SCREEN_WIDTH, height: 34)
        listContainerView.frame = CGRect(x: 0, y: segmentedView.bottom, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - segmentedView.bottom)
        addToDoBtn.frame = CGRect(x: SCREEN_WIDTH - 66 - 16, y: SCREEN_HEIGHT - 66 - 66, width: 66, height: 66)
        bottomView.frame = CGRect(x: 0, y: SCREEN_HEIGHT - 95, width: SCREEN_WIDTH, height: 95)
        todoEmptyView.frame = CGRect(x: 0, y: segmentedView.bottom, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - segmentedView.bottom)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getToDoData()
        refreshAllTableView()
    }
    
    // MARK: - Method
    
    // 获取每种todo待办,置顶的待办在上
    private func getToDoData() {
        entireToDoAry.removeAll()
        studyToDoAry.removeAll()
        lifeToDoAry.removeAll()
        otherToDoAry.removeAll()
        var entireNotPinnedAry: [TodoDataModel] = []
        var studyNotPinnedAry: [TodoDataModel] = []
        var lifeNotPinnedAry: [TodoDataModel] = []
        var otherNotPinnedAry: [TodoDataModel] = []
        let tool = TodoSyncTool.share()
        for model in tool.getTodoForMainPage() {
            if model.isPinned {
                entireToDoAry.append(model)
                if model.type == "study" {
                    studyToDoAry.append(model)
                } else if model.type == "life" {
                    lifeToDoAry.append(model)
                } else {
                    otherToDoAry.append(model)
                }
                
            } else{
                entireNotPinnedAry.append(model)
                if model.type == "study" {
                    studyNotPinnedAry.append(model)
                } else if model.type == "life" {
                    lifeNotPinnedAry.append(model)
                } else {
                    otherNotPinnedAry.append(model)
                }
            }
        }
        
        entireToDoAry.append(contentsOf: entireNotPinnedAry)
        studyToDoAry.append(contentsOf: studyNotPinnedAry)
        lifeToDoAry.append(contentsOf: lifeNotPinnedAry)
        otherToDoAry.append(contentsOf: otherNotPinnedAry)
        isRowSelected = Array(repeating: false, count: entireToDoAry.count)
        
        if entireToDoAry.count == 0 {
            view.addSubview(todoEmptyView)
            view.bringSubviewToFront(addToDoBtn)
        } else {
            todoEmptyView.removeFromSuperview()
        }
    }
    
    // 删除tableview对应的model
    private func deleteTableViewModel(_ model: TodoDataModel) {
        if let index = self.entireToDoAry.firstIndex(of: model) {
            self.entireToDoAry.remove(at: index)
            self.entireToDoView.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        }
        if let index = self.studyToDoAry.firstIndex(of: model) {
            self.studyToDoAry.remove(at: index)
            self.studyToDoView.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        }
        if let index = self.lifeToDoAry.firstIndex(of: model) {
            self.lifeToDoAry.remove(at: index)
            self.lifeToDoView.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        }
        if let index = self.otherToDoAry.firstIndex(of: model) {
            self.otherToDoAry.remove(at: index)
            self.otherToDoView.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        }
        if entireToDoAry.count == 0 {
            view.addSubview(todoEmptyView)
            view.bringSubviewToFront(addToDoBtn)
        } else {
            todoEmptyView.removeFromSuperview()
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
        cellBtn.titleLabel?.font = .systemFont(ofSize: 14)
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
    
    // 选择cell的左侧按钮
    private func selectCellRow(_ index: Int) {
        var cell = ToDoTableViewCell()
        switch currentView {
        case .entireView:
            selectedModel.append(entireToDoAry[index])
            cell = entireToDoView.tableView.cellForRow(at: IndexPath(row: index, section: 0)) as! ToDoTableViewCell
        case .studyView:
            selectedModel.append(studyToDoAry[index])
            cell = studyToDoView.tableView.cellForRow(at: IndexPath(row: index, section: 0)) as! ToDoTableViewCell
        case .lifeView:
            selectedModel.append(lifeToDoAry[index])
            cell = lifeToDoView.tableView.cellForRow(at: IndexPath(row: index, section: 0)) as! ToDoTableViewCell
        case .otherView:
            selectedModel.append(otherToDoAry[index])
            cell = otherToDoView.tableView.cellForRow(at: IndexPath(row: index, section: 0)) as! ToDoTableViewCell
        }
        isRowSelected[index] = true
        cell.button.isSelected = true
    }
    
    // 取消选择cell的左侧按钮
    private func deselectCellRow(_ index: Int) {
        var cell = ToDoTableViewCell()
        switch currentView {
        case .entireView:
            if let row = selectedModel.firstIndex(of: entireToDoAry[index]) {
                selectedModel.remove(at: row)
                cell = entireToDoView.tableView.cellForRow(at: IndexPath(row: index, section: 0)) as! ToDoTableViewCell
            }
        case .studyView:
            if let row = selectedModel.firstIndex(of: studyToDoAry[index]) {
                selectedModel.remove(at: row)
                cell = studyToDoView.tableView.cellForRow(at: IndexPath(row: index, section: 0)) as! ToDoTableViewCell
            }
        case .lifeView:
            if let row = selectedModel.firstIndex(of: lifeToDoAry[index]) {
                selectedModel.remove(at: row)
                cell = lifeToDoView.tableView.cellForRow(at: IndexPath(row: index, section: 0)) as! ToDoTableViewCell
            }
        case .otherView:
            if let row = selectedModel.firstIndex(of: otherToDoAry[index]) {
                selectedModel.remove(at: row)
                cell = otherToDoView.tableView.cellForRow(at: IndexPath(row: index, section: 0)) as! ToDoTableViewCell
            }
        }
        isRowSelected[index] = false
        cell.button.isSelected = false
    }
    
    // 刷新所有tableview
    private func refreshAllTableView() {
        entireToDoView.tableView.reloadData()
        studyToDoView.tableView.reloadData()
        lifeToDoView.tableView.reloadData()
        otherToDoView.tableView.reloadData()
    }
    
    // 退出批量管理
    private func exitBatchManage() {
        isBeingManage = false
        segmentedView.isUserInteractionEnabled = true
        bottomView.removeFromSuperview()
        view.addSubview(addToDoBtn)
        isRowSelected = Array(repeating: false, count: entireToDoAry.count)
        bottomView.checkBoxBtn.isSelected = false
        selectedModel = []
        topView.manageBtn.isSelected = false
    }
        
    @objc private func clickAddToDoBtn() {
        let sheetView = DiscoverTodoSheetView()
        sheetView.delegate = self
        view.addSubview(sheetView)
        sheetView.showView()
    }
    
    // MARK: - Lazy
    
    private lazy var topView: ToDoTopView = {
        let topView = ToDoTopView()
        topView.delegate = self
        return topView
    }()
    
    private lazy var segmentedView: JXSegmentedView = {
        let indicator = JXSegmentedIndicatorImageView()
        indicator.image = UIImage(named: "todo选中效果")
        indicator.indicatorWidth = 32
        indicator.indicatorHeight = 3
        indicator.indicatorPosition = .bottom
        
        let segmentedView = JXSegmentedView()
        segmentedView.delegate = self
        segmentedView.dataSource = segmentedDataSource
        segmentedView.indicators = [indicator]
        segmentedView.listContainer = listContainerView
        segmentedView.defaultSelectedIndex = 0
        segmentedView.backgroundColor = UIColor(.dm, light: UIColor(hexString: "#FFFFFF", alpha: 1), dark: UIColor(hexString: "#000000", alpha: 1))
        return segmentedView
    }()
    
    private lazy var segmentedDataSource: JXSegmentedTitleDataSource = {
        let segmentedDataSource = JXSegmentedTitleDataSource()
        segmentedDataSource.titles = ["全部", "学习", "生活", "其他"]
        segmentedDataSource.titleNormalFont = .systemFont(ofSize: 18)
        segmentedDataSource.titleSelectedColor = UIColor(.dm, light: UIColor(hexString: "#112C54", alpha: 1), dark: UIColor(hexString: "#DFDFE3", alpha: 1))
        segmentedDataSource.titleNormalColor = UIColor(.dm, light: UIColor(hexString: "#142C52", alpha: 0.4), dark: UIColor(hexString: "#606061", alpha: 1))
        return segmentedDataSource
    }()
    
    private lazy var listContainerView: JXSegmentedListContainerView = {
        let listContainerView = JXSegmentedListContainerView(dataSource: self)
        listContainerView.scrollView.isScrollEnabled = false
        return listContainerView
    }()
    
    private lazy var entireToDoView: ToDoTypeView = {
        let entireToDoView = ToDoTypeView()
        entireToDoView.tableView.delegate = self
        entireToDoView.tableView.dataSource = self
        return entireToDoView
    }()
    
    private lazy var studyToDoView: ToDoTypeView = {
        let studyToDoView = ToDoTypeView()
        studyToDoView.tableView.delegate = self
        studyToDoView.tableView.dataSource = self
        return studyToDoView
    }()
    
    private lazy var lifeToDoView: ToDoTypeView = {
        let lifeToDoView = ToDoTypeView()
        lifeToDoView.tableView.delegate = self
        lifeToDoView.tableView.dataSource = self
        return lifeToDoView
    }()
    
    private lazy var otherToDoView: ToDoTypeView = {
        let otherToDoView = ToDoTypeView()
        otherToDoView.tableView.delegate = self
        otherToDoView.tableView.dataSource = self
        return otherToDoView
    }()
    
    private lazy var addToDoBtn: UIButton = {
        let addToDoBtn = UIButton()
        addToDoBtn.setImage(UIImage(named: "添加待办按钮"), for: .normal)
        addToDoBtn.addTarget(self, action: #selector(clickAddToDoBtn), for: .touchUpInside)
        return addToDoBtn
    }()
    
    private lazy var bottomView: ToDoBatchManageBottomView = {
        let bottomView = ToDoBatchManageBottomView()
        bottomView.delegate = self
        return bottomView
    }()
    
    private lazy var todoEmptyView: ToDoEmptyView = {
        let todoEmptyView = ToDoEmptyView()
        return todoEmptyView
    }()
}

// MARK: - JXSegmentedListContainerViewDataSource

extension ToDoVC: JXSegmentedListContainerViewDataSource {
    
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        return segmentedDataSource.titles.count
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        switch index {
        case 0:
            return entireToDoView
        case 1:
            return studyToDoView
        case 2:
            return lifeToDoView
        default:
            return otherToDoView
        }
    }
}

// MARK: - JXSegmentedViewDelegate

extension ToDoVC: JXSegmentedViewDelegate {
    
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        switch index {
        case 0:
            currentView = .entireView
            entireToDoView.tableView.reloadData()
        case 1:
            currentView = .studyView
            studyToDoView.tableView.reloadData()
        case 2:
            currentView = .lifeView
            lifeToDoView.tableView.reloadData()
        default:
            currentView = .otherView
            otherToDoView.tableView.reloadData()
        }
    }
}

// MARK: - ToDoTopViewDelegate

extension ToDoVC: ToDoTopViewDelegate {
    
    func popVC() {
        navigationController?.popViewController(animated: true)
    }
    
    func batchManage(isSelected: Bool) {
        if isSelected {
            isBeingManage = true
            segmentedView.isUserInteractionEnabled = false
            view.addSubview(bottomView)
            addToDoBtn.removeFromSuperview()
        } else {
            exitBatchManage()
        }
        refreshAllTableView()
    }
}

// MARK: - ToDoBatchManageBottomViewDelegate

extension ToDoVC: ToDoBatchManageBottomViewDelegate {
    
    func checkAllToDo(isSelected: Bool) {
        switch currentView {
        case .entireView:
            for index in 0..<entireToDoAry.count {
                if isSelected {
                    selectCellRow(index)
                } else {
                    deselectCellRow(index)
                }
            }
        case .studyView:
            for index in 0..<studyToDoAry.count {
                if isSelected {
                    selectCellRow(index)
                } else {
                    deselectCellRow(index)
                }
            }
        case .lifeView:
            for index in 0..<lifeToDoAry.count {
                if isSelected {
                    selectCellRow(index)
                } else {
                    deselectCellRow(index)
                }
            }
        case .otherView:
            for index in 0..<otherToDoAry.count {
                if isSelected {
                    selectCellRow(index)
                } else {
                    deselectCellRow(index)
                }
            }
        }
        refreshAllTableView()
    }
    
    func stickyToDos() {
        for index in 0..<selectedModel.count {
            let model = selectedModel[index]
            model.isPinned = true
            model.lastModifyTime = Int(Date().timeIntervalSince1970)
            model.resetOverdueTime(NSDate.nowTimestamp())
            TodoSyncTool.share().alterTodo(with: model, needRecord: true)
        }
        exitBatchManage()
        getToDoData()
        refreshAllTableView()
    }
    
    func deleteToDos() {
        let alertController = ToDoAlertController { [weak self] in
            guard let self = self else { return }
            for model in self.selectedModel {
                self.deleteTableViewModel(model)
                TodoSyncTool.share().deleteTodo(withTodoID: model.todoIDStr, needRecord: true)
            }
            self.exitBatchManage()
            self.refreshAllTableView()
        } cancelAction: {
            print("取消批量删除")
        }
        self.present(alertController, animated: true)
    }
}

// MARK: - ToDoTableViewCellDelegate

extension ToDoVC: ToDoTableViewCellDelegate {
    
    func clickToDoCircleBtn(sender: UIButton) {
        if isBeingManage {
            if sender.isSelected {
                sender.setBackgroundImage(UIImage(named: "todo方框_已选中"), for: .normal)
                selectCellRow(sender.tag)
            } else {
                sender.setBackgroundImage(UIImage(named: "todo方框"), for: .normal)
                deselectCellRow(sender.tag)
            }
        } else {
            // 非批量管理下选中按钮
            if sender.isSelected {
                let model: TodoDataModel
                var cell = ToDoTableViewCell()
                switch currentView {
                case .entireView:
                    model = entireToDoAry[sender.tag]
                    cell = entireToDoView.tableView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! ToDoTableViewCell
                case .studyView:
                    model = studyToDoAry[sender.tag]
                    cell = studyToDoView.tableView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! ToDoTableViewCell
                case .lifeView:
                    model = lifeToDoAry[sender.tag]
                    cell = lifeToDoView.tableView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! ToDoTableViewCell
                case .otherView:
                    model = otherToDoAry[sender.tag]
                    cell = otherToDoView.tableView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! ToDoTableViewCell
                }
                
                let group = DispatchGroup()
                group.enter()
                let contentOriginalColor = cell.contentLab.textColor
                cell.contentLab.textColor = UIColor(.dm, light: UIColor(hexString: "#B9C2CE", alpha: 1), dark: UIColor(hexString: "#5C5C5D", alpha: 1))
                let strikethroughView = UIView(frame: CGRect(x: cell.contentLab.left - 5, y: cell.contentLab.top + cell.contentLab.height / 2, width: 0, height: 2))
                strikethroughView.backgroundColor = UIColor(.dm, light: UIColor(hexString: "#8997AD", alpha: 1), dark: UIColor(hexString: "#7E7E7F", alpha: 1))
                cell.addSubview(strikethroughView)
                UIView.animate(withDuration: 0.5) {
                    strikethroughView.width =  cell.contentLab.intrinsicContentSize.width + 2 * 5
                } completion: { _ in
                    TodoSyncTool.share().deleteTodo(withTodoID: model.todoIDStr, needRecord: true)
                    group.leave()
                }
                let path = UIBezierPath(roundedRect: strikethroughView.bounds, byRoundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight], cornerRadii: CGSize(width: 5, height: 5))
                let mask = CAShapeLayer()
                mask.path = path.cgPath
                strikethroughView.layer.mask = mask
                sender.setBackgroundImage(UIImage(named: "已完成圆圈"), for: .normal)
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy年M月d日HH:mm"
                let time = dateFormatter.date(from: model.timeStr)?.timeIntervalSince1970
                if (model.repeatMode != .NO && model.timeStr.isEmpty) || (model.repeatMode != .NO && !model.timeStr.isEmpty && model.overdueTime < Int(time ?? 0)) {
                    group.enter()
                    let newModel = model.copy() as! TodoDataModel
                    newModel.todoIDStr = String(Int(Date().timeIntervalSince1970))
                    newModel.lastModifyTime = Int(Date().timeIntervalSince1970)
                    newModel.lastOverdueTime = model.overdueTime
                    newModel.overdueTime = 0
                    let timeStamp =  NSDate.nowTimestamp() > model.overdueTime ? NSDate.nowTimestamp() : model.overdueTime
                    newModel.resetOverdueTime(timeStamp)
                    TodoSyncTool.share().saveTodo(with: newModel, needRecord: true)
                    group.leave()
                }
                
                group.notify(queue: .main) {
                    strikethroughView.removeFromSuperview()
                    cell.contentLab.textColor = contentOriginalColor
                    self.getToDoData()
                    self.refreshAllTableView()
                }
            } else {
                sender.setBackgroundImage(UIImage(named: "未完成圆圈"), for: .normal)
            }
        }
    }
}

// MARK: - DiscoverTodoSheetViewDelegate

extension ToDoVC: DiscoverTodoSheetViewDelegate {
    
    func sheetViewSaveBtnClicked(_ dataModel: TodoDataModel) {
        dataModel.todoIDStr = String(Int(Date().timeIntervalSince1970))
        dataModel.resetOverdueTime(NSDate.nowTimestamp())
        dataModel.lastModifyTime = Int(Date().timeIntervalSince1970)
        TodoSyncTool.share().saveTodo(with: dataModel, needRecord: true)
        getToDoData()
        refreshAllTableView()
    }
    
    func sheetViewCancelBtnClicked() {
        
    }
}

// MARK: - UITableViewDataSource

extension ToDoVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0;
        if tableView == entireToDoView.tableView {
            count = entireToDoAry.count
        } else if tableView == studyToDoView.tableView {
            count = studyToDoAry.count
        } else if tableView == lifeToDoView.tableView {
            count = lifeToDoAry.count
        } else if tableView == otherToDoView.tableView {
            count = otherToDoAry.count
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var data = TodoDataModel()
        if tableView == entireToDoView.tableView {
            data = entireToDoAry[indexPath.row]
        } else if tableView == studyToDoView.tableView {
            data = studyToDoAry[indexPath.row]
        } else if tableView == lifeToDoView.tableView {
            data = lifeToDoAry[indexPath.row]
        } else if tableView == otherToDoView.tableView {
            data = otherToDoAry[indexPath.row]
        }
        
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
        
        let cell: ToDoTableViewCell
        let identifier: String
        
        if isTop, haveTime, expired {
            identifier = ToDoTopExpiredStyleCellReuseIdentifier
        } else if isTop, haveTime, !expired {
            identifier = ToDoTopActiveStyleCellReuseIdentifier
        } else if isTop, !haveTime {
            identifier = ToDoTopNoDeadlineStyleCellReuseIdentifier
        } else if !isTop, haveTime, expired {
            identifier = ToDoNonTopExpiredStyleCellReuseIdentifier
        } else if !isTop, haveTime, !expired {
            identifier = ToDoNonTopActiveStyleCellReuseIdentifier
        } else {
            identifier = ToDoNonTopNoDeadlineStyleCellReuseIdentifier
        }
        
        cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ToDoTableViewCell
        cell.selectionStyle = .none
        cell.button.tag = indexPath.row
        cell.contentLab.text = data.titleStr
        cell.timeLab.text = data.overdueTimeStr.isEmpty ? data.timeStr : data.overdueTimeStr
        cell.delegate = self
        
        if isBeingManage {
            if isRowSelected[indexPath.row] {
                cell.button.setBackgroundImage(UIImage(named: "todo方框_已选中"), for: .normal)
            } else {
                cell.button.setBackgroundImage(UIImage(named: "todo方框"), for: .normal)
            }
        } else {
            if expired {
                cell.button.setBackgroundImage(UIImage(named: "ToDo过期圆圈"), for: .normal)
            } else {
                cell.button.setBackgroundImage(UIImage(named: "未完成圆圈"), for: .normal)
            }
        }
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ToDoVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var data = TodoDataModel()
        switch currentView {
        case .entireView:
            guard indexPath.row < entireToDoAry.count else {
                return 0
            }
            data = entireToDoAry[indexPath.row]
        case .studyView:
            guard indexPath.row < studyToDoAry.count else {
                return 0
            }
            data = studyToDoAry[indexPath.row]
        case .lifeView:
            guard indexPath.row < lifeToDoAry.count else {
                return 0
            }
            data = lifeToDoAry[indexPath.row]
        case .otherView:
            guard indexPath.row < otherToDoAry.count else {
                return 0
            }
            data = otherToDoAry[indexPath.row]
        }
        
        return (data.timeStr.isEmpty && data.overdueTimeStr.isEmpty) ? 49 : 67
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isBeingManage {
            let model: TodoDataModel
            switch currentView {
            case .entireView:
                model = entireToDoAry[indexPath.row]
            case .studyView:
                model = studyToDoAry[indexPath.row]
            case .lifeView:
                model = lifeToDoAry[indexPath.row]
            case .otherView:
                model = otherToDoAry[indexPath.row]
            }
            navigationController?.pushViewController(ToDoDetailVC(model: model), animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var model = TodoDataModel()
        if tableView == self.entireToDoView.tableView {
            model = self.entireToDoAry[indexPath.row]
        } else if tableView == self.studyToDoView.tableView {
            model = self.studyToDoAry[indexPath.row]
        } else if tableView == self.lifeToDoView.tableView {
            model = self.lifeToDoAry[indexPath.row]
        } else if tableView == self.otherToDoView.tableView {
            model = self.otherToDoAry[indexPath.row]
        }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "  ") { action, sourceView, completionHandler in
            let alertController = ToDoAlertController { [weak self] in
                guard let self = self else { return }
                self.deleteTableViewModel(model)
                TodoSyncTool.share().deleteTodo(withTodoID: model.todoIDStr, needRecord: true)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    tableView.reloadData()
                    completionHandler(true)
                }
            } cancelAction: {
                completionHandler(false)
            }
            self.present(alertController, animated: true)

        }
        deleteAction.backgroundColor = UIColor(.dm, light: UIColor(hexString: "#FF6262", alpha: 1), dark: UIColor(hexString: "#FF6262", alpha: 1))

        let stickyAction = UIContextualAction(style: .destructive, title: model.isPinned ? "aaaaaaaaaaa" : "  ") { action, sourceView, completionHandler in
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
        var model = TodoDataModel()
        if tableView == entireToDoView.tableView {
            model = entireToDoAry[indexPath.row]
        } else if tableView == studyToDoView.tableView {
            model = studyToDoAry[indexPath.row]
        } else if tableView == lifeToDoView.tableView {
            model = lifeToDoAry[indexPath.row]
        } else if tableView == otherToDoView.tableView {
            model = otherToDoAry[indexPath.row]
        }
        
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
                        if subView.subviews.count >= 2 {
                            let deleteBtn = subView.subviews[1]
                            let stickyBtn = subView.subviews[0]
                            configDeleteButton(deleteBtn as! UIButton, model: model)
                            configStickyButton(stickyBtn as! UIButton, model: model)
                        }
                    }
                }
            }
        }
    }
}
