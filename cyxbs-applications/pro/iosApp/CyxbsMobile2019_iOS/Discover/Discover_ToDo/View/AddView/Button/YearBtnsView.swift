//
//  YearBtnsView.swift
//  CyxbsMobile2019_iOS
//
//  Created by Max Xu on 2024/8/20.
//  Copyright © 2024 Redrock. All rights reserved.
//

import UIKit
import SnapKit

protocol YearBtnsViewDelegate: AnyObject {
    func yearBtnsView(_ view: YearBtnsView, didSelectedYear year: Int)
}

class YearBtnsView: UIView {
    
    private var selectedBtn: UIButton?
    private var selectedBackgroundColor: UIColor!
    private var unSelectedBackgroundColor: UIColor!
    private var scrollView: UIScrollView!
    private var scrollViewContentView: UIView!
    
    var delegate: YearBtnsViewDelegate? {
        didSet {
            if let delegate = delegate {
                delegate.yearBtnsView(self, didSelectedYear: selectedBtn?.tag ?? 0)
            }
        }
    }
    
    var selectedYear: Int {
        return selectedBtn?.tag ?? 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.selectedBackgroundColor = UIColor.dm_color(withLightColor: UIColor(hexString: "#ECF4FC", alpha: 1), darkColor: UIColor(hexString: "#212121", alpha: 1))
        self.unSelectedBackgroundColor = UIColor.dm_color(withLightColor: UIColor(hexString: "#F6F8FD", alpha: 1), darkColor: UIColor(hexString: "#313131", alpha: 1))
        addScrollView()
        addYearBtns()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 初始化UI
    private func addScrollView() {
        scrollView = UIScrollView()
        addSubview(scrollView)
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        scrollViewContentView = UIView()
        scrollView.addSubview(scrollViewContentView)
        
        scrollViewContentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
        }
    }
    
    private func addYearBtns() {
        let currentYear = Calendar.current.component(.year, from: Date())
        var anchor = scrollViewContentView.snp.left
        var offset: CGFloat = 0
        
        for i in 0..<4 {
            let btn = getStdYearBtn(year: currentYear + i)
            btn.snp.makeConstraints { make in
                make.top.bottom.equalTo(scrollViewContentView)
                make.left.equalTo(anchor).offset(offset)
            }
            anchor = btn.snp.right
            offset = 0.03466666667 * UIScreen.main.bounds.width
            
            if i == 0 {
                selectYear(btn: btn)
            }
        }
        
        scrollViewContentView.subviews.last?.snp.makeConstraints { make in
            make.right.equalTo(scrollViewContentView)
        }
    }
    
    private func getStdYearBtn(year: Int) -> UIButton {
        let btn = UIButton()
        scrollViewContentView.addSubview(btn)
        
        btn.setTitleColor(UIColor.dm_color(withLightColor: UIColor(hexString: "#15315B", alpha: 1), darkColor: UIColor(hexString: "#F0F0F2", alpha: 1)), for: .selected)
        btn.setTitleColor(UIColor.dm_color(withLightColor: UIColor(hexString: "#9CA9BC", alpha: 1), darkColor: UIColor(hexString: "#838385", alpha: 1)), for: .normal)
        
        btn.layer.cornerRadius = 0.01908866995 * UIScreen.main.bounds.height
        btn.tag = year
        btn.setTitle("\(year)", for: .normal)
        
        btn.backgroundColor = unSelectedBackgroundColor
        btn.isSelected = false
        
        btn.snp.makeConstraints { make in
            make.width.equalTo(0.09359605911 * UIScreen.main.bounds.height)
            make.height.equalTo(0.0381773399 * UIScreen.main.bounds.height)
        }
        
        btn.addTarget(self, action: #selector(selectYear(btn:)), for: .touchUpInside)
        return btn
    }
    
    @objc private func selectYear(btn: UIButton) {
        // 更新旧的按钮状态
        if let selectedBtn = self.selectedBtn {
            selectedBtn.backgroundColor = unSelectedBackgroundColor
            selectedBtn.isSelected = false
        }
        
        // 更新新的按钮状态
        selectedBtn = btn
        btn.backgroundColor = selectedBackgroundColor
        btn.isSelected = true
        delegate?.yearBtnsView(self, didSelectedYear: btn.tag)
    }
}

