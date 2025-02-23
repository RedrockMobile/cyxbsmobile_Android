//
//  JustifiedLabel.swift
//  CyxbsMobile2019_iOS
//
//  Created by 许晋嘉 on 2023/9/22.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

class JustifiedLabel: UILabel {

    override var text: String? {
        didSet {
            updateAlignment()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateAlignment()
    }

    private func updateAlignment() {
        guard let labelText = text else {
            return
        }

        let targetWidth = frame.width

        // Get the current text size attributes
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font as Any
        ]

        // Calculate the actual size of the text
        let textSize = (labelText as NSString).size(withAttributes: attributes)

        // Calculate the required additional spacing to justify the text
        let additionalSpacing = (targetWidth - textSize.width) / CGFloat(labelText.count - 1)

        // Create the attributed string with adjusted kerning
        let attributedString = NSMutableAttributedString(string: labelText)
        attributedString.addAttribute(.kern, value: additionalSpacing, range: NSRange(location: 0, length: labelText.count - 1))

        self.attributedText = attributedString
    }
}


