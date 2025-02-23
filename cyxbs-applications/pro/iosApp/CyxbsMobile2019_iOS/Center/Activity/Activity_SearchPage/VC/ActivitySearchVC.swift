//
//  ActivitySearchVC.swift
//  CyxbsMobile2019_iOS
//
//  Created by 许晋嘉 on 2023/9/9.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit
import Alamofire

class ActivitySearchVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    let activitiesModel = ActivitiesModel()
    var activityType: String = "all"
    let textLimitManager = TextManager.shared
    var detailParagraphStyle = NSMutableParagraphStyle()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(hexString: "#FAFBFF", alpha: 1)
        view.addSubview(backButton)
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        view.addSubview(selectBar)
        view.addSubview(tableView)
        detailParagraphStyle.lineHeightMultiple = 0.8
        setPosition()
    }
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "activityBack"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 7, left: 1, bottom: 8, right: 22)
        button.addTarget(self, action: #selector(popController), for: .touchUpInside)
        return button
    }()
    
    lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 38))
        textField.leftViewMode = .always
        textField.placeholder = "查看更多活动..."
        let imageView = UIImageView(image: UIImage(named: "放大镜"))
        imageView.frame = CGRect(x: 14, y: 10, width: 18, height: 17)
        textField.leftView?.addSubview(imageView)
        textField.font = UIFont(name: PingFangSCMedium, size: 16)
        textField.textColor = UIColor(red: 0.082, green: 0.192, blue: 0.357, alpha: 0.4)
        textField.layer.cornerRadius = 19
        textField.clipsToBounds = true
        textLimitManager.setupLimitForTextField(textField, maxLength: 10)
        textField.returnKeyType = .search
        textField.delegate = self
        return textField
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(NSMutableAttributedString(string: "搜索", attributes: [NSAttributedString.Key.kern: 0.7]), for: .normal)
        button.titleLabel?.font = UIFont(name: PingFangSCMedium, size: 14)
        button.titleLabel?.textColor = UIColor(red: 0.29, green: 0.267, blue: 0.894, alpha: 1)
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //活动类型选择bar
    lazy var selectBar: ActivitySelectBar = {
        let selectBar = ActivitySelectBar(frame: CGRectMake(0, Constants.statusBarHeight + 39, view.bounds.width, 51))
        selectBar.buttons.forEach({ button in
            button.addTarget(self, action: #selector(catagoryButtonTapped(_:)), for: .touchUpInside)
        })
        return selectBar
    }()
    
    //活动展示tableView
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRectMake(0, Constants.statusBarHeight + 106, UIScreen.main.bounds.width, UIScreen.main.bounds.height - Constants.statusBarHeight - 106))
        tableView.backgroundColor = .white
        tableView.register(ActivitySearchTableViewCell.self, forCellReuseIdentifier: "searchCell")
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    func setPosition() {
        self.backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(Constants.statusBarHeight + 9)
            make.width.equalTo(30)
            make.height.equalTo(31)
        }
        
        self.searchTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(35)
            make.trailing.equalToSuperview().offset(-52)
            make.top.equalToSuperview().offset(Constants.statusBarHeight + 6)
            make.height.equalTo(38)
        }
        
        self.searchButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-8)
            make.top.equalToSuperview().offset(Constants.statusBarHeight + 18)
            make.width.equalTo(36)
            make.height.equalTo(14)
        }
    }
    
    //单选按钮点击
    @objc private func catagoryButtonTapped(_ sender: RadioButton) {
        // 根据需要在这里执行相应的操作，例如根据按钮的标签来处理不同的逻辑
        switch sender.tag {
        case 0:
            print("全部活动")
            // 处理 "全部" 按钮点击事件
            activityType = "all"
            break
        case 1:
            print("文娱活动")
            // 处理 "文娱活动" 按钮点击事件
            activityType = "culture"
            break
        case 2:
            print("体育活动")
            // 处理 "体育活动" 按钮点击事件
            activityType = "sports"
            break
        case 3:
            print("教育活动")
            // 处理 "教育活动" 按钮点击事件
            activityType = "education"
            break
        default:
            break
        }
        hideKeyboardAndRequest()
    }
    
    //搜索按钮点击
    @objc func searchButtonTapped() {
        hideKeyboardAndRequest()
    }
    
    func hideKeyboardAndRequest() {
        searchTextField.resignFirstResponder()
        refreshSearchActivities()
    }
    
    //返回上一级界面
    @objc func popController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func refreshSearchActivities() {
        if searchTextField.text?.count != 0 {
            activitiesModel.requestSearchActivity(keyword: searchTextField.text!, activityType: activityType) { activities in
                print(self.activitiesModel.activities.count)
                if (self.activitiesModel.activities.count == 0) {
                    ActivityHUD.shared.showNoMoreData()
                }
                self.tableView.reloadData()
            } failure: { error in
                print(error)
                ActivityHUD.shared.showNetworkError()
            }
        } else {
            RemindHUD.shared().showDefaultHUD(withText: "请输入有效的活动名称")
        }
    }
    
    struct DateConvert {
        static let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "zh_CN")
            formatter.dateFormat = "yyyy年M月d日"
            return formatter
        }()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! ActivitySearchTableViewCell
        cell.coverImgView.sd_setImage(with: URL(string: activitiesModel.activities[indexPath.item].activityCoverURL))
        cell.titleLabel.text = activitiesModel.activities[indexPath.item].activityTitle
        cell.detailLabel.attributedText = NSMutableAttributedString(string: activitiesModel.activities[indexPath.item].activityDetail, attributes: [NSAttributedString.Key.paragraphStyle: detailParagraphStyle])
        cell.startTimeLabel.text = DateConvert.dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(activitiesModel.activities[indexPath.item].activityStartAt)))
        if (activitiesModel.activities[indexPath.item].ended ?? true){
            cell.statusImgView.image = UIImage(named: "activityEnded")
        } else{
            cell.statusImgView.image = UIImage(named: "activityOngoing")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 133
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activitiesModel.activities.count
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = ActivityDetailVC()
        detailVC.activity = activitiesModel.activities[indexPath.row]
        detailVC.numOfIndexPath = indexPath.row
        detailVC.delegate = self
        self.navigationController?.pushViewController(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == searchTextField {
            hideKeyboardAndRequest()
        }
        return true
    }
}

//为了减少请求次数，减轻服务器压力，详情页的数据由model传过去，使用代理来实现点击想看后修改model的值
extension ActivitySearchVC: ActivityDetailVCDelegate {
    func updateModel(indexPathNum: Int, wantToWatch: Bool) {
        self.activitiesModel.activities[indexPathNum].wantToWatch = wantToWatch
    }
    
    func updateModel(indexPathNum: Int, addToDo: Bool) {
        self.activitiesModel.activities[indexPathNum].isAdded = addToDo
    }
}



