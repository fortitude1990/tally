//
//  SpendingTypeTable.swift
//  tally
//
//  Created by 李志敬 on 2019/3/19.
//  Copyright © 2019 李志敬. All rights reserved.
//

import UIKit
import SQLite

class ConsumeTypeTable: NSObject {

    //monthly_spending_tally的关联表
    
    let TABLE = Table("consumetype")
    let ID = Expression<Int64>("id")
    let KEYNAME = Expression<String>("keyname")
    let KEYVALUE = Expression<String>("keyvalue")
    let PID = Expression<Int64>("pid") //关联表ID
    
    func create() -> Bool {
        do {
            let db = try Connection(SqlManager.getPath())
            try db.run(TABLE.create(ifNotExists: true){ table in
                table.column(ID, primaryKey: true)
                table.column(KEYNAME)
                table.column(KEYVALUE)
                table.column(PID)
            })
            return true
        }catch{
            return false
        }
    }
    
    func insert(consumerType: ConsumeType) -> Bool {
        
        
        do {
            let db = try Connection(SqlManager.getPath())
            let insert = try db.prepare("INSERT INTO consumetype (keyname, keyvalue, pid) VALUES (?, ?, ?)")
            try insert.run(consumerType.keyName, consumerType.keyValue, consumerType.pid)
            
            return true
        }catch{
            return false
        }
        
    }
    
    func query(pid: Int64) -> [ConsumeType] {
        
        do {
            let db = try Connection(SqlManager.getPath())
            let select = TABLE.select(*).filter(PID == pid)
            let rows = try db.prepare(select)
            
            let array = NSMutableArray.init()
            for row: Row in rows {
                let consumeType = ConsumeType.init()
                consumeType.id = try row.get(ID)
                consumeType.keyName = try row.get(KEYNAME)
                consumeType.keyValue = try row.get(KEYVALUE)
                consumeType.pid = try row.get(PID)
                array.add(consumeType)
            }
            
            return array as! [ConsumeType]
            
        }catch{
            
            return NSMutableArray.init() as! [ConsumeType]
        }
        
    }
    
    func delete(id: Int64) -> Bool {
        do {
            let db = try Connection(SqlManager.getPath())
            let delete = try db.prepare("DELETE FROM consumetype WHERE id = ?")
            try delete.run(id)
            return true
        }catch{
            return false
        }
    }
    
    func update(keyValue: String, id: Int64) -> Bool {
        
        do{
            let db = try Connection(SqlManager.getPath())
            let update = try db.prepare("UPDATE consumetype SET keyvalue = ? WHERE id = ?")
            try update.run(keyValue, id)
            return true
        }catch{
            return false
        }
    }
    
    
    
}
