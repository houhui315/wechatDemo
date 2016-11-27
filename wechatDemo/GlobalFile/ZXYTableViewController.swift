//
//  ZXYTableViewController.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 16/8/11.
//  Copyright © 2016年 zhixueyun. All rights reserved.
//

import UIKit

class ZXYTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.clearsSelectionOnViewWillAppear = true
        self.edgesForExtendedLayout = UIRectEdge()
        self.tableView.backgroundColor = GlobalColor.bgColor
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        self.tableView.separatorColor = GlobalColor.lineColor
        
    }
    
    func initTableViewFootViewEmpty() {
        
        self.tableView.tableFooterView = UIView.init()
    }
}
