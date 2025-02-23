//
//  ActivityHitVC.swift
//  CyxbsMobile2019_iOS
//
//  Created by 许晋嘉 on 2023/9/3.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class ActivityRankingListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let hitActivities = ActivitiesModel()
    var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(backButton)
        view.addSubview(topImgView)
        setContentView()
        contentView.addSubview(tableView)
        setPosition()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        hitActivities.requestHitActivity { activities in
            print("活动数量\(self.hitActivities.activities.count)")
            self.tableView.reloadData()
        } failure: { error in
            print(error)
            ActivityHUD.shared.showNetworkError()
        }
    }
    
    // 返回按钮
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "whiteBack"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(popController), for: .touchUpInside)
        return button
    }()
    
    //顶部“排行榜”字样图片
    lazy var topImgView: UIImageView = {
        let imageView = UIImageView(frame: CGRectMake(0, 0, UIScreen.main.bounds.width, 198))
        imageView.image = UIImage(named: "排行榜")
        return imageView
    }()
    
    //排行榜tableView
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRectMake(0, 26, UIScreen.main.bounds.width, UIScreen.main.bounds.height-210))
        tableView.register(ActivityHitTableViewCell.self, forCellReuseIdentifier: "hitCell")
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    //返回上一个vc
    @objc func popController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setContentView() {
        contentView = UIView()
        contentView.frame = CGRectMake(0, 184, UIScreen.main.bounds.width, UIScreen.main.bounds.height)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 18
        view.addSubview(contentView)
        let shadowPath0 = UIBezierPath(roundedRect: contentView.bounds, cornerRadius: 18)
        let layer0 = CALayer()
        layer0.shadowPath = shadowPath0.cgPath
        layer0.shadowColor = UIColor(hexString: "#2C528D",alpha: 0.03).cgColor
        layer0.shadowOpacity = 1
        layer0.shadowRadius = 101
        layer0.shadowOffset = CGSize(width: 0, height: 13)
        layer0.bounds = contentView.bounds
        layer0.position = contentView.center
        contentView.layer.addSublayer(layer0)
    }
    
    // MARK: - 设置子视图位置
    func setPosition() {
        // 返回按钮
        self.backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(17)
            make.top.equalToSuperview().offset(Constants.statusBarHeight + 13)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        //返回按钮图片
        self.backButton.imageView?.snp.makeConstraints { make in
            make.leading.equalTo(self.backButton)
            make.width.equalTo(7)
            make.height.equalTo(16)
            make.centerY.equalTo(self.backButton)
        }
    }
    
    // UITableViewDataSource方法
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hitCell", for: indexPath) as! ActivityHitTableViewCell
        //对前三个cell的特殊样式进行取消，防止因为cell的自动复用复用导致样式错误
        cell.rankingImgView.removeFromSuperview()
        cell.contentView.addSubview(cell.rankingLabel)
        cell.hotImgView.removeFromSuperview()
        cell.coverImgView.sd_setImage(with: URL(string: hitActivities.activities[indexPath.item].activityCoverURL))
        cell.titleLabel.attributedText = NSMutableAttributedString(string: hitActivities.activities[indexPath.item].activityTitle, attributes: [NSAttributedString.Key.kern: 0.54])
        cell.rankingLabel.attributedText = NSMutableAttributedString(string: "\(indexPath.item + 1)", attributes: [NSAttributedString.Key.kern: 0.6])
        cell.wantToWatchNum.attributedText = NSMutableAttributedString(string: "\(hitActivities.activities[indexPath.item].activityWatchNumber)", attributes: [NSAttributedString.Key.kern: 0.54])
        if indexPath.item < 3 {
            cell.rankingLabel.removeFromSuperview()
            cell.addHotImg()
            cell.contentView.addSubview(cell.rankingImgView)
            cell.rankingImgView.image = UIImage(named: "ActivityNo\(indexPath.item + 1)")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hitActivities.activities.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // UITableViewDelegate方法
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = ActivityDetailVC()
        detailVC.activity = hitActivities.activities[indexPath.row]
        detailVC.numOfIndexPath = indexPath.row
        detailVC.delegate = self
        self.navigationController?.pushViewController(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//为了减少请求次数，减轻服务器压力，详情页的数据由model传过去，使用代理来实现点击想看后修改model的值
extension ActivityRankingListVC: ActivityDetailVCDelegate {
    func updateModel(indexPathNum: Int, wantToWatch: Bool) {
        self.hitActivities.activities[indexPathNum].wantToWatch = wantToWatch
    }
    
    func updateModel(indexPathNum: Int, addToDo: Bool) {
        self.hitActivities.activities[indexPathNum].isAdded = addToDo
    }
}
