//
//  RYAgreementView.swift
//  RYBaseKit
//
//  Created by SSR on 2023/10/23.
//

import UIKit

// RYAgreementViewDelegate

public protocol RYAgreementViewDelegate: AnyObject {
    
    func agreementView(_ agreementView: RYAgreementView, shouldResponse control: UIControl) -> Bool
    
    func agreementView(_ agreementView: RYAgreementView, willToggle control: UIControl)
    
    func agreementView(_ agreementView: RYAgreementView, didToggle control: UIControl)
    
    func agreementView(_ agreementView: RYAgreementView, interactWith URL: URL, interaction: UITextItemInteraction)
    
}

public extension RYAgreementViewDelegate {
    
    func agreementView(_ agreementView: RYAgreementView, shouldResponse control: UIControl) -> Bool { true }
    
    func agreementView(_ agreementView: RYAgreementView, willToggle control: UIControl) { }
    
    func agreementView(_ agreementView: RYAgreementView, didToggle control: UIControl) { }
}

// RYAgreementView

open class RYAgreementView: UIView {
    
    public typealias CustomControlRecallAction = (UIControl) -> ()
    
    open var normalTipAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 14),
        .foregroundColor: UIColor.gray
    ]
    
    open var urlTipAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 14),
        .foregroundColor: UIColor.blue
    ]
    
    open var spacingBetweenControlAndTextView: CGFloat = 4

    open weak var delegate: RYAgreementViewDelegate?
    
    private var normalStateAction: CustomControlRecallAction?
    private var selectedStateAction: CustomControlRecallAction?
    
    public var isSelected: Bool { checkoutControl.isSelected }
    
    // init
    
    convenience public init() {
        self.init(frame: .zero)
        sizeToFit()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commitInit()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        commitInit()
    }
    
    func commitInit() {
        addSubview(checkoutControl)
        addSubview(textView)
        checkoutControl.addTarget(self, action: #selector(touchUpInside(checkoutControl:)), for: .touchUpInside)
        
        if checkoutControl === checkoutButton {
            commitCheckoutButtonAction()
        }
    }
    
    private func commitCheckoutButtonAction() {
        addNomalState { ryBtn in
            
            ryBtn.layer.sublayers?.forEach {
                $0.removeFromSuperlayer()
            }
            
        } selectedAction: { ryBtn in
            
            let length = ryBtn.frame.width
            let duration = 0.25
            let insert = 0.15
            
            let path = UIBezierPath()
            path.move(to: CGPoint(x: length * insert, y: length * 0.50))
            path.addLine(to: CGPoint(x: length * 0.43, y: length * (1 - insert)))
            path.addLine(to: CGPoint(x: length * (1 - insert), y: length * insert))

            let strokeAnimation = CABasicAnimation(keyPath: "strokeEnd")
            strokeAnimation.fillMode = .forwards
            strokeAnimation.duration = duration
            strokeAnimation.fromValue = 0
            strokeAnimation.toValue = 1
            strokeAnimation.isRemovedOnCompletion = false
            strokeAnimation.beginTime = CACurrentMediaTime()
            
            let layer = CAShapeLayer()
            layer.path = path.cgPath
            layer.fillColor = UIColor.clear.cgColor
            layer.strokeColor = UIColor.systemGray.cgColor
            layer.lineWidth = 2
            layer.lineCap = .round
            layer.lineJoin = .round
            layer.strokeEnd = 0
            
            layer.add(strokeAnimation, forKey: "animation")
            ryBtn.layer.addSublayer(layer)
        }
    }
    
    // layout
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        textView.frame.origin.x = checkoutControl.frame.maxX + spacingBetweenControlAndTextView
        textView.frame.size.width = superview?.bounds.width ?? 300
        textView.sizeToFit()
        
        return CGSize(width: textView.frame.maxX, height: textView.bounds.height)
    }
    
    // lazy
    
    private lazy var checkoutButton: UIControl = {
        let sideLength = bounds.height
        let btn = UIControl()
        btn.frame.size = CGSize(width: sideLength, height: sideLength)
        btn.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        btn.backgroundColor = .clear
        btn.layer.cornerRadius = 3
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.systemGray.cgColor
        return btn
    }()
    
    public private(set) lazy var textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.isSelectable = true
        textView.showsVerticalScrollIndicator = false
        textView.showsHorizontalScrollIndicator = false
        textView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return textView
    }()
    
    // action
    
    open func toggleControl() {
        touchUpInside(checkoutControl: checkoutControl)
    }
    
    @objc private
    func touchUpInside(checkoutControl: UIControl) {
        if delegate?.agreementView(self, shouldResponse: checkoutControl) == false { return }
        delegate?.agreementView(self, willToggle: checkoutControl)
        checkoutControl.isSelected.toggle()
        setupControl()
        delegate?.agreementView(self, didToggle: checkoutControl)
    }
}

// useable / setable

extension RYAgreementView {
    
    func setupControl() {
        if checkoutControl.isSelected {
            selectedStateAction?(checkoutControl)
        } else {
            normalStateAction?(checkoutControl)
        }
    }
    
    public func addNomalState(_ normalAction: CustomControlRecallAction?, selectedAction: CustomControlRecallAction?) {
        normalStateAction = normalAction
        selectedStateAction = selectedAction
        setupControl()
    }
    
    public func add(normalTip: String) {
        let str = NSMutableAttributedString(attributedString: textView.attributedText)
        str.append(NSAttributedString(string: normalTip, attributes: normalTipAttributes))
        textView.attributedText = str
    }
    
    public func add(urlTip: String, url: URL?) {
        let str = NSMutableAttributedString(attributedString: textView.attributedText)
        var attributes = urlTipAttributes
        attributes[.link] = url
        str.append(NSAttributedString(string: urlTip, attributes: attributes))
        textView.attributedText = str
    }
}

// override those following method to customize

extension RYAgreementView {
    
    @objc
    open var checkoutControl: UIControl {
        checkoutButton
    }
}

// UITextViewDelegate

extension RYAgreementView: UITextViewDelegate {
    
    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        delegate?.agreementView(self, interactWith: URL, interaction: interaction)
        return false
    }
}
