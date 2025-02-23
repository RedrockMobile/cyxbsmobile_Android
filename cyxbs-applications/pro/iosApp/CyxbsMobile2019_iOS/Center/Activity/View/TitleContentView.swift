//
//  TitleContentView.swift
//  CyxbsMobile2019_iOS
//
//  Created by 许晋嘉 on 2023/9/22.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

class TitleContentView: UIView {

    var titleLabel: UILabel!
    var contentLabel: UILabel!

    var spacing: CGFloat = 10.0 {
        didSet {
            setNeedsLayout()
        }
    }

    var title: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.text = newValue
            setNeedsLayout()
        }
    }

    var content: String? {
        get {
            return contentLabel.text
        }
        set {
            contentLabel.text = newValue
            setNeedsLayout()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }

    private func setupSubviews() {
        titleLabel = UILabel()
        titleLabel.numberOfLines = 1 // Display in a single line
        titleLabel.setContentCompressionResistancePriority(.required, for: .horizontal) // Required horizontal compression resistance
        titleLabel.textColor = UIColor(hexString: "#15315B", alpha: 0.4)
        titleLabel.font = UIFont(name: PingFangSCMedium, size: 14)
        addSubview(titleLabel)

        contentLabel = UILabel()
        contentLabel.numberOfLines = 1 // Display in a single line
        contentLabel.setContentCompressionResistancePriority(.required, for: .horizontal) // Required horizontal compression resistance
        contentLabel.textColor = UIColor(hexString: "#15315B", alpha: 0.6)
        contentLabel.font = UIFont(name: PingFangSCMedium, size: 14)
        addSubview(contentLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let availableWidth = bounds.width
        let totalHeight = bounds.height

        // Calculate the intrinsic content sizes
        let titleIntrinsicSize = titleLabel.intrinsicContentSize
        let contentIntrinsicSize = contentLabel.intrinsicContentSize

        // Calculate the x position for content label
        let contentX = titleIntrinsicSize.width + 10

        // Set frames for both labels
        titleLabel.frame = CGRect(x: 0, y: 0, width: titleIntrinsicSize.width, height: totalHeight)
        contentLabel.frame = CGRect(x: contentX, y: 0, width: contentIntrinsicSize.width, height: totalHeight)
    }
}

