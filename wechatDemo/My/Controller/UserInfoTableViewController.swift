//
//  UserInfoTableViewController.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 16/8/15.
//  Copyright © 2016年 zhixueyun. All rights reserved.
//

import UIKit

class UserInfoTableViewController: ZXYTableViewController {

    
    override init(style: UITableView.Style) {
        super.init(style: UITableView.Style.grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "个人信息"
        
        self.tableView.register(AvatarCell.classForCoder(), forCellReuseIdentifier: AvatarCell.cellIdentifier)
        self.tableView.register(TextInfoCell.classForCoder(), forCellReuseIdentifier: TextInfoCell.cellIdentifier)
        self.tableView.register(ImageInfoCell.classForCoder(), forCellReuseIdentifier: ImageInfoCell.cellIdentifier)
        self.tableView.register(CustomGroupCell.classForCoder(), forCellReuseIdentifier: CustomGroupCell.cellIdentifier)
        self.tableView.register(TextInfoNoArrowCell.classForCoder(), forCellReuseIdentifier: TextInfoNoArrowCell.cellIdentifier)
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if section == 0 {
            
            return 5
        }else{
            return 3
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = (indexPath as NSIndexPath).section
        let row = (indexPath as NSIndexPath).row
        
        if section == 0 {
            
            switch row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: AvatarCell.cellIdentifier, for: indexPath) as! AvatarCell
                cell.configforContactObject("userinfoAvatar")
                return cell
            case 1:
                let textInfoModel = TextInfoModel()
                textInfoModel.titleString = "名字"
                textInfoModel.contentString = "：）"
                
                let cell = tableView.dequeueReusableCell(withIdentifier: TextInfoCell.cellIdentifier, for: indexPath) as! TextInfoCell
                cell.configforContactObject(textInfoModel)
                return cell
            case 2:
                let textInfoModel = TextInfoModel()
                textInfoModel.titleString = "微信号"
                textInfoModel.contentString = "hahaha"
                
                let cell = tableView.dequeueReusableCell(withIdentifier: TextInfoNoArrowCell.cellIdentifier, for: indexPath) as! TextInfoNoArrowCell
                cell.configforContactObject(textInfoModel)
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: ImageInfoCell.cellIdentifier, for: indexPath) as! ImageInfoCell
                return cell
            case 4:
                let textInfoModel = TextInfoModel()
                textInfoModel.titleString = "我的地址"
                textInfoModel.contentString = "  "
                let cell = tableView.dequeueReusableCell(withIdentifier: TextInfoCell.cellIdentifier, for: indexPath) as! TextInfoCell
                cell.configforContactObject(textInfoModel)
                return cell
            default :
                let textInfoModel = TextInfoModel()
                textInfoModel.titleString = "微信号"
                textInfoModel.contentString = "  "
                let cell = tableView.dequeueReusableCell(withIdentifier: TextInfoCell.cellIdentifier, for: indexPath) as! TextInfoCell
                return cell
            }
            
        }else{
            
            switch row {
            case 0:
                let textInfoModel = TextInfoModel()
                textInfoModel.titleString = "性别"
                textInfoModel.contentString = "男"
                let cell = tableView.dequeueReusableCell(withIdentifier: TextInfoCell.cellIdentifier, for: indexPath) as! TextInfoCell
                cell.configforContactObject(textInfoModel)
                return cell
            case 1:
                let textInfoModel = TextInfoModel()
                textInfoModel.titleString = "地区"
                textInfoModel.contentString = "广东 深圳"
                let cell = tableView.dequeueReusableCell(withIdentifier: TextInfoCell.cellIdentifier, for: indexPath) as! TextInfoCell
                cell.configforContactObject(textInfoModel)
                return cell
            case 2:
                let textInfoModel = TextInfoModel()
                textInfoModel.titleString = "个性签名"
                textInfoModel.contentString = "未填写"
                let cell = tableView.dequeueReusableCell(withIdentifier: TextInfoCell.cellIdentifier, for: indexPath) as! TextInfoCell
                cell.configforContactObject(textInfoModel)
                return cell
            default:
                let textInfoModel = TextInfoModel()
                textInfoModel.titleString = "个性签名"
                textInfoModel.contentString = "未填写"
                let cell = tableView.dequeueReusableCell(withIdentifier: TextInfoCell.cellIdentifier, for: indexPath) as! TextInfoCell
                return cell
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (indexPath as NSIndexPath).section == 0 && (indexPath as NSIndexPath).row == 0 {
            
            return 88
        }
        return CustomGroupCell.heightForCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return 15
        }
        return 5
    }
}
