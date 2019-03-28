//
//  RefreshComponent.swift
//  tally
//
//  Created by 李志敬 on 2019/3/27.
//  Copyright © 2019 李志敬. All rights reserved.
//

import UIKit

class RefreshComponent: UIView {

    open var scrollView: UIScrollView?
    let keyPath: String = "contentOffset"
    var showView: UIView?
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public convenience init(subView: UIView){
        self.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func addObserver() -> Void {
        self.scrollView = self.superview as? UIScrollView
        self.scrollView?.addObserver(self, forKeyPath: keyPath, options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    func removeObserver() -> Void {
        self.scrollView?.removeObserver(self, forKeyPath: keyPath)
    }
    
    func observeValue() -> Void {
        
    }
    
    // MARK: - Observe
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == self.keyPath  {
            self.observeValue()
        }
        
    }
    
    // MARK: - Deinit
    
    deinit {
        removeObserver()
    }
}
