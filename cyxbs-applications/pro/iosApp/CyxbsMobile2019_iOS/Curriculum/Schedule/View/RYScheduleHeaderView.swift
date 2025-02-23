//
//  RYScheduleHeaderView.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/9/18.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

class RYScheduleHeaderView: UIView {
    
    private(set) var section: Int = -1
    
    var isDoubleVision: Bool = false
    
    private let space: CGFloat = 16
    
    // MARK: action
    
    var titleTapAction: ((RYScheduleHeaderView) -> ())? = nil
    var backBtnAction: ((RYScheduleHeaderView) -> ())? = nil
    var doubleImgAction: ((RYScheduleHeaderView) -> ())? = nil

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(sectionLab)
        addSubview(backBtn)
        addSubview(doubleImgView)
        set(showBackBtn: true, animated: false)
        updateDoubleFrame()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: lazy
    
    lazy var sectionLab: UILabel = {
        let lab = UILabel()
        lab.frame.origin = CGPoint(x: 16, y: 16)
        lab.frame.size.height = 27
        let tap = UITapGestureRecognizer(target: self, action: #selector(titleResponseTap))
        lab.addGestureRecognizer(tap)
        lab.isUserInteractionEnabled = true
        return lab
    }()
    
    lazy var doubleImgView: UIImageView = {
        let imgView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: 32, height: 32)))
        imgView.image = doubleImage
        imgView.contentMode = .right
        imgView.autoresizingMask = [.flexibleLeftMargin]
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleResponseTap))
        imgView.addGestureRecognizer(tap)
        return imgView
    }()
    
    lazy var backBtn: UIButton = {
        let btn = UIButton(gradientLayerSize: CGSize(width: 84, height: 32), title: "回到本周")
        btn.center.y = sectionLab.center.y
        btn.autoresizingMask = [.flexibleLeftMargin]
        btn.addTarget(self, action: #selector(backDidTouchUpInside), for: .touchUpInside)
        return btn
    }()
}

extension RYScheduleHeaderView {
    
    @objc
    func titleResponseTap() {
        titleTapAction?(self)
    }
    
    @objc
    func backDidTouchUpInside() {
        backBtnAction?(self)
    }
    
    @objc
    func doubleResponseTap() {
        doubleImgAction?(self)
    }
}

// MARK: updateFrame

extension RYScheduleHeaderView {
    
    func set(showBackBtn: Bool, animated: Bool) {
        if !animated {
            setupFrame()
            return
        }
        UIView.animate(withDuration: 0.3) {
            setupFrame()
        }
        
        func setupFrame() {
            if showBackBtn {
                self.backBtn.frame.origin.x = self.bounds.width - self.backBtn.bounds.width - self.space
            } else {
                self.backBtn.frame.origin.x = self.bounds.width
            }
            updateDoubleFrame()
        }
    }
    
    func updateDoubleFrame() {
        doubleImgView.center.y = backBtn.center.y
        doubleImgView.frame.origin.x = backBtn.frame.minX - doubleImgView.bounds.width - space
    }
    
    var doubleImage: UIImage? {
        isDoubleVision ?
        UIImage(named: "curriculum.per.double")?.scaled(toHeight: 18) :
        UIImage(named: "curriculum.per.single")?.scaled(toHeight: 18)
    }
    
    func set(isDoubleVision: Bool, animated: Bool) {
        self.isDoubleVision = isDoubleVision
        if !animated {
            backBtn.setImage(doubleImage, for: .normal)
            return
        }
        UIView.transition(with: backBtn, duration: 0.3, options: .allowAnimatedContent) {
            self.backBtn.setImage(self.doubleImage, for: .normal)
        }
    }
}

// MARK: updateData

extension RYScheduleHeaderView {
    
    func updateData(section: Int, isNowSection: Bool) {
        let section = max(0, section)
        if self.section == section { return }
        
        let animationOptions: UIView.AnimationOptions =
        section > self.section ? .transitionFlipFromRight : .transitionFlipFromLeft
        self.section = section
        
        let title = ScheduleDataFetch.sectionString(withSection: section)
        let content = isNowSection ? "（本周）" : nil
        let sectionShow = create(title: title, content: content)
        
        UIView.transition(with: sectionLab, duration: 0.5, options: animationOptions) {
            self.sectionLab.attributedText = sectionShow
            self.sectionLab.sizeToFit()
        }
        set(showBackBtn: !isNowSection, animated: true)
    }
    
    func create(title: String, content: String?) -> NSAttributedString {
        let titleStr = NSAttributedString(string: title, attributes: [
            .font: UIFont.systemFont(ofSize: 22, weight: .semibold),
            .foregroundColor: UIColor.ry(light: "#112C54", dark: "#F0F0F2")
        ])
        let fullStr = NSMutableAttributedString(attributedString: titleStr)
        if let content {
            let contentStr = NSAttributedString(string: content, attributes: [
                .font: UIFont.systemFont(ofSize: 15, weight: .regular),
                .foregroundColor: UIColor.ry(light: "#112C54", dark: "#F0F0F2")
            ])
            fullStr.append(contentStr)
        } else {
            fullStr.append(NSAttributedString(string: " "))
        }
        
        let toImgAtt = NSTextAttachment()
        toImgAtt.image = UIImage(named: "direction_right")?
            .tint(.ry(light: "#112C54", dark: "#F0F0F2"), blendMode: .destinationIn)
            .scaled(toHeight: 12)
        toImgAtt.bounds.size = toImgAtt.image?.size ?? .zero
        let to = NSAttributedString(attachment: toImgAtt)
    
        fullStr.append(to)
        return fullStr
    }
}
