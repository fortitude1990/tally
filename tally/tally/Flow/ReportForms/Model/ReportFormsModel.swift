//
//  ReportFormsModel.swift
//  tally
//
//  Created by zykj on 2019/5/24.
//  Copyright © 2019 李志敬. All rights reserved.
//

import UIKit

class ReportFormsModel: NSObject {

    var consumeType: ConsumeType?
    var title: String{
        get{
            return consumeType?.keyName ?? ""
        }
    }
    var amount: String{
        get{
            return consumeType?.keyValue ?? ""
        }
    }
    var count: Int64{
        get{
            return consumeType?.count ?? 0
        }
    }
    
    var scale: Double = 0.00
    var type: NSInteger = 1 //1: 支出， 2：收入
    

}
