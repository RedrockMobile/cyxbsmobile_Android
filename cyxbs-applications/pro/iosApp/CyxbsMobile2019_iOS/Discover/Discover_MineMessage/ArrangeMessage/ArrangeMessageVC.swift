//
//  ArrangeMessageVC.swift
//  CyxbsMobile2019_iOS
//
//  Created by coin on 2023/10/7.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit
import JXSegmentedView

class ArrangeMessageVC: UIViewController {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(segmentedView)
        view.addSubview(partingLine)
        addShadow()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        segmentedView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 38)
        listContainerView.frame = CGRect(x: 0, y: segmentedView.bottom, width: SCREEN_WIDTH, height: view.bottom - segmentedView.bottom)
        partingLine.frame = CGRect(x: SCREEN_WIDTH / 2, y: 8, width: 1, height: 22)

        let maskPath = UIBezierPath(roundedRect: segmentedView.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 16, height: 16))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        segmentedView.layer.mask = maskLayer
    }
    
    // MARK: - Method
    
    private func addShadow() {
        let gradientView = UIView(frame: CGRect(x: 0, y: 23, width: SCREEN_WIDTH, height: 21))
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = gradientView.bounds
        gradientLayer.colors = [UIColor(light: UIColor(hexString: "#EBF0F5", alpha: 1), dark: .black).cgColor, UIColor(light: UIColor(hexString: "#EBF0F5", alpha: 0), dark: .black).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientView.layer.addSublayer(gradientLayer)
        view.insertSubview(gradientView, belowSubview: segmentedView)
        view.insertSubview(listContainerView, belowSubview: gradientView)
    }

    // MARK: - Lazy
    
    private lazy var segmentedView: JXSegmentedView = {
        let segmentedView = JXSegmentedView()
        segmentedView.dataSource = segmentedDataSource
        segmentedView.listContainer = listContainerView
        segmentedView.defaultSelectedIndex = 0
        segmentedView.backgroundColor = UIColor(light: UIColor(hexString: "#FCFCFD", alpha: 1), dark: UIColor(hexString: "#1D1D1D", alpha: 1))
//        segmentedView.backgroundColor = UIColor(hexString: "#FCFCFD", alpha: 1)
        return segmentedView
    }()

    private lazy var segmentedDataSource: JXSegmentedTitleDataSource = {
        let segmentedDataSource = JXSegmentedTitleDataSource()
        segmentedDataSource.titles = ["接收", "发送"]
        segmentedDataSource.titleNormalFont = .systemFont(ofSize: 16)
        segmentedDataSource.titleSelectedColor = UIColor(.dm, light: UIColor(hexString: "#15C6E7", alpha: 1), dark: UIColor(hexString: "#15C6E7", alpha: 1))
        segmentedDataSource.titleNormalColor = UIColor(.dm, light: UIColor(hexString: "#A1ABBA", alpha: 1), dark: UIColor(hexString: "#A1ABBA", alpha: 1))
        segmentedDataSource.itemWidth = SCREEN_WIDTH / 2
        segmentedDataSource.itemSpacing = 0
        
        return segmentedDataSource
    }()

    private lazy var listContainerView: JXSegmentedListContainerView = {
        let listContainerView = JXSegmentedListContainerView(dataSource: self)
        listContainerView.scrollView.isScrollEnabled = false
        return listContainerView
    }()
    
    private lazy var partingLine: UIView = {
        let partingLine = UIView()
        partingLine.backgroundColor = UIColor(hexString: "#E8F0FC", alpha: 1)
        return partingLine
    }()
}

// MARK: - JXSegmentedListContainerViewDataSource

extension ArrangeMessageVC: JXSegmentedListContainerViewDataSource {

    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        return segmentedDataSource.titles.count
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        return index == 0 ? ReceiveMessageVC() : SendMessageVC()
    }
}
