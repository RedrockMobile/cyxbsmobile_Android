//
//  FinderToolsView.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/10/2.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit
import ProgressHUD

class FinderToolsView: UIView {

    private(set) lazy var models: [FinderToolsModel] = getFinderToolsFromOC
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        addNotification()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 适配OC代码
    func addNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(customFromNotification), name: .init("customizeMainPageViewSuccess"), object: nil)
    }
    
    @objc
    func customFromNotification() {
        models = getFinderToolsFromOC
        collectionView.reloadData()
    }
    
    lazy var collectionView: UICollectionView = {
        let frame = bounds
        let itemWidth: CGFloat = 75
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing =
            (frame.width - CGFloat(models.count) * itemWidth) / CGFloat(models.count - 1)
        layout.itemSize = CGSize(width: itemWidth, height: frame.height)
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(FinderToolsCollectionViewCell.self, forCellWithReuseIdentifier: FinderToolsCollectionViewCell.identifier)
        return collectionView
    }()
}

// MARK: data

extension FinderToolsView {
    
    var getFinderTools: [FinderToolsModel] {
        let model = FinderToolsModel(name: "更多功能", icon: "finder_tool_more", describe: "更多功能敬请期待", api_available: false, web_available: false)
        if let threeTools = CacheManager.shared.getCodable([FinderToolsModel].self, in: .threeTools) {
            return threeTools + [model]
        } else {
            if let allTools = CacheManager.shared.getCodable([FinderToolsModel].self, in: .toolsFromBundle) {
                let threeTools = Array(allTools[0 ..< 3])
                CacheManager.shared.cache(codable: threeTools, in: .threeTools)
                return threeTools + [model]
            } else {
                return []
            }
        }
    }
    
    var getFinderToolsFromOC: [FinderToolsModel] {
        let model = FinderToolsModel(name: "更多功能", icon: "finder_tool_more", describe: "更多功能敬请期待", api_available: false, web_available: false)
        if let ocNames = UserDefaultsManager.shared.get(key: "ToolPage_UserFavoriteToolsName") as? [String] {
            if let allTools = CacheManager.shared.getCodable([FinderToolsModel].self, in: .toolsFromBundle) {
                return ocNames.compactMap { name in
                    allTools.first { tool in
                        tool.name == name
                    }
                } + [model]
            } else {
                return []
            }
        } else {
            let fromSwift = getFinderTools
            if fromSwift.count >= 3 {
                let names = Array(fromSwift[0 ..< 3]).map { $0.name }
                UserDefaultsManager.shared.set(names, forKey: "ToolPage_UserFavoriteToolsName")
                return fromSwift
            } else {
                return []
            }
        }
    }
}

// MARK: UICollectionViewDataSource

extension FinderToolsView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let data = models[indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FinderToolsCollectionViewCell.identifier, for: indexPath) as! FinderToolsCollectionViewCell
        
        cell.imageSize = CGSize(width: 40, height: 35)
        cell.spaceForMiddle = 7
        cell.setupData(title: data.name, imgName: data.icon)
        
        return cell
    }
}

// MARK: UICollectionViewDelegate

extension FinderToolsView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = models[indexPath.item]
        push(to: item.name)
    }
    
    func push(to name: String) {
        var vc: UIViewController? = nil
        if name == "查课表" {
            vc = ScheduleInquiryViewController()
        } else if name == "没课约" {
            vc = WeDateVC()
        } else if name == "校车轨迹" {
            vc = SchoolBusVC()
        } else if name == "校历" {
            vc = CalendarViewController()
        } else if name == "重邮地图" {
            vc = CQUPTMapViewController()
        } else if name == "邮子清单" {
            vc = ToDoVC()
        } else if name == "空教室" {
            vc = EmptyClassViewController()
        } else if name == "体育打卡" {
            vc = SportAttendanceViewController()
        } else if name == "我的考试" {
            vc = TestArrangeViewController()
        } else if name == "更多功能" {
            vc = FinderToolViewController()
        }
        guard let vc = vc else {
            ProgressHUD.showFailed("功能正在开发中...")
            return
        }
        vc.hidesBottomBarWhenPushed = true
        latestViewController?.navigationController?.pushViewController(vc, animated: true)
    }
}

extension FinderToolsView: UICollectionViewDelegateFlowLayout {
    
}
