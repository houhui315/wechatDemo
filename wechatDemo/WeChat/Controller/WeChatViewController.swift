//
//  WeChatViewController.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 16/8/18.
//  Copyright © 2016年 zhixueyun. All rights reserved.
//

import UIKit

class WeChatViewController: ZXYViewController,WKeyBoardViewControllerDelegate,MsgExternViewDelegate,UITableViewDelegate,UITableViewDataSource {

    //录音显示背景
    var voiceControl: VoiceHudView?
    
    //键盘出现的时候显示的背景
    var bgControl: UIControl?
    
    var keyBoardViewController: WKeyBoardViewController? = nil
    
    var messageTableView: UITableView? = nil
    
    var messageDataAry: NSMutableArray? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = GlobalColor.bgColor
        
        self.initNavBar()
        self.initMessageData()
        self.initTabView()
        self.initBgControl()
        self.initKeyBoardTool()
        
    }
    
    func initMessageData() {
        
        let path = Bundle.main.path(forResource: "messageData", ofType: "plist")
        let tAry = NSArray.init(contentsOfFile: path!)
        self.messageDataAry = NSMutableArray.init()
        for item in tAry! {
            
            let model = chatMessageModel.init()
            model.setValuesForKeys(item as! Dictionary<String, Any>)
            self.messageDataAry?.add(model)
        }
        
    }
    
    func initTabView() {
        
        let rect = CGRect.init(x: 0, y: 0, width: GlobalDevice.screenWidth, height: GlobalDevice.appFrameHeight - 50)
        let tableView = UITableView.init(frame: rect, style: .plain)
        tableView.register(TextMessageCell.self, forCellReuseIdentifier: TextMessageCell.cellIdentifier)
        tableView.tableFooterView = UIView.init()
        tableView.separatorStyle = .none
        tableView.backgroundColor = GlobalColor.bgColor
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        self.messageTableView = tableView
    }
    
    func initNavBar() {
        
        self.title = "小伙伴"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "barbuttonicon_InfoSingle"), style: UIBarButtonItem.Style.plain, target: self, action:#selector(self.weChatInfo))
    }
    
    func initKeyBoardTool() {
        
        let keyBoard = WKeyBoardViewController()
        keyBoard.delegate = self
        keyBoard.externDelegate = self
        self.addChild(keyBoard)
        self.view.addSubview(keyBoard.view)
        self.keyBoardViewController = keyBoard
        keyBoard.view.frame = CGRect(x: 0, y: GlobalDevice.appFrameHeight - 50, width: GlobalDevice.screenWidth, height: 216 + 50+300)
    }
    
    func initVoiceHudView() {
        
        let voiceHudView = VoiceHudView.init(frame: CGRect.zero)
        voiceHudView.showInWindow()
        self.voiceControl = voiceHudView
    }
    
    func removeVoiceHudView() {
        
        if self.voiceControl != nil {
            self.voiceControl?.removeFromWindow()
            self.voiceControl = nil
        }
    }
    
    func initBgControl() {
        
        bgControl = UIControl.init()
        bgControl?.addTarget(self, action: #selector(WeChatViewController.bgControlTouch), for: UIControl.Event.touchUpInside)
        self.view.addSubview(bgControl!)
        bgControl?.snp.makeConstraints({ (make) in
            
            make.edges.equalToSuperview()
        })
        bgControl?.isHidden = true
    }

    @objc func bgControlTouch() {
        
        self.view.endEditing(true)
        self.keyBoardViewController?.messagePageBackgroundTouch()
    }
    
    @objc func weChatInfo() {
        
    }
    
    func sendVoice() {
        print("发送语音")
    }
    
    func cancelSendVoice() {
        print("取消发送语音")
    }
    
//    MARK: - UITableViewDelegate & UITableViewDataSource methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.messageDataAry?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: TextMessageCell = tableView .dequeueReusableCell(withIdentifier: TextMessageCell.cellIdentifier, for: indexPath) as! TextMessageCell
        let model = self.messageDataAry?.object(at: indexPath.row) as! chatMessageModel
        cell.configForBaseModel(model: model)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = self.messageDataAry?.object(at: indexPath.row) as! chatMessageModel
        return TextMessageCell.heightForCell(theString: model.content!)
    }
    
