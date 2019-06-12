//
//  ListViewController.swift
//  tally
//
//  Created by zykj on 2019/6/12.
//  Copyright © 2019 李志敬. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: - Property
    private let identifier = "identifier"
    private lazy var tableView: UITableView = {
        let aTableView: UITableView = UITableView.init(frame: CGRect.zero, style: UITableView.Style.plain)
        aTableView.delegate = self
        aTableView.dataSource = self
        aTableView.tableFooterView = UIView.init()
        aTableView.tableHeaderView = UIView.init()
        aTableView.register(Details_ListTableViewCell.classForCoder(), forCellReuseIdentifier: identifier)

        return aTableView
    }()
    var consumeType: ConsumeType?
    var summary: Summary?
    var dataArray: Array<Any> = Array.init()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        self.loadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    //MARK: - SetupUI
    
    private func setupUI() -> Void {
        
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(CustomNavigationBar.getInstance(title: self.consumeType?.keyName, leftBtn: {
            self.navigationController?.popViewController(animated: true)
        }))
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(kNavigationHeight)
        }
        
    }
    
    //MARK: - LoadData
    
    private func loadData() {
        
        let sqlManager: SqlManager = SqlManager.shareInstance
        
        var startDate: String = ""
        var endDate: String = ""
        if self.summary?.date?.count == 4{
            startDate = self.summary?.date?.appendingFormat("%@", "0101") ?? "0"
            endDate = self.summary?.date?.appendingFormat("%@", "1231") ?? "0"
        }
        
        if self.summary?.date?.count == 6{
            let date:String = self.summary?.date ?? ""
            let month: String =  date[4..<6]
            let days: Int = CalendarHelper.days(month: month)
            startDate = self.summary?.date?.appendingFormat("%@", "01") ?? "0"
            endDate = self.summary?.date?.appendingFormat("%2d", days) ?? "0"
        }
        
        let array: Array<TallyList> = sqlManager.tallylist_query(startDate: startDate, endDate: endDate, userid: summary?.userid ?? "00000000")
        self.dataArray.removeAll()
        for tally: TallyList in array {
            if tally.consumeType == self.consumeType?.keyName{
                self.dataArray.append(tally)
            }
        }
        
        self.tableView.reloadData()
    }
    
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let tally: TallyList = self.dataArray[indexPath.row] as! TallyList
        let billingDetailsVC = BillingDetailsViewController.init()
        billingDetailsVC.hidesBottomBarWhenPushed = true
        billingDetailsVC.tallyModel = tally
        billingDetailsVC.del { (tallyList) in
            
            let sqlManager: SqlManager = SqlManager.shareInstance
            let result = sqlManager.tallylist_delete(id: tally.id)
            if result {
                sqlManager.summary_update(tally: tally, type: SqlManager.SummaryType.reduce)
            }
            self.loadData()
            
        }
        billingDetailsVC.edit { (date) in
            self.loadData()
        }
        self.navigationController?.pushViewController(billingDetailsVC, animated: true)
        
    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: Details_ListTableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! Details_ListTableViewCell
        cell.tallyModel = self.dataArray[indexPath.row] as! TallyList
        return cell
    }
}
