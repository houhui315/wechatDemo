//
//  MyTableViewController.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 16/8/10.
//  Copyright © 2016年 zhixueyun. All rights reserved.
//

import UIKit

class MyTableViewController: ZXYTableViewController {

    var userInfo: UserInfoModel!
    
    var messageList:[CustomGroupModel] = [CustomGroupModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.registerClass(UserInfoCell.classForCoder(), forCellReuseIdentifier: UserInfoCell.cellIdentifier)
        self.tableView.registerClass(CustomGroupCell.classForCoder(), forCellReuseIdentifier: CustomGroupCell.cellIdentifier)
        self.testData()
    }

    func testData() {
        
        userInfo = UserInfoModel()
        userInfo.avatarImageName = "userinfoAvatar"
        userInfo.userName = "：）"
        userInfo.wechatID = "hahaha"
        
        let message1 = CustomGroupModel()
        message1.imageName = "MoreMyAlbum"
        message1.title = "相册"
        
        let message2 = CustomGroupModel()
        message2.imageName = "MoreMyFavorites"
        message2.title = "收藏"
        
        let message3 = CustomGroupModel()
        message3.imageName = "MoreMyBankCard"
        message3.title = "钱包"
        
        let message4 = CustomGroupModel()
        message4.imageName = "MyCardPackageIcon"
        message4.title = "卡包"
        
        let message5 = CustomGroupModel()
        message5.imageName = "MoreExpressionShops"
        message5.title = "表情"
        
        let message6 = CustomGroupModel()
        message6.imageName = "MoreSetting"
        message6.title = "设置"
        
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
    
    func gotoSetting() {
        
        let userInfoVC = SettingTableViewController.init(style: UITableViewStyle.Grouped)
        userInfoVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(userInfoVC, animated: true)
    }
    
    func rowCountOfSection(section: NSInteger) -> NSInteger {
        
        switch section {
        case 1:
            return 4
        case 2:
            return 1
        case 3:
            return 1
        default:
            return 0
        }
    }
    
    func countOfSecton(section: Int) -> Int {
        
        var count = 0
        for index in 0...(section-1) {
            
            count += self.rowCountOfSection(index)
        }
        return count
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
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 1
        }
        return self.rowCountOfSection(section)
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCellWithIdentifier(UserInfoCell.cellIdentifier, forIndexPath: indexPath) as! UserInfoCell
            cell.configforContactObject(userInfo)
            return cell
        }else{
            
            let cell = tableView.dequeueReusableCellWithIdentifier(CustomGroupCell.cellIdentifier, forIndexPath: indexPath) as! CustomGroupCell
            cell.configforContactObject(messageList[self.indexForIndexPath(indexPath)])
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return UserInfoCell.heightForCell()
        }
        return CustomGroupCell.heightForCell()
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 5
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let section = indexPath.section
        let row = indexPath.row
        switch section {
        case 0:
            self.gotoMyInfo()
        case 1:
            switch row {
            case 0:
                print("")
            case 1:
                print("")
            case 2:
                print("")
            case 3:
                print("")
            default:
                break
            }
        case 2:
            print("")
        case 3:
            self.gotoSetting()
        default:
            break
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

}
