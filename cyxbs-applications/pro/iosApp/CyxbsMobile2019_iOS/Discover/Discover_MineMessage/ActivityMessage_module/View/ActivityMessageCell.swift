//
//  ActivityMessageCell.swift
//  CyxbsMobile2019_iOS
//
//  Created by 许晋嘉 on 2023/11/8.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

class ActivityMessageCell: UITableViewCell {
    
    var isClicked: Bool = false {
        didSet {
            if(isClicked) {
                dot.removeFromSuperview()
            }
        }
    }
    private var dot: UIView = DotView(frame: CGRect(x: 16, y: 28, width: 6, height: 6))
    
    lazy var messageTypeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor(light: UIColor(hexString: "#15315B"), dark: UIColor(hexString: "#F0F0F2"))
        label.font = UIFont(name: PingFangSCMedium, size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont(name: PingFangSCMedium, size: 11)
        label.textColor = UIColor(red: 0.082, green: 0.192, blue: 0.357, alpha: 0.4)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var firstLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(light: UIColor(hexString: "#15315B", alpha: 0.8), dark: UIColor(hexString: "#F0F0F2", alpha: 0.8))
        view.font = UIFont.systemFont(ofSize: 14)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var secondLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(light: UIColor(hexString: "#15315B", alpha: 0.8), dark: UIColor(hexString: "#F0F0F2", alpha: 0.8))
        view.font = UIFont.systemFont(ofSize: 14)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var statusView: UIImageView = {
        let imgView = UIImageView()
        imgView.size = CGSize(width: 52, height: 21)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    lazy var viewDetails: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#6E69E9", alpha: 0.8)
        label.font = UIFont.systemFont(ofSize: 10)
        label.text =  "查看活动详情"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var detailImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "Detail")
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dot.removeFromSuperview()
        messageTypeLabel.text = nil
        dateLabel.text = nil
        firstLabel.text = nil
        secondLabel.text = nil
        statusView.image = nil
        commonInit()
    }
    
    func commonInit() {
        contentView.backgroundColor = UIColor(light: UIColor(hexString: "#F8F9FC"), dark: .black)
        contentView.addSubview(messageTypeLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(firstLabel)
        contentView.addSubview(secondLabel)
        contentView.addSubview(statusView)
        contentView.addSubview(viewDetails)
        contentView.addSubview(detailImgView)
        contentView.addSubview(dot)
        setPosition()
    }
    
    func setPosition() {
        //titleLabel位置设定
        messageTypeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 31).isActive = true
        messageTypeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18).isActive = true
        messageTypeLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        //dayLabel位置设定
        dateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15).isActive = true
        dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 21).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: 62).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        //statusView位置设定
        statusView.leftAnchor.constraint(equalTo: messageTypeLabel.rightAnchor, constant: 8).isActive = true
        statusView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 19).isActive = true
        //firstLabel位置设定
        firstLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 31).isActive = true
        firstLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50).isActive = true
        let maxWidthConstraint1 = firstLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 200)
        maxWidthConstraint1.priority = .required
        maxWidthConstraint1.isActive = true
        //secondLabel位置设定
        secondLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 31).isActive = true
        secondLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 74).isActive = true
        let maxWidthConstraint2 = secondLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 200)
        maxWidthConstraint2.priority = .required
        maxWidthConstraint2.isActive = true
        //viewDetails位置设定
        viewDetails.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -24).isActive = true
        viewDetails.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -21).isActive = true
        viewDetails.widthAnchor.constraint(equalToConstant: 62).isActive = true
        viewDetails.heightAnchor.constraint(equalToConstant: 16).isActive = true
        //detailImgView位置设定
        detailImgView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15.79).isActive = true
        detailImgView.centerYAnchor.constraint(equalTo: viewDetails.centerYAnchor).isActive = true
        detailImgView.widthAnchor.constraint(equalToConstant: 5.8).isActive = true
        detailImgView.heightAnchor.constraint(equalToConstant: 5.8).isActive = true
    }
}

class DotView: UIView {
    var dotColor: UIColor = UIColor(hexString: "#FF6262") {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let circlePath = UIBezierPath(ovalIn: rect)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = dotColor.cgColor
        shapeLayer.lineWidth = 0  // 设置 lineWidth 为 0
        
        layer.addSublayer(shapeLayer)
    }
}
