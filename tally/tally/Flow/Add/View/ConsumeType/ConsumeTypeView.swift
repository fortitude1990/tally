//
//  ConsumeTypeView.swift
//  tally
//
//  Created by 李志敬 on 2019/3/8.
//  Copyright © 2019 李志敬. All rights reserved.
//

import UIKit

@objc public protocol ConsumeTypeViewDelegate: NSObjectProtocol {
    func consumeTypeViewPanGesture(ges: UIPanGestureRecognizer)
}


class ConsumeTypeView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate{

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
     // MARK: - Property
    
    let identifier: String = "identifier"
    weak var delegate: ConsumeTypeViewDelegate?
    
     // MARK: - HitTest
    
     // MARK: - Touch
    
     // MARK: - Lazy
    
    lazy var pageIndicator: UIPageControl = {
        let pageControl: UIPageControl = UIPageControl.init()
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = UIColor.init(red: 57 / 255.0, green: 69 / 255.0, blue: 85 / 255.0, alpha: 1.0)
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        return pageControl
    }()
    
    
    
    lazy var collectionView: UICollectionView = {
        
        let layout: ConsumeTypeUICollectionViewFlowLayout = ConsumeTypeUICollectionViewFlowLayout.init()
        layout.itemSize = CGSize.init(width: 40, height: 60)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets.init(top: 5, left: 20, bottom: 5, right: 20)
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        
        let aCollectionView: UICollectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        aCollectionView.backgroundColor = UIColor.white
        aCollectionView.showsVerticalScrollIndicator = false
        aCollectionView.showsHorizontalScrollIndicator = false
        aCollectionView.delegate = self
        aCollectionView.dataSource = self
        aCollectionView.isPagingEnabled = true
        
        aCollectionView.register(ConsumeTypeCollectionViewCell.classForCoder()
            , forCellWithReuseIdentifier: self.identifier)
        
        return aCollectionView
    }()
    
    
    
     // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     // MARK: - SetupUI
    
    func setupUI(frame: CGRect) -> Void {
        
//        self.backgroundColor = UIColor.red
        
        self.addSubview(self.pageIndicator)
        self.pageIndicator.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(0)
            make.height.equalTo(10)
        }
        
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.bottom.equalTo(self.pageIndicator.snp_topMargin).offset(-10)
        }
        
        let panGes: UIPanGestureRecognizer = UIPanGestureRecognizer.init(target: self, action: #selector(panGestureAction(panGes:)))
        panGes.delegate = self
        self.addGestureRecognizer(panGes)
                
    }
    
     // MARK: - UIGestureRecognizerDelegate
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool{
        
        if gestureRecognizer.isKind(of: UIPanGestureRecognizer.classForCoder()) {
            let point: CGPoint = (gestureRecognizer as! UIPanGestureRecognizer).translation(in: self)
            if point.y / point.x > 1.5{
                return true
            }
        }
        
        return false
        
    }
    
     // MARK: - Methods
    
    @objc func panGestureAction(panGes: UIPanGestureRecognizer) -> Void {
        
        if let delegate = self.delegate {
            delegate.consumeTypeViewPanGesture(ges: panGes)
        }
    
    }
    
     // MARK: - UICollectionViewDelegate
    
     // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let items: Int = 16
        
        var pages: NSInteger?
        if items % 10 == 0 {
            pages = items / 10;
        }else{
            pages = items / 10 + 1
        }
        self.pageIndicator.numberOfPages = pages ?? 0
        
        return items
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.identifier, for: indexPath)
        return cell
        
    }
    
     // MARK: - UIScrollViewDelegate
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page: Int = Int(scrollView.contentOffset.x / CGFloat.init(kScreenWidth))
        self.pageIndicator.currentPage = page
    }
    
    
}
