//
//  TallyTable.swift
//  tally
//
//  Created by 李志敬 on 2019/3/16.
//  Copyright © 2019 李志敬. All rights reserved.
//

import UIKit
import SQLite

class TallyTable: NSObject {

    let TALLY = Table("tallyList")
    let ID = Expression<Int64>("id")
    let USERID = Expression<String>("userid")
    let AMOUNT = Expression<String>("amount")
    let DATE = Expression<String>("date")
    let REMARK = Expression<String?>("remark")
    let CONSUMETYPE = Expression<String>("consumetype")
    let TALLYTYPE = Expression<Int>("tallytype")
    
    func create() -> Bool {
        do {
            
            let db = try Connection(SqlManager.getPath())
            try db.run(TALLY.create(ifNotExists: true){ table in
                table.column(ID, primaryKey: true)
                table.column(USERID)
                table.column(AMOUNT)
                table.column(DATE)
                table.column(REMARK)
                table.column(CONSUMETYPE)
                table.column(TALLYTYPE)
            })
            
            return true
            
        } catch{
            print("Tally表创建失败")
            return false
        }
        
    }
    
    func insert(record tally: TallyList) -> Bool {
        do {
            let db = try Connection(SqlManager.getPath())
            let insert = try db.prepare("INSERT INTO tallyList (userid, amount, date, remark, consumetype, tallytype) VALUES (?, ?, ?, ?, ?, ?)")
            try insert.run(tally.userid, tally.amount, tally.date, tally.remark, tally.consumeType, tally.tallyType)
            return true
        } catch  {
            return false
        }
    }
    
    func query(date: String, userid: String) -> [TallyList] {
        
        let array: NSMutableArray = NSMutableArray.init()
        do {
            
            let db = try Connection(SqlManager.getPath())
            let tallyListRows = try db.prepare(TALLY.select(*).filter(DATE == date).filter(USERID == userid).order(ID.desc))
            
            for row:Row in tallyListRows {
                let tally: TallyList = TallyList.init()
                tally.id = try row.get(ID)
                tally.amount = try row.get(AMOUNT)
                tally.date = try row.get(DATE)
                tally.consumeType = try row.get(CONSUMETYPE)
                tally.tallyType = try row.get(TALLYTYPE)
                tally.remark = try row.get(REMARK)
                tally.userid = try row.get(USERID)
                array.add(tally)
            }
            
        } catch  {
            print("读取失败")
        }
        
        return array as! [TallyList]
    }
    
    func query(startDate: String, endDate: String, userid: String) -> [TallyList] {
        
        let array: NSMutableArray = NSMutableArray.init()
        do {
            
            let db = try Connection(SqlManager.getPath())
            let tallyListRows = try db.prepare(TALLY.select(*).filter(DATE >= startDate).filter(DATE <= endDate).filter(USERID == userid).order(ID.desc))
            
            for row:Row in tallyListRows {
                let tally: TallyList = TallyList.init()
                tally.id = try row.get(ID)
                tally.amount = try row.get(AMOUNT)
                tally.date = try row.get(DATE)
                tally.consumeType = try row.get(CONSUMETYPE)
                tally.tallyType = try row.get(TALLYTYPE)
                tally.remark = try row.get(REMARK)
                tally.userid = try row.get(USERID)
                array.add(tally)
            }
            
        } catch  {
            print("读取失败")
        }
        
        return array as! [TallyList]
    }
    
    func delete(id: Int64) -> Bool {
        do {
            let db = try Connection(SqlManager.getPath())
            let delete = try db.prepare("DELETE FROM tallyList WHERE id = ?")
            try delete.run(id)
            return true
        }catch{
            return false
        }
    }
    
}


