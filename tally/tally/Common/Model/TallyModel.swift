//
//  TallyModel.swift
//  tally
//
//  Created by 李志敬 on 2019/3/15.
//  Copyright © 2019 李志敬. All rights reserved.
//

import UIKit

class TallyModel: NSObject {

    enum TalleyType {
        case spending
        case income
    }

    var consumeType: ConsumeTypeModel?
    var amount: String?
    var date: String?
    var remark: String?
    
    
}
