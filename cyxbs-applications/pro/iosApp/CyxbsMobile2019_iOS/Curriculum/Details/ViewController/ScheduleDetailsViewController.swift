//
//  ScheduleDetailsViewController.swift
//  CyxbsMobile2019_iOS
//
//  Created by SSR on 2023/9/20.
//  Copyright © 2023 Redrock. All rights reserved.
//

import UIKit
import RYTransitioningDelegateSwift

class ScheduleDetailsViewController: UIViewController {
    
    let cals: [ScheduleCalModel]
    
    weak var delegate: ScheduleDetailCollectionViewCellDelegate?
    
    init(cals: [ScheduleCalModel]) {
        self.cals = cals
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        view.isUserInteractionEnabled = true
        view.frame.size.height = 268
        view.layer.cornerRadius = 16
        view.layer.shadowRadius = 16
        view.layer.shadowColor = UIColor(light: .lightGray, dark: .darkGray).cgColor
        view.layer.shadowOpacity = 0.7
        view.layer.shadowOffset = CGSize(width: 0, height: -2)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .ry(light: "#F2F3F8", dark: "#000000")
        view.addSubview(collectionView)
        view.addSubview(pageControl)
    }
    
    // MARK: lazy
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ScheduleDetailCollectionViewCell.self, forCellWithReuseIdentifier: ScheduleDetailCollectionViewCell.identifier)
        return collectionView
    }()
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: 10)))
        pageControl.frame.origin.y = 226
        pageControl.numberOfPages = cals.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .hex("#888888")
        pageControl.currentPageIndicatorTintColor = .hex("#788EFB")
        
        return pageControl
    }()
}

// MARK: UICollectionViewDataSource

extension ScheduleDetailsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScheduleDetailCollectionViewCell.identifier, for: indexPath) as! ScheduleDetailCollectionViewCell
        
        cell.cal = cals[indexPath.item]
        cell.delegate = delegate
        
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension ScheduleDetailsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.bounds.size
    }
}

// MARK: UICollectionViewDelegate

extension ScheduleDetailsViewController: UICollectionViewDelegate { }

// MARK: UIScrollViewDelegate

extension ScheduleDetailsViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
}
