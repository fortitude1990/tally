//
//  SelectDateView.swift
//  tally
//
//  Created by 李志敬 on 2019/3/13.
//  Copyright © 2019 李志敬. All rights reserved.
//

import UIKit

class SelectDateView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
     // MARK: - Lazy
    
     // MARK: - Property
  
    var todayView: TodayView?

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
        
        self.todayView = TodayView.init(frame: CGRect.init(x: 0, y: 0, width: frame.width, height: frame.height - 0.5))
        self.addSubview(self.todayView ?? UIView.init())
        
        let line: UIView = UIView.init(frame: CGRect.init(x: 0, y: frame.height - 0.5, width: frame.width, height: 0.5))
        line.backgroundColor = UIColor.init(red: 235/255.0, green: 235/255.0, blue: 235/255.0, alpha: 1.0)
        self.addSubview(line)
        
        
    }
    
}
