//
//  BillingDetailsViewController.swift
//  tally
//
//  Created by 李志敬 on 2019/3/21.
//  Copyright © 2019 李志敬. All rights reserved.
//

import UIKit

class BillingDetailsViewController: UIViewController, AddViewControllerDelegate {

     // MARK: - Property
    
    var dateLabel: UILabel?
    var imageView: UIImageView?
    var titleLabel: UILabel?
    var amountLabel: UILabel?
    var remarkTV: UITextView?
    var imageBackView: UIView?
    var delHandler: ((TallyList)->Void)?
    var editHandler: ((String)->Void)?

    var _tallyModel: TallyList?
    var tallyModel: TallyList{
        set{
            _tallyModel = newValue
        }
        get{
            return _tallyModel ?? TallyList.init()
        }
    }
    
     // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    

     // MARK: - SetupUI
    
    func setupUI() -> Void {
        
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(CustomNavigationBar.getInstance(title: "详情", leftBtn: {
            self.navigationController?.popViewController(animated: true)
        }))
        
        let dateLabel: UILabel = UILabel.init()
        dateLabel.text = "2019年03月28日 星期四"
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        dateLabel.textColor = UIColor.init(red: 160 / 255.0, green: 160 / 255.0, blue: 160 / 255.0, alpha: 1.0)
        self.view.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(kNavigationHeight + 15)
            make.right.equalTo(-15)
            make.height.equalTo(20)
        }
        self.dateLabel = dateLabel
        
        
        let imageBackView_Width: CGFloat =  50
        let imageBackView: UIView = UIView.init()
        imageBackView.backgroundColor = themeColor
        imageBackView.layer.cornerRadius = imageBackView_Width / 2.0
        imageBackView.clipsToBounds = true
        self.view.addSubview(imageBackView)
        imageBackView.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(dateLabel.snp.bottom).offset(15)
            make.width.height.equalTo(imageBackView_Width)
        }
        self.imageBackView = imageBackView
        
        let photoView: UIImageView = UIImageView.init()
        photoView.image = UIImage.init(named: "餐饮high")
        imageBackView.addSubview(photoView)
        photoView.snp.makeConstraints { (make) in
            make.left.top.equalTo(5)
            make.bottom.right.equalTo(-5)
        }
        self.imageView = photoView

        
        let titleLabel: UILabel = UILabel.init()
        titleLabel.text = "支付"
        titleLabel.textColor = UIColor.init(red: 30 / 255.0, green: 30 / 255.0, blue: 30 / 255.0, alpha: 1.0)
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.light)
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(imageBackView.snp.right).offset(15)
            make.height.equalTo(30)
            make.width.equalTo(60)
            make.centerY.equalTo(imageBackView)
        }
        self.titleLabel = titleLabel
        
        let amountLabel: UILabel = UILabel.init()
        amountLabel.text = "13.00"
        amountLabel.font = UIFont.init(name: "PingFangSC-Regular", size: 18)
        amountLabel.textAlignment = NSTextAlignment.right
        self.view.addSubview(amountLabel)
        amountLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.right).offset(10)
            make.right.equalTo(-15)
            make.height.equalTo(30)
            make.centerY.equalTo(imageBackView)
        }
        self.amountLabel = amountLabel
        
        
        let line = UIView.init()
        line.backgroundColor = UIColor.init(red: 237 / 255.0, green: 237 / 255.0, blue: 237 / 255.0, alpha: 1)
        self.view.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(imageBackView.snp.bottom).offset(15)
            make.height.equalTo(0.5)
        }
        
        let remarkTV = UITextView.init()
        remarkTV.isEditable = false
        remarkTV.font = UIFont.systemFont(ofSize: 14)
        remarkTV.textColor = UIColor.init(red: 120 / 255.0, green: 120 / 255.0, blue: 120 / 255.0, alpha: 1.0)
        self.view.addSubview(remarkTV)
        self.remarkTV = remarkTV
        
        let bottom: BillingDetails_BottomView = BillingDetails_BottomView.init()
        self.view.addSubview(bottom)
        
        
        bottom.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(48 + kBottomSafeAreaHeight)
        }
        remarkTV.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(line.snp.bottom).offset(15)
            make.bottom.equalTo(bottom.snp.top)
        }
        
        
        bottom.delBtn {
            self.delHandler?(self.tallyModel)
            self.navigationController?.popViewController(animated: true)
        }
        
        bottom.editBtn {
            
            let addVC: AddViewController = AddViewController.init()
            addVC.delegate = self
            let addNavC: UINavigationController = UINavigationController.init(rootViewController: addVC)
            addVC.tallyModel = TallyModel.init(tallList: self.tallyModel)
            addNavC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            self.present(addNavC, animated: true, completion: {
                
            })
            
        }
        
    }
    
     // MARK: - LoadData
    
    func loadData() -> Void {
        
        let imageName: String = (_tallyModel?.consumeType ?? "餐饮").appending("high")
        self.imageView?.image = UIImage.init(named: imageName)
        self.titleLabel?.text = _tallyModel?.consumeType
        self.dateLabel?.text = String(format: "%@ %@", CalendarHelper.dateString(date: _tallyModel?.date ?? "00000000", originFromat: "yyyyMMdd", resultFromat: "yyyy年MM月dd日"), CalendarHelper.weekDay(dateString: _tallyModel?.date ?? "20190103" , format:"yyyyMMdd"))
        self.remarkTV?.text = _tallyModel?.remark
        
        if _tallyModel?.tallyType == 1{
            self.amountLabel?.text = "-".appending(_tallyModel?.amount ?? "0.00")
            self.imageBackView?.backgroundColor = themeColor
        }else{
            self.amountLabel?.text = _tallyModel?.amount ?? "0.00"
            let highColor2: UIColor = UIColor.init(red: 0, green: 179 / 255.0, blue: 125 / 255.0, alpha: 1.0)
            self.imageBackView?.backgroundColor = highColor2
        }
        
    }
    
    func del(handler:@escaping ((TallyList)->Void)) -> Void {
        self.delHandler = handler
    }
    
    func edit(handler:@escaping ((String)->Void)) -> Void {
        self.editHandler = handler
    }
    
     // MARK: - AddViewControllerDelegate
    
    func addComplete(tally: TallyModel) {
        
        DispatchQueue.main.async {
            
            let aTally: TallyList = TallyList.init(tally: tally)
            aTally.id = self.tallyModel.id
            
            let sql: SqlManager = SqlManager.shareInstance
            let result = sql.tallylist_update(tally: aTally)
            
            if result{
                let result1 = sql.summary_update(tally: self.tallyModel, type: SqlManager.SummaryType.reduce)
                let result2 = sql.summary_update(tally: aTally, type: SqlManager.SummaryType.add)
                if result1 && result2{
                    let date: String = CalendarHelper.dateString(date: tally.date ?? "", originFromat: "yyyyMMdd", resultFromat: "yyyyMM")
                    self.tallyModel = aTally
                    self.loadData()
                    self.editHandler?(date)
                }
            }else{
                print("list数据插入失败")
            }
            
            
            
            
            
            
        }
        
        
        
    }
    
}
