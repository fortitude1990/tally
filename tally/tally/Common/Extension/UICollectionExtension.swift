//
//  UIScrollViewExtension.swift
//  tally
//
//  Created by 李志敬 on 2019/3/11.
//  Copyright © 2019 李志敬. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView{
    
    
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.next != nil {
            self.next?.touchesBegan(touches, with: event)
        }else{
            super.touchesBegan(touches, with: event)
        }
    }
    
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if self.next != nil {
            self.next?.touchesMoved(touches, with: event)
        }else{
            super.touchesMoved(touches, with: event)
        }
        
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if self.next != nil{
            self.next?.touchesEnded(touches, with: event)
        }else{
            super.touchesEnded(touches, with: event)
        }
        
    }

    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.next != nil {
            self.next?.touchesCancelled(touches, with: event)
        }else{
            super.touchesCancelled(touches, with: event)
        }
    }
    
    
    
}
