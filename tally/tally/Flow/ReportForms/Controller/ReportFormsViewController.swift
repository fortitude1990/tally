//
//  ReportFormsViewController.swift
//  tally
//
//  Created by zykj on 2019/5/15.
//  Copyright © 2019 李志敬. All rights reserved.
//

import UIKit

class ReportFormsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUI();
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - SetupUI
    
    private func setupUI() -> Void {
        
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isHidden = true
        
        let oneView = UIView.init()
        oneView.backgroundColor = themeColor
        self.view.addSubview(oneView)
        oneView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(0)
            make.height.equalTo(150)
        }
        
        let twoView = UIView.init()
        twoView.backgroundColor = UIColor.white
        twoView.layer.cornerRadius = 4
        twoView.layer.shadowOffset = CGSize.init(width: 0, height: 0)
        twoView.layer.shadowColor = UIColor.init(red: 215 / 255.0, green: 215 / 255.0, blue: 215 / 255.0, alpha: 1.0).cgColor
        twoView.layer.shadowOpacity = 1
        oneView.addSubview(twoView)
        twoView.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(oneView.snp.bottom).offset(-40)
            make.right.equalTo(-15)
            make.height.equalTo(200)
        }
        
        
        
        
    }

}
