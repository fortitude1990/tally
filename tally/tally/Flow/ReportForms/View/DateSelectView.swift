//
//  DateSelectView.swift
//  tally
//
//  Created by zykj on 2019/6/6.
//  Copyright © 2019 李志敬. All rights reserved.
//

import UIKit

class DateSelectView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    init() {
        super.init(frame: CGRect.zero)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    //MARK: - SetupUI
    
    private func setupUI() -> Void {
        
        self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        let contentView: UIView = UIView.init()
        contentView.backgroundColor = UIColor.white
        self.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(200)
        }
        
        let items = ["月账单", "年账单"]
        let segment: UISegmentedControl = UISegmentedControl.init(items: items)
        segment.selectedSegmentIndex = 0
        segment.tintColor = UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
        segment.addTarget(self, action: #selector(segmentBtnAction(aSegment:)), for: UIControl.Event.valueChanged)
        contentView.addSubview(segment)
        segment.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.width.equalTo(200)
            make.height.equalTo(25)
            make.top.equalTo(20)
        }
        
    }
    
    @objc private func segmentBtnAction(aSegment: UISegmentedControl){
        
    }
    
}
