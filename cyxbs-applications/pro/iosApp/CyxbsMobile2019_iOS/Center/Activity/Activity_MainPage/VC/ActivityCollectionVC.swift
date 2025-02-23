//
//  ActivityCollectionViewController.swift
//  CyxbsMobile2019_iOS
//
//  Created by 许晋嘉 on 2023/8/16.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit
import SDWebImage
import MJRefresh
import JXSegmentedView

class ActivityCollectionVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var activityType: ActivityType = .all
    let refreshNum: Int = 10
    let activitiesModel = ActivitiesModel()
    private var activityTypeString: String?
    private var collectionViewCount: Int = 0
    private var cellWidth: CGFloat = 0.0
    private var collectionView: UICollectionView!
    
    init(activityType: ActivityType) {
        self.activityType = activityType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        switch activityType {
        case .all:
            activityTypeString = nil
        case .culture:
            activityTypeString = "culture"
        case .sports:
            activityTypeString = "sports"
        case .education:
            activityTypeString = "education"
        }
        self.requestActivity()
        // 创建一个UICollectionViewFlowLayout实例作为集合视图的布局
        let layout = UICollectionViewFlowLayout()
        //计算cell的宽度
        cellWidth = (self.view.bounds.width - 41) / 2
        // 设置单元格之间的水平间距
        layout.minimumInteritemSpacing = 9
        // 设置单元格之间的垂直间距
        layout.minimumLineSpacing = layout.minimumInteritemSpacing
        // 计算每行的内边距，以保证单元格居中显示
        layout.sectionInset = UIEdgeInsets(top: 2, left: 16, bottom: 10, right: 16)
        // 使用上述布局创建一个UICollectionView实例，将其框架设置为与当前视图大小相同
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ActivityCollectionViewCell.self, forCellWithReuseIdentifier: ActivityCollectionViewCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        self.collectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        self.addMJHeader()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.frame = self.view.bounds
    }
    
    @objc func requestActivity() {
        activitiesModel.requestNoticeboardActivities(activityType: activityTypeString) { activities in
            print("活动数量：\(activities.count)")
            self.collectionViewCount = activities.count
            //这里是做伪分页的逻辑
            if(self.activitiesModel.activities.count < self.refreshNum) {
                self.collectionViewCount = self.activitiesModel.activities.count
            } else {
                self.collectionViewCount = self.refreshNum
            }
            self.collectionView.mj_header?.endRefreshing()
            self.collectionView.reloadData()
            if (self.collectionViewCount != 0) {
                self.addMJFooter()
            }
        } failure: { error in
            ActivityHUD.shared.showNetworkError()
        }
    }
    
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActivityCollectionViewCell.reuseIdentifier, for: indexPath) as! ActivityCollectionViewCell
        cell.titleLabel.text = activitiesModel.activities[indexPath.item].activityTitle
        cell.coverImgView.sd_setImage(with: URL(string: activitiesModel.activities[indexPath.item].activityCoverURL))
        cell.startTimeLabel.text = DateConvert.dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(activitiesModel.activities[indexPath.item].activityStartAt)))
        switch activitiesModel.activities[indexPath.item].activityType {
        case "culture": cell.activityTypeLabel.text = "文娱活动"
        case "sports": cell.activityTypeLabel.text = "体育活动"
        case "education": cell.activityTypeLabel.text = "教育活动"  
        default: break
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: 237)
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = ActivityDetailVC()
        detailVC.activity = activitiesModel.activities[indexPath.item]
        detailVC.numOfIndexPath = indexPath.item
        detailVC.delegate = self
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    struct DateConvert {
        static let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "zh_CN")
            formatter.dateFormat = "yyyy年M月d日"
            return formatter
        }()
    }
    
    func addMJHeader() {
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(requestActivity))
        collectionView.mj_header = header
    }
    
    func addMJFooter() {
        if let footer = collectionView.mj_footer {
            footer.endRefreshing()
        }else {
            let footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(refreshCollectionView))
            footer.setTitle("", for: .idle)
            footer.setTitle("正在加载...", for: .refreshing)
            footer.setTitle("已经加载到最底部", for: .noMoreData)
            footer.stateLabel?.textColor = UIColor(hexString: "#15315B", alpha: 0.3)
            collectionView.mj_footer = footer
        }
    }
    
    @objc func refreshCollectionView() {
        if self.collectionViewCount != self.activitiesModel.activities.count {
            self.collectionViewCount = self.collectionViewCount + self.refreshNum
            if self.collectionViewCount > self.activitiesModel.activities.count {
                self.collectionViewCount = self.activitiesModel.activities.count
            }
            //延迟加载新的cell
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.collectionView.mj_footer?.endRefreshing()
                self.collectionView.reloadData()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.collectionView.mj_footer?.endRefreshingWithNoMoreData()
                ActivityHUD.shared.showNoMoreData()
            }
        }
    }
}

//为了减少请求次数，减轻服务器压力，详情页的数据由model传过去，使用代理来实现点击想看后修改model的值
extension ActivityCollectionVC: ActivityDetailVCDelegate {
    func updateModel(indexPathNum: Int, wantToWatch: Bool) {
        self.activitiesModel.activities[indexPathNum].wantToWatch = wantToWatch
    }
    
    func updateModel(indexPathNum: Int, addToDo: Bool) {
        self.activitiesModel.activities[indexPathNum].isAdded = addToDo
    }
}

// MARK: - JXSegmentedListContainerViewListDelegate，返回containerView展示的视图
extension ActivityCollectionVC: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
