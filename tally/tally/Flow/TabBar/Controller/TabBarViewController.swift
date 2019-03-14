//
//  TabBarViewController.swift
//  tally
//
//  Created by 李志敬 on 2019/3/6.
//  Copyright © 2019 李志敬. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
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
    
    func setupUI() -> Void {
        
        
        let homeVC:HomeViewController = HomeViewController.init()
        let homeNavC: UINavigationController = UINavigationController.init(rootViewController: homeVC)
        let homeVC1:ViewController = ViewController.init()
        let homeNavC1: UINavigationController = UINavigationController.init(rootViewController: homeVC1)
        self.viewControllers = [homeNavC, homeNavC1]

        //自定义tabBar添加之前必须先添加viewControllers，否则自定义tabBar无效
        let customTabBar:CustomTabBar = CustomTabBar.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kTabBarHeight))
        customTabBar.delegate = self;
        customTabBar.addBtnHandler {
            print("addbtnHandler响应了")
            
            let addVC: AddViewController = AddViewController.init()
            let addNavC: UINavigationController = UINavigationController.init(rootViewController: addVC)
            addNavC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            self.present(addNavC, animated: true, completion: {
                
            })
            
        }
        self.tabBar.addSubview(customTabBar)
 
        self.tabBar.backgroundImage = UIImage.init()
        self.tabBar.shadowImage = UIImage.init()
        
        
        
        
    }
    
    // MARK: - UITabBarDelegate
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        self.selectedIndex = item.tag
        print("\(item.tag)")
        
    }
    
   
}
