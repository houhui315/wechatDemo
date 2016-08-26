//
//  SettingTableViewController.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 16/8/16.
//  Copyright © 2016年 zhixueyun. All rights reserved.
//

import UIKit

class SettingTableViewController: ZXYTableViewController {
    
    var messageList:[TextInfoModel] = [TextInfoModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "设置"
        
        self.tableView.registerClass(TextInfoCell.classForCoder(), forCellReuseIdentifier: TextInfoCell.cellIdentifier)
        self.tableView.registerClass(TextCenterCell.classForCoder(), forCellReuseIdentifier: TextCenterCell.cellIdentifier)
        self.testData()
    }
    
    func testData() {
        
        let message1 = TextInfoModel()
        message1.titleString = "帐号与安全"
        message1.contentString = " "
        
        let message2 = TextInfoModel()
        message2.titleString = "新消息通知"
        message2.contentString = " "
        
        let message3 = TextInfoModel()
        message3.titleString = "隐私"
        message3.contentString = " "
        
        let message4 = TextInfoModel()
        message4.titleString = "通用"
        message4.contentString = " "
        
        let message5 = TextInfoModel()
        message5.titleString = "帮助与反馈"
        message5.contentString = " "
        
        let message6 = TextInfoModel()
        message6.titleString = "关于微信"
        message6.contentString = " "
        
        messageList.append(message1)
        messageList.append(message2)
        messageList.append(message3)
        messageList.append(message4)
        messageList.append(message5)
        messageList.append(message6)
        
    }
    
    func gotoMyInfo() {
        
        let userInfoVC = UserInfoTableViewController.init(style: UITableViewStyle.Grouped)
        userInfoVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(userInfoVC, animated: true)
    }
    
    func alertLogOut() {
        
        let actionController = ZXYActionSheetController.init(message: "退出后不会删除任何历史数据，下次登录依然可以使用本帐号。")
        actionController.addAction(ZXYAlertAction.init(title: "退出登录", style: ZXYAlertActionStyle.Destructive, handle: { (action:ZXYAlertAction) in
            print("退出登录")
            NSNotificationCenter.defaultCenter().postNotification(NSNotification.init(name: "LogoutSuccess", object: nil))
        }))
        actionController.addAction(ZXYAlertAction.init(title: "取消", style: ZXYAlertActionStyle.Cancel, handle: { (action:ZXYAlertAction) in
            print("取消")
        }))
        self.presentViewController(actionController, animated: false, completion:nil)
 
    }
    
    func rowCountOfSection(section: NSInteger) -> NSInteger {
        
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        case 2:
            return 2
        default:
            return 0
        }
    }
    
    func countOfSecton(section: Int) -> Int {
        
        if section == 0 {
            return 0
        }else if section == 1 {
            return 1
        }else if section == 2 {
            return 1 + 3
        }else if section == 3 {
            return 1+3+2
        }else{
            return 0
        }
    }
    
    func indexForIndexPath(indexPath : NSIndexPath) -> Int {
        
        let index = self.countOfSecton(indexPath.section) + indexPath.row
        return index
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if section < 3 {
            return self.rowCountOfSection(section)
        }
        return 1
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section < 3 {
            let cell = tableView.dequeueReusableCellWithIdentifier(TextInfoCell.cellIdentifier, forIndexPath: indexPath) as! TextInfoCell
            cell.configforContactObject(messageList[self.indexForIndexPath(indexPath)])
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier(TextCenterCell.cellIdentifier, forIndexPath: indexPath) as! TextCenterCell
            cell.configforContactObject("退出登录")
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        return TextInfoCell.heightForCell()
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return 15
        }
        return 5
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let section = indexPath.section
        let row = indexPath.row
        switch section {
        case 0:
            print("")
        case 1:
            switch row {
            case 0:
                print("")
            case 1:
                print("")
            case 2:
                print("")
            default:
                break
            }
        case 2:
            switch row {
            case 0:
                print("")
            case 1:
                print("")
            default:
                break
            }
        case 3:
            self.alertLogOut()
        default:
            break
        }
    }
    
}
