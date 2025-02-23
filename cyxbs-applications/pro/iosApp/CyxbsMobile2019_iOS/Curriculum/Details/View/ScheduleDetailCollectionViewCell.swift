//
//  ScheduleDetailCollectionViewCell.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/9/20.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

protocol ScheduleDetailCollectionViewCellDelegate: AnyObject {
    func collectionViewCell(_ collectionViewCell: ScheduleDetailCollectionViewCell, responseEditBtn: UIButton)
    func collectionViewCell(_ collectionViewCell: ScheduleDetailCollectionViewCell, responsePlaceTap: UITapGestureRecognizer)
}

class ScheduleDetailCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: ScheduleDetailCollectionViewCellDelegate?
    
    var cal: ScheduleCalModel? {
        didSet {
            guard let cal else { return }
            tableHeaderView.set(
                course: cal.curriculum.course,
                sno: "\(cal.stu?.name ?? "") \(cal.stu?.stunum ?? "")",
                place: cal.curriculum.classRoom,
                teacher: cal.curriculum.teacher)
            tableHeaderView.isEditBtnShow = (cal.customType == .custom)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(tableView)
        tableView.tableHeaderView = tableHeaderView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: contentView.bounds, style: .plain)
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
        tableView.contentInsetAdjustmentBehavior = .never;
        tableView.showsVerticalScrollIndicator = false;
        tableView.showsHorizontalScrollIndicator = false;
        tableView.separatorStyle = .none;
        tableView.bounces = false;
        tableView.register(ScheduleDetailMessageTableViewCell.self, forCellReuseIdentifier: ScheduleDetailMessageTableViewCell.identifier)
        return tableView
    }()
    
    lazy var tableHeaderView: ScheduleDetailTableHeaderView = {
        let headerView = ScheduleDetailTableHeaderView(frame: CGRect(origin: .zero, size: CGSizeMake(contentView.bounds.width, 110)))
        headerView.editBtnTapAction = { _, btn in
            self.delegate?.collectionViewCell(self, responseEditBtn: btn)
        }
        headerView.placeTapAction = { _, tap in
            self.delegate?.collectionViewCell(self, responsePlaceTap: tap)
        }
        return headerView
    }()
}

// MARK: UITableViewDataSource

extension ScheduleDetailCollectionViewCell: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleDetailMessageTableViewCell.identifier, for: indexPath) as! ScheduleDetailMessageTableViewCell
        
        guard let cal = cal else { return cell }
        
        switch indexPath.item {
            
        case 0:
            cell.set(leftTitle: "周期", rightTitle: "\(cal.curriculum.rawWeek ?? "") \(cal.curriculum.period.count)节连上")
            
        case 1:
            cell.set(leftTitle: "时间", rightTitle: "\(cal.inWeekStr ?? "") \(cal.time)")
            
        case 2:
            cell.set(leftTitle: "课程类型", rightTitle: "\(cal.curriculum.type)")
            
        default:
            break
        }
        
        return cell
    }
}

// MARK: UITableViewDelegate

extension ScheduleDetailCollectionViewCell: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        38
    }
}
