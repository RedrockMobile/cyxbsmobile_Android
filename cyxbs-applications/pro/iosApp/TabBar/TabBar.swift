//
//  TabBar.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/9/3.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit

class TabBar: UITabBar {
    
    var cornerRadiusForUpper: CGFloat = 10

    var heightForMoreSpace: CGFloat = 58
    
    var bezierPathSetColor: UIColor = .black {
        didSet {
            line.backgroundColor = bezierPathSetColor
        }
    }
    
    var isHeaderViewHidden: Bool = false {
        didSet {
            headerView.isHidden = isHeaderViewHidden
            line.isHidden = isHeaderViewHidden
            sizeToFit()
        }
    }
    
    // MARK: init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.mask = shapeLayer
        addSubview(line)
        addSubview(headerView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: override (UIView)
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if isHeaderViewHidden {
            createNormalTopBezierPath.stroke()
        } else {
            createMoreTopBezierPath.stroke()
        }
        // 在这里执行绘制操作
        shapeLayer.frame = bounds
        shapeLayer.path = createBezierPath.cgPath
    }
    
    var originMaxHeight: CGFloat = 0
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        originMaxHeight = max(originMaxHeight, sizeThatFits.height)
        if !isHeaderViewHidden {
            sizeThatFits.height = originMaxHeight + heightForMoreSpace
        } else {
            sizeThatFits.height = originMaxHeight
        }
        return sizeThatFits
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for subview in subviews {
            if let tabBarButtonClass = NSClassFromString("UITabBarButton"),
                subview.isKind(of: tabBarButtonClass) {
                
                if !isHeaderViewHidden {
                    subview.frame.origin.y += heightForMoreSpace
                    subview.frame.size.height -= heightForMoreSpace
                }
                
                if let titleLabel = subview.subviews.last as? UILabel {
                    titleLabel.adjustsFontSizeToFitWidth = true
                }
            }
        }
        
        setNeedsDisplay() // 调用drawRect方法进行绘制
    }
    
    // MARK: Lazy
    
    lazy var headerView: TabBarHeaderView = {
        let headerView = TabBarHeaderView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: heightForMoreSpace))
        headerView.backgroundColor = .clear
        headerView.autoresizingMask = [.flexibleWidth]
        return headerView
    }()
    
    lazy var line: UIView = {
        let line = UIView()
        line.frame.size.width = bounds.width
        line.frame.size.height = 1
        line.frame.origin.y = heightForMoreSpace
        line.backgroundColor = bezierPathSetColor
        line.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        return line
    }()
    
    // MARK: CAShapeLayer
    
    lazy var shapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.frame = bounds
        layer.backgroundColor = UIColor.clear.cgColor
        layer.lineWidth = 1
        layer.path = createBezierPath.cgPath
        return layer
    }()
    
    // MARK: UIBezierPath

    var createBezierPath: UIBezierPath {
        let bezierPath = isHeaderViewHidden ? createNormalTopBezierPath : createMoreTopBezierPath
        bezierPath.append(createButtomBezierPath)
        return bezierPath
    }
    
    // / - - \
    var createMoreTopBezierPath: UIBezierPath {
        
        bezierPathSetColor.set()
        
        let bezierPath = UIBezierPath()
        bezierPath.lineWidth = 1
        bezierPath.lineCapStyle = .round
        bezierPath.lineJoinStyle = .round
        
        bezierPath.move(to: CGPoint(x: 0, y: cornerRadiusForUpper))     // left middle
        
        bezierPath.addArc(withCenter: CGPoint(x: cornerRadiusForUpper, y: cornerRadiusForUpper),
                          radius: cornerRadiusForUpper,
                          startAngle: .pi,
                          endAngle: -(.pi / 2),
                          clockwise: true) // left top
        
        bezierPath.addLine(to: CGPoint(x: cornerRadiusForUpper, y: 0)) // left top
        bezierPath.addLine(to: CGPoint(x: bounds.width - cornerRadiusForUpper, y: 0))  // right top
        
        bezierPath.addArc(withCenter: CGPoint(x: bounds.width - cornerRadiusForUpper, y:  cornerRadiusForUpper),
                          radius: cornerRadiusForUpper,
                          startAngle: -(.pi / 2),
                          endAngle: 0,
                          clockwise: true)    // right middle
        
        return bezierPath
    }
    
    // - - - -
    var createNormalTopBezierPath: UIBezierPath {
        
        bezierPathSetColor.set()
        
        let bezierPath = UIBezierPath()
        bezierPath.lineWidth = 1
        bezierPath.lineCapStyle = .round
        bezierPath.lineJoinStyle = .round
        
        bezierPath.move(to: CGPoint(x: 0, y: 0))     // left top
        bezierPath.addLine(to: CGPoint(x: bounds.width, y: 0))  // right top
        
        return bezierPath
    }
    
    // | _ _ |
    var createButtomBezierPath: UIBezierPath {
        
        let bezierPath = UIBezierPath()
        
        // left top
        if isHeaderViewHidden {
            bezierPath.move(to: CGPoint(x: 0, y: 0))
        } else {
            bezierPath.move(to: CGPoint(x: 0, y: cornerRadiusForUpper))
        }
        bezierPath.addLine(to: CGPoint(x: 0, y: bounds.size.height))    // left bottom
        bezierPath.addLine(to: CGPoint(x: bounds.size.width, y: bounds.size.height))    // right bottom
        
        // right top
        if isHeaderViewHidden {
            bezierPath.addLine(to: CGPoint(x: bounds.size.width, y: 0))
        } else {
            bezierPath.addLine(to: CGPoint(x: bounds.size.width, y: cornerRadiusForUpper))
        }
        
        return bezierPath
    }
}

extension UITabBar {
    var ryTabBar: TabBar? {
        self as? TabBar
    }
}
