//
//  ToDoTypeView.swift
//  CyxbsMobile2019_iOS
//
//  Created by coin on 2024/9/1.
//  Copyright © 2024 Redrock. All rights reserved.
//

import UIKit
import JXSegmentedView

class ToDoTypeView: UIView {

    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tableView)
        self.backgroundColor = UIColor(.dm, light: UIColor(hexString: "#FBFBFC", alpha: 1), dark: UIColor(hexString: "#1D1D1D", alpha: 1))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.frame = CGRect(x: 0, y: 0, width: self.width, height: self.height)
    }
    
    // MARK: - Lazy
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = 0
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(ToDoTopExpiredStyleCell.self, forCellReuseIdentifier: ToDoTopExpiredStyleCellReuseIdentifier)
        tableView.register(ToDoTopActiveStyleCell.self, forCellReuseIdentifier: ToDoTopActiveStyleCellReuseIdentifier)
        tableView.register(ToDoTopNoDeadlineStyleCell.self, forCellReuseIdentifier: ToDoTopNoDeadlineStyleCellReuseIdentifier)
        tableView.register(ToDoNonTopExpiredStyleCell.self, forCellReuseIdentifier: ToDoNonTopExpiredStyleCellReuseIdentifier)
        tableView.register(ToDoNonTopActiveStyleCell.self, forCellReuseIdentifier: ToDoNonTopActiveStyleCellReuseIdentifier)
        tableView.register(ToDoNonTopNoDeadlineStyleCell.self, forCellReuseIdentifier: ToDoNonTopNoDeadlineStyleCellReuseIdentifier)
        return tableView
    }()
}

// MARK: - JXSegmentedListContainerViewListDelegate

extension ToDoTypeView: JXSegmentedListContainerViewListDelegate {
    
    func listView() -> UIView {
        return self
    }
}
