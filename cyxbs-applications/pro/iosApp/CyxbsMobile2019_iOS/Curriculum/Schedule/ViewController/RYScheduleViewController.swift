//
//  RYScheduleViewController.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/9/9.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

class RYScheduleViewController: UIViewController {
    
    let fact = RYScheduleInteractionFact()
    
    var isCustomEditEnable: Bool {
        set { fact.isCustomEditEnable = newValue }
        get { fact.isCustomEditEnable }
    }
    
    var uuidToPriority: [ScheduleModel.UniqueID: RYScheduleMaping.Priority] {
        set { fact.uuidToPriority = newValue }
        get { fact.uuidToPriority }
    }
    
    var requestCallBack: ((RYScheduleViewController) -> ())?
    
    var nextRequestPriorities: Set<RYScheduleMaping.Priority> = [.mainly, .custom, .others]
    
    let heightForHeaderView: CGFloat = 64

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ry(light: "#FFFFFF", dark: "#1D1D1D")
        
        view.addSubview(headerView)
        view.addSubview(collectionView)
        
        fact.viewController = self
        fact.handle(headerView: headerView)
        fact.request(priorities: nextRequestPriorities) { theFact in
            theFact.scrollToNowWeek()
            self.requestCallBack?(self)
        }
    }
    
    lazy var headerView: RYScheduleHeaderView = {
        let headerView = RYScheduleHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: heightForHeaderView))
        return headerView
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = fact.createCollectionView()
        collectionView.frame = CGRect(x: 0, y: heightForHeaderView, width: view.bounds.width, height: view.bounds.height - heightForHeaderView)
        collectionView.contentInset.bottom = tabBarController?.tabBar.bounds.height ?? 0
        collectionView.backgroundColor = view.backgroundColor
        return collectionView
    }()
}
