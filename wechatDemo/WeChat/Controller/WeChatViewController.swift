//
//  WeChatViewController.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 16/8/18.
//  Copyright © 2016年 zhixueyun. All rights reserved.
//

import UIKit

class WeChatViewController: ZXYViewController,WKeyBoardViewControllerDelegate,MsgExternViewDelegate {

    //录音显示背景
    var voiceControl: VoiceHudView?
    
    //键盘出现的时候显示的背景
    var bgControl: UIControl?
    
    var keyBoardViewController: WKeyBoardViewController? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = GlobalColor.bgColor
        
        self.initNavBar()
        self.initBgControl()
        self.initKeyBoardTool()
    }
    
    func initNavBar() {
        
        self.title = "小伙伴"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "barbuttonicon_InfoSingle"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(WeChatViewController.weChatInfo))
    }
    
    func initKeyBoardTool() {
        
        let keyBoard = WKeyBoardViewController()
        keyBoard.delegate = self
        keyBoard.externDelegate = self
        self.addChildViewController(keyBoard)
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
        bgControl?.addTarget(self, action: #selector(WeChatViewController.bgControlTouch), for: UIControlEvents.touchUpInside)
        self.view.addSubview(bgControl!)
        bgControl?.snp.makeConstraints({ (make) in
            
            make.edges.equalToSuperview()
        })
        bgControl?.isHidden = true
    }

    func bgControlTouch() {
        
        self.view.endEditing(true)
        self.keyBoardViewController?.messagePageBackgroundTouch()
    }
    
    func weChatInfo() {
        
    }
    
    func sendVoice() {
        print("发送语音")
    }
    
    func cancelSendVoice() {
        print("取消发送语音")
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
        
    }
    
    func WKeyBoardWillHide() {
        
        let isShowExternBox = self.keyBoardViewController?.isShowEmojiBoxOrExternBox()
        
        if isShowExternBox! {
            bgControl?.isHidden = true
        }
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
