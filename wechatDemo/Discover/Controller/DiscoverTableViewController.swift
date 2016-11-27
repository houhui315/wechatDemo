//
//  DiscoverTableViewController.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 16/8/10.
//  Copyright © 2016年 zhixueyun. All rights reserved.
//

import UIKit

class DiscoverTableViewController: ZXYTableViewController {

    var messageList:[CustomGroupModel] = [CustomGroupModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(CustomGroupCell.classForCoder(), forCellReuseIdentifier: CustomGroupCell.cellIdentifier)
        
        self.testData()
    }
    
    func testData() {
        
        let message1 = CustomGroupModel()
        message1.imageName = "ff_IconShowAlbum"
        message1.title = "朋友圈"
        
        let message2 = CustomGroupModel()
        message2.imageName = "ff_IconQRCode"
        message2.title = "扫一扫"
        
        let message3 = CustomGroupModel()
        message3.imageName = "ff_IconShake"
        message3.title = "摇一摇"
        
        let message4 = CustomGroupModel()
        message4.imageName = "ff_IconLocationService"
        message4.title = "附近的人"
        
        let message5 = CustomGroupModel()
        message5.imageName = "ff_IconBottle"
        message5.title = "漂流瓶"
        
        let message6 = CustomGroupModel()
        message6.imageName = "MoreGame"
        message6.title = "游戏"
        
        messageList.append(message1)
        messageList.append(message2)
        messageList.append(message3)
        messageList.append(message4)
        messageList.append(message5)
        messageList.append(message6)
    }

    func rowCountOfSection(_ section: NSInteger) -> NSInteger {
        
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            return 2
        case 3:
            return 1
        default:
            return 0
        }
    }
    
    func countOfSecton(_ section: Int) -> Int {
        
        if section == 0 {
            return 0
        }
        
        var count = 0
        for index in 0...(section-1) {
            
            count += self.rowCountOfSection(index)
        }
        return count
    }
    
    func indexForIndexPath(_ indexPath : IndexPath) -> Int {
        
        let index = self.countOfSecton((indexPath as NSIndexPath).section) + (indexPath as NSIndexPath).row
        return index
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        return self.rowCountOfSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomGroupCell.cellIdentifier, for: indexPath) as! CustomGroupCell
        cell.configforContactObject(messageList[self.indexForIndexPath(indexPath)]);

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CustomGroupCell.heightForCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return 15
        }
        return 5
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
