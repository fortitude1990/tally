//
//  HomeViewController.swift
//  tally
//
//  Created by 李志敬 on 2019/3/6.
//  Copyright © 2019 李志敬. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    

    // MARK: - SetupUI
    
    func setupUI() -> Void {
        self.view.backgroundColor = UIColor.white
        
        let btn: UIButton = UIButton.init(type: UIButton.ButtonType.system)
        btn.setTitle("下一页", for: UIControl.State.normal)
        self.view.addSubview(btn)
        btn.frame = CGRect.init(x: 100, y: 100, width: 60, height: 44)
        btn.addTarget(self, action: #selector(btnAction), for: UIControl.Event.touchUpInside)
        
    }

    @objc func btnAction() -> Void {
        let vc: ViewController = ViewController.init()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
