//
//  UserInfoTableViewController.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 16/8/15.
//  Copyright © 2016年 zhixueyun. All rights reserved.
//

import UIKit

class UserInfoTableViewController: ZXYTableViewController {

    
    override init(style: UITableViewStyle) {
        super.init(style: UITableViewStyle.Grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "个人信息"
        
        self.tableView.registerClass(AvatarCell.classForCoder(), forCellReuseIdentifier: AvatarCell.cellIdentifier)
        self.tableView.registerClass(TextInfoCell.classForCoder(), forCellReuseIdentifier: TextInfoCell.cellIdentifier)
        self.tableView.registerClass(ImageInfoCell.classForCoder(), forCellReuseIdentifier: ImageInfoCell.cellIdentifier)
        self.tableView.registerClass(CustomGroupCell.classForCoder(), forCellReuseIdentifier: CustomGroupCell.cellIdentifier)
        self.tableView.registerClass(TextInfoNoArrowCell.classForCoder(), forCellReuseIdentifier: TextInfoNoArrowCell.cellIdentifier)
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if section == 0 {
            
            return 5
        }else{
            return 3
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 0 {
            
            switch row {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier(AvatarCell.cellIdentifier, forIndexPath: indexPath) as! AvatarCell
                cell.configforContactObject("userinfoAvatar")
                return cell
            case 1:
                let textInfoModel = TextInfoModel()
                textInfoModel.titleString = "名字"
                textInfoModel.contentString = "：）"
                
                let cell = tableView.dequeueReusableCellWithIdentifier(TextInfoCell.cellIdentifier, forIndexPath: indexPath) as! TextInfoCell
                cell.configforContactObject(textInfoModel)
                return cell
            case 2:
                let textInfoModel = TextInfoModel()
                textInfoModel.titleString = "微信号"
                textInfoModel.contentString = "hahaha"
                
                let cell = tableView.dequeueReusableCellWithIdentifier(TextInfoNoArrowCell.cellIdentifier, forIndexPath: indexPath) as! TextInfoNoArrowCell
                cell.configforContactObject(textInfoModel)
                return cell
            case 3:
                let cell = tableView.dequeueReusableCellWithIdentifier(ImageInfoCell.cellIdentifier, forIndexPath: indexPath) as! ImageInfoCell
                return cell
            case 4:
                let textInfoModel = TextInfoModel()
                textInfoModel.titleString = "我的地址"
                textInfoModel.contentString = "  "
                let cell = tableView.dequeueReusableCellWithIdentifier(TextInfoCell.cellIdentifier, forIndexPath: indexPath) as! TextInfoCell
                cell.configforContactObject(textInfoModel)
                return cell
            default :
                let textInfoModel = TextInfoModel()
                textInfoModel.titleString = "微信号"
                textInfoModel.contentString = "  "
                let cell = tableView.dequeueReusableCellWithIdentifier(TextInfoCell.cellIdentifier, forIndexPath: indexPath) as! TextInfoCell
                return cell
            }
            
        }else{
            
            switch row {
            case 0:
                let textInfoModel = TextInfoModel()
                textInfoModel.titleString = "性别"
                textInfoModel.contentString = "男"
                let cell = tableView.dequeueReusableCellWithIdentifier(TextInfoCell.cellIdentifier, forIndexPath: indexPath) as! TextInfoCell
                cell.configforContactObject(textInfoModel)
                return cell
            case 1:
                let textInfoModel = TextInfoModel()
                textInfoModel.titleString = "地区"
                textInfoModel.contentString = "广东 深圳"
                let cell = tableView.dequeueReusableCellWithIdentifier(TextInfoCell.cellIdentifier, forIndexPath: indexPath) as! TextInfoCell
                cell.configforContactObject(textInfoModel)
                return cell
            case 2:
                let textInfoModel = TextInfoModel()
                textInfoModel.titleString = "个性签名"
                textInfoModel.contentString = "未填写"
                let cell = tableView.dequeueReusableCellWithIdentifier(TextInfoCell.cellIdentifier, forIndexPath: indexPath) as! TextInfoCell
                cell.configforContactObject(textInfoModel)
                return cell
            default:
                let textInfoModel = TextInfoModel()
                textInfoModel.titleString = "个性签名"
                textInfoModel.contentString = "未填写"
                let cell = tableView.dequeueReusableCellWithIdentifier(TextInfoCell.cellIdentifier, forIndexPath: indexPath) as! TextInfoCell
                return cell
            }
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.section == 0 && indexPath.row == 0 {
            
            return 88
        }
        return CustomGroupCell.heightForCell()
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return 15
        }
        return 5
    }
}
