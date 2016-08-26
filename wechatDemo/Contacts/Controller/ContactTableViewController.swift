//
//  ContactTableViewController.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 16/8/10.
//  Copyright © 2016年 zhixueyun. All rights reserved.
//

import UIKit

class ContactTableViewController: ZXYTableViewController {

    var messageList:[ContactModel] = [ContactModel]()
    var contactsList: [NSDictionary] = [NSDictionary]()
    
    var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(ContactCell.classForCoder(), forCellReuseIdentifier: ContactCell.cellIdentifier)
        self.tableView.registerClass(ContactUserCell.classForCoder(), forCellReuseIdentifier: ContactUserCell.cellIdentifier)
        self.tableView.registerClass(CContactHeadView.classForCoder(), forHeaderFooterViewReuseIdentifier: CContactHeadView.cellIdentifier)
        self.initTableViewFootViewEmpty()
        
        self.tableView.sectionIndexColor = GlobalColor.sectionIndexColor
        
        
        self.initBarButtonItem()
        self.initSearchBar()
        self.testData()
    }

    func initBarButtonItem() {
        
        let barButton = UIBarButtonItem.init(image: UIImage.init(named: "barbuttonicon_add_cube")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(WeChatTableViewController.addButtonTouch))
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    func addButtonTouch() {
        
        print("111")
    }
    
    func initSearchBar() {
        
        searchBar = UISearchBar.init(frame: CGRectMake(0, 0, GlobalDevice.screenWidth, 44))
        searchBar.placeholder = "搜索"
        searchBar.setBackgroundImage(GlobalImage.imageWithColor(GlobalColor.bgColor, size: CGSizeMake(1, 44)), forBarPosition: UIBarPosition.Any, barMetrics: UIBarMetrics.Default)
        self.tableView.tableHeaderView = searchBar
    }
    
    func testData() {
        
        let message1 = ContactModel()
        message1.imageName = "plugins_FriendNotify"
        message1.title = "新的朋友"
        
        let message2 = ContactModel()
        message2.imageName = "add_friend_icon_addgroup"
        message2.title = "群聊"
        
        let message3 = ContactModel()
        message3.imageName = "Contact_icon_ContactTag"
        message3.title = "标签"
        
        let message4 = ContactModel()
        message4.imageName = "add_friend_icon_offical"
        message4.title = "公众号"
        
        messageList.append(message1)
        messageList.append(message2)
        messageList.append(message3)
        messageList.append(message4)
        
        //A
        let contactModel1 = UserContactModel()
        contactModel1.avatarString = "plugins_FriendNotify"
        contactModel1.userNameString = "a11re1"
        
        let contactModel2 = UserContactModel()
        contactModel2.avatarString = "plugins_FriendNotify"
        contactModel2.userNameString = "a11re2"
        
        let contactModel3 = UserContactModel()
        contactModel3.avatarString = "plugins_FriendNotify"
        contactModel3.userNameString = "a11rea3"
        
        let ary1: NSMutableArray = NSMutableArray()
        ary1.addObject(contactModel1)
        ary1.addObject(contactModel2)
        ary1.addObject(contactModel3)
        let dic1 = NSDictionary.init(object: ary1, forKey: "A")
        contactsList.append(dic1)
        
        //B
        let contactModel21 = UserContactModel()
        contactModel21.avatarString = "add_friend_icon_addgroup"
        contactModel21.userNameString = "b11re1"
        
        let contactModel22 = UserContactModel()
        contactModel22.avatarString = "add_friend_icon_addgroup"
        contactModel22.userNameString = "b11re2"
        
        let contactModel23 = UserContactModel()
        contactModel23.avatarString = "add_friend_icon_addgroup"
        contactModel23.userNameString = "b11rea3"
        
        let ary2: NSMutableArray = NSMutableArray()
        ary2.addObject(contactModel21)
        ary2.addObject(contactModel22)
        ary2.addObject(contactModel23)
        let dic2 = NSDictionary.init(object: ary2, forKey: "B")
        contactsList.append(dic2)
        
        //C
        let contactModel31 = UserContactModel()
        contactModel31.avatarString = "Contact_icon_ContactTag"
        contactModel31.userNameString = "c11re1"
        
        let contactModel32 = UserContactModel()
        contactModel32.avatarString = "Contact_icon_ContactTag"
        contactModel32.userNameString = "c11re2"
        
        let contactModel33 = UserContactModel()
        contactModel33.avatarString = "Contact_icon_ContactTag"
        contactModel33.userNameString = "c11rea3"
        
        let ary3: NSMutableArray = NSMutableArray()
        ary3.addObject(contactModel31)
        ary3.addObject(contactModel32)
        ary3.addObject(contactModel33)
        let dic3 = NSDictionary.init(object: ary3, forKey: "C")
        contactsList.append(dic3)
        
        //E
        let contactModel41 = UserContactModel()
        contactModel41.avatarString = "add_friend_icon_offical"
        contactModel41.userNameString = "e11re1"
        
        let contactModel42 = UserContactModel()
        contactModel42.avatarString = "add_friend_icon_offical"
        contactModel42.userNameString = "e11re2"
        
        let contactModel43 = UserContactModel()
        contactModel43.avatarString = "add_friend_icon_offical"
        contactModel43.userNameString = "e11rea3"
        
        let ary4: NSMutableArray = NSMutableArray()
        ary4.addObject(contactModel41)
        ary4.addObject(contactModel42)
        ary4.addObject(contactModel43)
        let dic4 = NSDictionary.init(object: ary4, forKey: "E")
        contactsList.append(dic4)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return 1 + contactsList.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return messageList.count
        }else{
            
            let dic: NSDictionary = contactsList[section - 1]
            let valueDic: NSArray = dic.objectForKey(dic.allKeys.first!) as! NSArray
            if valueDic.count > 0 {
                return valueDic.count
            }else{
                return 0
            }
            
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCellWithIdentifier(ContactCell.cellIdentifier, forIndexPath: indexPath) as! ContactCell
            cell.configforContactObject(messageList[indexPath.row]);
            return cell
            
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier(ContactUserCell.cellIdentifier, forIndexPath: indexPath) as! ContactUserCell
            let dic: NSDictionary = contactsList[indexPath.section - 1]
            let valueDic: NSArray = dic.objectForKey(dic.allKeys.first!) as! NSArray
            let value: UserContactModel = valueDic[indexPath.row] as! UserContactModel
            cell.configforContactObject(value)
            return cell
        }
    }
    

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return ContactCell.heightForCell()
        }else{
            return ContactUserCell.heightForCell()
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            
            return 0
        }
        return CContactHeadView.heightForView()
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            return nil
        }else{
            
            let cell = tableView.dequeueReusableHeaderFooterViewWithIdentifier(CContactHeadView.cellIdentifier) as! CContactHeadView
            let dic: NSDictionary = contactsList[section - 1]
            let titleString: String = dic.allKeys.first as! String
            cell.configforContactObject(titleString)
            return cell
        }
    }
    
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        
        var ary = [String]()
        ary.append("🔍")
        for (_, value) in contactsList.enumerate() {
            
            let dict: NSDictionary = value
            let titleString: String = dict.allKeys.first as! String
            ary.append(titleString)
        }
        
        return ary
    }
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {

        if indexPath.section == 0 {
            
            return UITableViewCellEditingStyle.None
        }
        return UITableViewCellEditingStyle.Delete
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        if indexPath.section == 0 {
            return nil
        }else{
            
            let remarkAction = UITableViewRowAction.init(style: UITableViewRowActionStyle.Normal, title: "备注") { (rowAction: UITableViewRowAction, indexPath: NSIndexPath) in
                
                var list = [NSIndexPath]()
                list.append(indexPath)
                tableView.setEditing(false, animated: true)
            }
            var ary = [UITableViewRowAction]()
            ary.append(remarkAction)
            
            return ary
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
