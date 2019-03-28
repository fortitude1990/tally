//
//  BillingDetailsViewController.swift
//  tally
//
//  Created by 李志敬 on 2019/3/21.
//  Copyright © 2019 李志敬. All rights reserved.
//

import UIKit

class BillingDetailsViewController: UIViewController {

     // MARK: - Property
    
    
    
    
     // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    

     // MARK: - SetupUI
    
    func setupUI() -> Void {
        
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(CustomNavigationBar.getInstance(title: "详情", leftBtn: {
            self.navigationController?.popViewController(animated: true)
        }))
        
        
    }
    
    
    
}
