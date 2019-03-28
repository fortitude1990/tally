//
//  RefreshComponent.swift
//  tally
//
//  Created by 李志敬 on 2019/3/27.
//  Copyright © 2019 李志敬. All rights reserved.
//

import UIKit

class FooterRefreshComponent: UIView {

    open var scrollView: UIScrollView?
    let keyPath: String = "contentOffset"
    var handler: (()->Void)?
    var isRefresh: Bool = false
    var footerView: UIView?
     // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public convenience init(handler:@escaping(()->Void)){
        
        self.init(frame: CGRect.zero)
        self.handler = handler
        self.footerView = setupUI()
        self.addSubview(self.footerView ?? UIView.init())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     // MARK: - SetupUI
    
    @discardableResult func setupUI() -> UIView {
        let label: UILabel = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.text = "松开查看上月数据"
        label.textColor = UIColor.init(red: 61 / 255.0, green: 61 / 255.0, blue: 61 / 255.0, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 14)
        label.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 50)
        return label
    }
    
    
     // MARK: - Methods
    
    override func didMoveToSuperview() {
        addObserver()
    }
    
    func addObserver() -> Void {
        self.scrollView = self.superview as? UIScrollView
        self.scrollView?.addObserver(self, forKeyPath: keyPath, options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    func removeObserver() -> Void {
        self.scrollView?.removeObserver(self, forKeyPath: keyPath)
    }
    
     // MARK: - Observe
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == self.keyPath && !(self.scrollView?.isTracking ?? true){
            
            var originY: CGFloat = 0
            
            if (self.scrollView?.contentSize.height ?? 0.00) > (self.scrollView?.frame.height ?? 0.00){
                originY = self.scrollView?.contentSize.height ?? 0.00
            }else{
                originY = self.scrollView?.frame.height ?? 0.00
            }
            
            self.frame = CGRect.init(x: 0, y: originY, width: self.footerView?.frame.width ?? 0, height: self.footerView?.frame.height ?? 0)
            
            
            let offset = (self.scrollView?.contentOffset.y ?? 0.00) + (self.scrollView?.frame.height ?? 0.00)
            
            var consize = self.scrollView?.contentSize.height ?? 0.00
            if consize < (self.scrollView?.frame.height ?? 0.00){
                consize = self.scrollView?.frame.height ?? 0.00
            }
            
            let thresholdValue = consize + (self.footerView?.frame.height ?? 0.00) + 20
            let negativeThresholdValue = consize + ((self.footerView?.frame.height ?? 0.00) / 2.0)
            
            if offset >= thresholdValue{
                self.isRefresh = true
            }
        
            if offset < negativeThresholdValue  && self.isRefresh == true{
                
                self.isRefresh = false
                if self.handler != nil{
                    self.handler!()
                }
                
            }
            
        }
        
    }
    
     // MARK: - Deinit
    
    deinit {
        removeObserver()
    }
    
}
