//
//  RYCarnieEntryView.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/10/6.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

class RYCarnieEntryView: UIControl {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imgView)
        addSubview(titleLab)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var imgView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    lazy var titleLab: UILabel = {
        let lab = UILabel(frame: CGRect(x: 0, y: 0, width: 132, height: 43))
        lab.backgroundColor = .ry(light: "#FFFFFF", dark: "#1D1D1D")
        lab.textAlignment = .center
        lab.font = .systemFont(ofSize: 16, weight: .heavy)
        lab.textColor = .hex("#4A44E4")
        lab.layer.cornerRadius = lab.bounds.height / 2
        lab.layer.borderWidth = 2
        lab.layer.borderColor = UIColor.hex("#E6EDFD").cgColor
        lab.layer.shadowColor = UIColor.hex("#E6EDFD").cgColor
        lab.layer.shadowRadius = lab.layer.cornerRadius
        lab.layer.shadowOffset = .zero
        lab.layer.shadowOpacity = 0.6
        lab.layer.masksToBounds = true
        return lab
    }()
}

extension RYCarnieEntryView {
    
    var sapceForH: CGFloat { 24 }
    
    var sapceForV: CGFloat { 10 }
    
    func setupData(imgName: String, title: String?) {
        imgView.image = UIImage(named: imgName)
        titleLab.text = title
        titleLab.sizeToFit()
        titleLab.frame.size.width += 2 * sapceForH
        titleLab.frame.size.height += 2 * sapceForV
        titleLab.layer.cornerRadius = titleLab.bounds.height / 2
    }
}
