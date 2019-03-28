//
//  BillingDetails_BottomView.swift
//  tally
//
//  Created by 李志敬 on 2019/3/28.
//  Copyright © 2019 李志敬. All rights reserved.
//

import UIKit

class BillingDetails_BottomView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var editHandler: (()->Void)?
    var delHandler: (()->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() -> Void {
        
        let line = UIView.init()
        line.backgroundColor = UIColor.init(red: 160 / 255.0, green: 160 / 255.0, blue: 160 / 255.0, alpha: 1)
        self.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(0.5)
        }
        
        let backView: UIView = UIView.init()
        self.addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(-kBottomSafeAreaHeight)
            make.top.equalTo(line.snp.bottom)
        }
        
        let division = UIView.init()
        division.backgroundColor = UIColor.init(red: 160 / 255.0, green: 160 / 255.0, blue: 160 / 255.0, alpha: 1)
        backView.addSubview(division)
        division.snp.makeConstraints { (make) in
           make.height.equalTo(10)
           make.width.equalTo(0.5)
           make.centerX.centerY.equalTo(backView)
        }
        
        let editBtn: UIButton = UIButton.init(type: UIButton.ButtonType.system)
        editBtn.tintColor = UIColor.init(red: 80 / 255.0, green: 80 / 255.0, blue: 80 / 255.0, alpha: 1)
        editBtn.setTitle("编辑", for: UIControl.State.normal)
        editBtn.addTarget(self, action: #selector(editBtnAction(aBtn:)), for: UIControl.Event.touchUpInside)
        editBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.light)
        backView.addSubview(editBtn)
        
        let delBtn: UIButton = UIButton.init(type: UIButton.ButtonType.system)
        delBtn.tintColor = UIColor.init(red: 80 / 255.0, green: 80 / 255.0, blue: 80 / 255.0, alpha: 1)
        delBtn.setTitle("删除", for: UIControl.State.normal)
        delBtn.addTarget(self, action: #selector(delBtnAction(aBtn:)), for: UIControl.Event.touchUpInside)
        delBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.light)
        backView.addSubview(delBtn)
        
        let margin = 10
        editBtn.snp.makeConstraints { (make) in
            make.left.equalTo(margin)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.right.equalTo(delBtn.snp.left).offset(-margin)
        }
        delBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-margin)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.width.equalTo(editBtn.snp.width)
        }
    }
    
    @objc func editBtnAction(aBtn: UIButton) -> Void {
        self.editHandler?()
    }
    
    @objc func delBtnAction(aBtn: UIButton) -> Void{
        self.delHandler?()
    }
    
    func editBtn(handler:@escaping (()->Void)) -> Void {
        self.editHandler = handler
    }
    
    func delBtn(handler:@escaping (()->Void)) -> Void {
        self.delHandler = handler
    }

}
