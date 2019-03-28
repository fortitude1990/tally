//
//  HeaderRefreshComponent.swift
//  tally
//
//  Created by 李志敬 on 2019/3/27.
//  Copyright © 2019 李志敬. All rights reserved.
//

import UIKit

class HeaderRefreshComponent: RefreshComponent {

    var handler: (()->Void)?
    var isRefresh: Bool = false
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public convenience init(handler:@escaping(()->Void)){
        self.init(frame: CGRect.zero)
        self.handler = handler
        self.showView = setupUI()
        self.addSubview(self.showView ?? UIView.init())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupUI
    
    @discardableResult func setupUI() -> UIView {
        let label: UILabel = UILabel.init()
        label.textAlignment = NSTextAlignment.center
        label.text = "松开查看下月数据"
        label.textColor = UIColor.init(red: 61 / 255.0, green: 61 / 255.0, blue: 61 / 255.0, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 14)
        label.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 50)
        return label
    }
    
    
    // MARK: - Methods
    
    override func didMoveToSuperview() {
        self.addObserver()
    }
    
    
    // MARK: - Observe
    
    override func observeValue() {
        
        self.frame = CGRect.init(x: 0, y: -(self.showView?.frame.height ?? 0.00), width: self.showView?.frame.width ?? 0, height: self.showView?.frame.height ?? 0)
        
        let offset = self.scrollView?.contentOffset.y ?? 0.00

        
        let thresholdValue = -(self.showView?.frame.height ?? 0.00)
        let negativeThresholdValue =  -((self.showView?.frame.height ?? 0.00) / 2.0)
        
        if offset <= thresholdValue && (self.scrollView?.isDragging ?? false){
            self.isRefresh = true
        }
        
        if offset > negativeThresholdValue  && self.isRefresh == true{
            
            self.isRefresh = false
            if self.handler != nil{
                self.handler!()
            }
            
        }
        
        
    }
    
    // MARK: - Deinit
    
    deinit {
        self.removeObserver()
    }

}