//    MARK: - WWKeyBoardViewControllerDelegate methods
    
    func WkeyBoardVoiceTouchDown() {
        
        if self.voiceControl != nil {
            
            self.voiceControl?.removeFromWindow()
        }
        self.initVoiceHudView()
    }
    
    func WkeyBoardVoiceTouchDragExit() {
        
        self.voiceControl?.showCancelStatus()
    }
    
    func WkeyBoardVoiceTouchDragEnter() {
        
        self.voiceControl?.showNormalStatus()
    }
    
    func WkeyBoardVoiceTouchInside() {
        
        self.removeVoiceHudView()
        self.sendVoice()
    }
    
    func WkeyBoardVoiceTouchOutside() {
        
        self.removeVoiceHudView()
        self.cancelSendVoice()
    }
    
    func WKeyBoardWillShow(_ keyBoardHeight: CGFloat) {
        
        bgControl?.isHidden = false
        let rect = CGRect.init(origin: (self.messageTableView?.frame.origin)!, size: CGSize.init(width: (self.messageTableView?.frame.size.width)!, height: GlobalDevice.appFrameHeight-50-216))
        self.messageTableView?.frame = rect
        self.messageTableView?.scrollToRow(at: IndexPath.init(item: (self.messageDataAry?.count)!-1, section: 0), at: .bottom, animated: true)
    }
    
    func WKeyBoardWillHide() {
        
        let isShowExternBox = self.keyBoardViewController?.isShowEmojiBoxOrExternBox()
        
        if isShowExternBox! {
            bgControl?.isHidden = true
        }
        
        let rect = CGRect.init(origin: (self.messageTableView?.frame.origin)!, size: CGSize.init(width: (self.messageTableView?.frame.size.width)!, height: GlobalDevice.appFrameHeight-50))
        self.messageTableView?.frame = rect
        self.messageTableView?.scrollToRow(at: IndexPath.init(item: (self.messageDataAry?.count)!-1, section: 0), at: .bottom, animated: true)
    }
    
    //MARK: -显示背景control
    func showBackGroundControl(){
    
        bgControl?.isHidden = false
    }
    
    func hideBackGroundControl(){
        
        bgControl?.isHidden = true
    }
    
    
    //MARK: -调用+功能
    func sendPictureFromAlbum() {
        
        UIAlertView.init(title: nil, message: "图片", delegate: nil, cancelButtonTitle: "确定").show()
    }
    
    func sendPictureFromCamera() {
        UIAlertView.init(title: nil, message: "拍摄", delegate: nil, cancelButtonTitle: "确定").show()
    }
    func sendVoiceInfo() {
        UIAlertView.init(title: nil, message: "视频聊天", delegate: nil, cancelButtonTitle: "确定").show()
    }
    func sendLocation() {
        UIAlertView.init(title: nil, message: "位置", delegate: nil, cancelButtonTitle: "确定").show()
    }
    func sendLuckyMoney() {
        UIAlertView.init(title: nil, message: "红包", delegate: nil, cancelButtonTitle: "确定").show()
    }
    func payMoney() {
        UIAlertView.init(title: nil, message: "转账", delegate: nil, cancelButtonTitle: "确定").show()
    }
    func sendUserCard() {
        UIAlertView.init(title: nil, message: "个人名片", delegate: nil, cancelButtonTitle: "确定").show()
    }
    func sendMyFavourite() {
        UIAlertView.init(title: nil, message: "收藏", delegate: nil, cancelButtonTitle: "确定").show()
    }
    func sendMyWallert() {
        UIAlertView.init(title: nil, message: "卡包", delegate: nil, cancelButtonTitle: "确定").show()
    }
    
}
