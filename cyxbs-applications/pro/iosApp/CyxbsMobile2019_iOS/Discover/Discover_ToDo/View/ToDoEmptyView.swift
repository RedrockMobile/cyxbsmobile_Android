//
//  ToDoEmptyView.swift
//  CyxbsMobile2019_iOS
//
//  Created by coin on 2024/8/24.
//  Copyright © 2024 Redrock. All rights reserved.
//

import UIKit

// todo为空视图
class ToDoEmptyView: UIView {

    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        addSubview(imageView)
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: (self.width - 150.55) / 2, y: 169, width: 150.55, height: 110)
        label.frame = CGRect(x: 0, y: imageView.bottom + 16, width: self.width, height: 17)
    }
    
    // MARK: - Lazy
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "待办图")
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "还没有待做事项哦，快去添加吧！"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(.dm, light: UIColor(hexString: "#112C54", alpha: 1), dark: UIColor(hexString: "#DFDFE3", alpha: 1))
        return label
    }()
}
