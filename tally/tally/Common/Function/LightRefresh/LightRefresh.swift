//
//  File.swift
//  tally
//
//  Created by 李志敬 on 2019/3/27.
//  Copyright © 2019 李志敬. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView{
    
    func addLoadMore(handler:@escaping (()->Void)) -> Void {
        let footer = FooterRefreshComponent(handler: handler)
        self.addSubview(footer)
    }
    
    func addPullRefresh(handler:@escaping (()->Void)) -> Void {
        let footer = HeaderRefreshComponent(handler: handler)
        self.addSubview(footer)
    }
    
    
}
