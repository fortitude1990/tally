//
//  TodayView.swift
//  tally
//
//  Created by 李志敬 on 2019/3/13.
//  Copyright © 2019 李志敬. All rights reserved.
//

import UIKit

class TodayView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(frame: CGRect) -> Void {
        
        
        let view: UIView = UIView.init()
        self.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.width.equalTo(50)
            make.height.equalTo(20)
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
        }
        
        let aImageView: UIImageView = UIImageView.init(image: UIImage.init(named: "日历"))
        aImageView.isUserInteractionEnabled = true
        view.addSubview(aImageView)
        aImageView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.width.equalTo(15)
            make.height.equalTo(15)
            make.centerY.equalTo(view)
        }
        
        let titleLabel: UILabel = UILabel.init()
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "今日"
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.right.top.bottom.equalTo(0)
            make.left.equalTo(aImageView.snp.right)
        }
        
        
    }
    
    
}
