//
//  RYCarnieHeaderView.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/10/7.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit
import SDWebImage

class RYCarnieHeaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .ry(light: "#FFFFFFF5", dark: "#1D1D1DF5")
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor.ry(light: "#FFFFFF", dark: "#1D1D1D").cgColor
        layer.shadowColor = UIColor.hex("#2E5998").cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = .zero
        clipsToBounds = true
        addSubview(headImgView)
        addSubview(nameLab)
        addSubview(detLab)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var headImgView: UIImageView = {
        let space: CGFloat = 17
        let imgView = UIImageView(frame: CGRect(x: space, y: space, width: 0, height: bounds.height - 2 * space))
        imgView.frame.size.width = imgView.bounds.height
        imgView.layer.cornerRadius = imgView.bounds.height / 2
        imgView.clipsToBounds = true
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    lazy var nameLab: UILabel = {
        let lab = UILabel()
        lab.frame.origin = CGPoint(x: headImgView.frame.maxX + 17, y: headImgView.frame.minY)
        lab.font = .systemFont(ofSize: 14, weight: .medium)
        lab.textColor = .ry(light: "#15315B", dark: "#F0F0F2")
        lab.text = "你好鸭(>^ω^<)"
        lab.sizeToFit()
        return lab
    }()
    
    lazy var detLab: UILabel = {
        let lab = UILabel()
        lab.frame.origin = CGPoint(x: nameLab.frame.minX, y: nameLab.frame.maxY + 2)
        lab.attributedText = createNormal("欢迎来到邮乐场")
        lab.sizeToFit()
        return lab
    }()
}

// MARK: data

extension RYCarnieHeaderView {
    
    func update(imgURL: String, title: String?, days: Int) {
        headImgView.sd_setImage(with: URL(string: imgURL), placeholderImage: UIImage(named: "header_default"))
        nameLab.text = title
        nameLab.sizeToFit()
        detLab.attributedText = create(days: days)
        detLab.sizeToFit()
    }
    
    func create(days: Int) -> NSAttributedString {
        let days = max(0, days)
        let str = NSMutableAttributedString(attributedString: createNormal("这是你来到邮乐场的第"))
        str.append(createHightlight("\(days)"))
        str.append(createNormal("天"))
        return str
    }
    
    func createNormal(_ str: String) -> NSAttributedString {
        NSAttributedString(string: str, attributes: [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.ry(light: "#15315B", dark: "#F0F0F2")
        ])
    }
    
    func createHightlight(_ str: String) -> NSAttributedString {
        NSAttributedString(string: str, attributes: [
            .font: UIFont.systemFont(ofSize: 16),
            .foregroundColor: UIColor.hex("#4A44E4")
        ])
    }
}
