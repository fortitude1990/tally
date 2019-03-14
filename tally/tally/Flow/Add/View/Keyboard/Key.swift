//
//  Key.swift
//  tally
//
//  Created by 李志敬 on 2019/3/7.
//  Copyright © 2019 李志敬. All rights reserved.
//

import UIKit

@objc protocol KeyDelegate: NSObjectProtocol{
    func clickHandler(key: Key)
}


class Key: MyBtn {
    
   public enum KeyNumber: Int {
        case none = 0
        case zero
        case one
        case two
        case three
        case four
        case five
        case six
        case seven
        case eight
        case nine
        case point
        case add
        case reduce
        case equal
        case done
        case delete
    }
    
    var keyNumber: KeyNumber?
    weak var delegate: KeyDelegate?
    
    override func btnAction() -> Void{
        super.btnAction()
        
        if let delegate = self.delegate{
            delegate.clickHandler(key: self)
        }
        
        
    }
    
    
    
    
    
}
