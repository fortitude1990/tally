//
//  Details_ListTableViewHeader.swift
//  tally
//
//  Created by 李志敬 on 2019/3/18.
//  Copyright © 2019 李志敬. All rights reserved.
//

import UIKit

class Details_ListTableViewHeader: UITableViewCell {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var oneLabel: UILabel?
    var twoLabel: UILabel?
    var _headerModel: TallyListHeaderModel?
    var headrModel: TallyListHeaderModel{
        set{
            _headerModel = newValue
            oneLabel?.text = _headerModel?.date
            twoLabel?.text = String(format: "支出：%@", _headerModel?.amount ?? "0.00")
        }
        get{
            return _headerModel ?? TallyListHeaderModel.init()
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() -> Void {
        
        self.oneLabel = UILabel.init()
        self.oneLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light)
        self.oneLabel?.textColor = UIColor.init(red: 167 / 255.0, green: 167 / 255.0, blue: 167 / 255.0, alpha: 1.0)
        self.oneLabel?.text = "03月08日 周一"
        self.addSubview(self.oneLabel ?? UILabel.init())
        self.oneLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(15)
            make.width.equalTo(150)
            make.height.equalTo(20)
            make.centerY.equalTo(self)
        })
        
        self.twoLabel = UILabel.init()
        self.twoLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light)
        self.twoLabel?.textColor = UIColor.init(red: 167 / 255.0, green: 167 / 255.0, blue: 167 / 255.0, alpha: 1.0)
        self.twoLabel?.text = "支出：155"
        self.twoLabel?.textAlignment = NSTextAlignment.right
        self.addSubview(self.twoLabel ?? UILabel.init())
        self.twoLabel?.snp.makeConstraints({ (make) in
            make.right.equalTo(-15)
            make.left.equalTo(self.oneLabel?.snp.right ?? 0)
            make.height.equalTo(20)
            make.centerY.equalTo(self)
        })
        
        let bottomLine: UIView = UIView.init()
        bottomLine.backgroundColor = UIColor.init(red: 237 / 255.0, green: 237 / 255.0, blue: 237 / 255.0, alpha: 1)
        self.addSubview(bottomLine)
        bottomLine.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(0.5)
            make.bottom.equalTo(0)
        }
        
        
    }
}
