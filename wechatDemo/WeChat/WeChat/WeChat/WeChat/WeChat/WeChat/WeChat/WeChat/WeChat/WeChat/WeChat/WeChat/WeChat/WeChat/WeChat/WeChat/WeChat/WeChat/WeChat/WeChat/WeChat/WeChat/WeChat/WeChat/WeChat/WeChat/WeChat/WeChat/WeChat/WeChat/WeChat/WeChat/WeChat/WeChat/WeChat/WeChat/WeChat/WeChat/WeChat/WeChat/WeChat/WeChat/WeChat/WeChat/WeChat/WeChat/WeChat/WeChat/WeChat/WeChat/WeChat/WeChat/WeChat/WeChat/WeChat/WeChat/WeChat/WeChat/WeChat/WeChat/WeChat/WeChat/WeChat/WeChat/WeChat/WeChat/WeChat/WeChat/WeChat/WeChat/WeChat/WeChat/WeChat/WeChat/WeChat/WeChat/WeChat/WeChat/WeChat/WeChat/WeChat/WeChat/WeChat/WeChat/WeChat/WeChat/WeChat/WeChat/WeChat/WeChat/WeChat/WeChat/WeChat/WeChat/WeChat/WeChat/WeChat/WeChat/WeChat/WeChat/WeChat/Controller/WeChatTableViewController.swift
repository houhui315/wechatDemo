//
//  WeChatTableViewController.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 16/8/10.
//  Copyright © 2016年 zhixueyun. All rights reserved.
//

import UIKit
import AVFoundation

class WeChatTableViewController: ZXYTableViewController , MoreAddViewDelegate{

    var messageList:[messageModel] = [messageModel]()
    
    var searchBar: UISearchBar!
    
    var myMoreAddView: MoreAddView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        self.tableView.register(MessageCell.classForCoder(), forCellReuseIdentifier: MessageCell.cellIdentifier)
        self.initTableViewFootViewEmpty()
        
        self.initBarButtonItem()
        self.initBackGroundLogo()
        self.initSearchBar()
        self.testData()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(forName: NSNotification.Name.AVAudioSessionRouteChange, object: nil, queue: OperationQueue.main) { (notification: Notification) in
            
            let dic = (notification as NSNotification).userInfo
            let changeReason = (dic![AVAudioSessionRouteChangeReasonKey] as AnyObject).uintValue
            
            if AVAudioSessionRouteChangeReason.init(rawValue: changeReason!) == AVAudioSessionRouteChangeReason.oldDeviceUnavailable{
                
                let routeDescription = dic![AVAudioSessionRouteChangePreviousRouteKey]
                let outPuts : [AVAssetReaderOutput] = ((routeDescription as AnyObject).outputs)!
                let portDescription:AVAssetReaderOutput = outPuts.first!
                print(portDescription)
            }
        }
    }
    
    func initBarButtonItem() {
        
        let barButton = UIBarButtonItem.init(image: UIImage.init(named: "barbuttonicon_add")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: UIBarButtonItemStyle.plain, target: self, action: #selector(WeChatTableViewController.addButtonTouch))
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    func addButtonTouch() {
        
        if myMoreAddView?.superview != nil {
            
            myMoreAddView?.removeMyself()
            
            self.tableViewEnabledScroll(true)
            
        }else{
            let moreAddView = MoreAddView.init(frame: self.view.bounds)
            moreAddView.delegate = self
            self.view.addSubview(moreAddView)
            myMoreAddView = moreAddView
            
            self.tableViewEnabledScroll(false)
        }
    }
    
    func initSearchBar() {
        
        searchBar = UISearchBar.init(frame: CGRect(x: 0, y: 0, width: GlobalDevice.screenWidth, height: 44))
        searchBar.placeholder = "搜索"
        searchBar.setBackgroundImage(GlobalImage.imageWithColor(GlobalColor.bgColor, size: CGSize(width: 1, height: 44)), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        self.tableView.tableHeaderView = searchBar
    }
    
    func initBackGroundLogo() {
        
        let logoImageView = UIImageView.init(image: UIImage.init(named: "ChatListBackgroundLogo"))
        self.tableView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { (make) in
            
            make.bottom.equalTo(self.tableView.snp.top).offset(-20)
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.centerX.equalTo(self.tableView.snp.centerX)
        }
    }
    
    func testData() {
        
        let message1 = messageModel(imageName:"ReadVerified_icon",title:"订阅号",content:"订阅号里面的内容描述",time:"11:10")
        
        let message2 = messageModel(imageName:"add_friend_icon_invite",title:"QQ邮箱提醒",content:"QQ邮箱里面的内容描述",time:"12:10")
        
        let message3 = messageModel(imageName:"Transfer_Icon",title:"文件传输助手",content:"[文件]123.txt",time:"09:18")
        
        let message4 = messageModel(imageName:"transport",title:"文件传输助手",content:"[图片]",time:"昨天")
        
        let message5 = messageModel(imageName:"ruanpeng",title:"偷影子的人",content:"哈哈",time:"昨天")
        
        let message6 = messageModel(imageName:"zhifu",title:"订阅号",content:"微信支付凭证",time:"星期三")
        
        let message7 = messageModel(imageName:"yuxiao",title:"WilL",content:"....",time:"星期三")
        
        let message8 = messageModel(imageName:"youzan",title:"有赞",content:"开始点赞吧!",time:"星期二")
        
        let message9 = messageModel(imageName:"zhangzeyan",title:"张泽彦",content:"张泽彦领取了你的红包",time:"星期二")
        
        messageList = Array.init(arrayLiteral: message1,message2,message3,message4,message5,message6,message7,message8,message9)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return messageList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageCell.cellIdentifier, for: indexPath) as! MessageCell

        // Configure the cell...
        cell.configforMessageObject(messageList[(indexPath as NSIndexPath).row])

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return MessageCell.heightForCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let weChatVC = WeChatViewController()
        weChatVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(weChatVC, animated: true)
    }
    
    //MARK: -- MoreAddViewDelegate
    
    func MoreAddViewDidSelectWithIndex(_ index: Int) {
        
        print("selectIndex=\(index)")
        self.tableViewEnabledScroll(true)
    }
    
    func MoreAddViewCancelSelect() {
        
        self.tableViewEnabledScroll(true)
    }
    
    func tableViewEnabledScroll(_ enabled: Bool){
        
        self.tableView.isScrollEnabled = enabled
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
