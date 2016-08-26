//
//  WeChatViewController.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 16/8/18.
//  Copyright © 2016年 zhixueyun. All rights reserved.
//

import UIKit

class WeChatViewController: ZXYViewController,WKeyBoardViewControllerDelegate {

    //录音显示背景
    var voiceControl: VoiceHudView?
    
    //键盘出现的时候显示的背景
    var bgControl: UIControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = GlobalColor.bgColor
        
        self.initNavBar()
        self.initBgControl()
        self.initKeyBoardTool()
    }
    
    func initNavBar() {
        
        self.title = "小伙伴"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "barbuttonicon_InfoSingle"), style: UIBarButtonItemStyle.Plain, target: self, action:#selector(WeChatViewController.weChatInfo))
    }
    
    func initKeyBoardTool() {
        
        let keyBoard = WKeyBoardViewController()
        keyBoard.delegate = self
        self.addChildViewController(keyBoard)
        self.view.addSubview(keyBoard.view)
        keyBoard.view.frame = CGRectMake(0, GlobalDevice.appFrameHeight - 50, GlobalDevice.screenWidth, 216 + 50)
    }
    
    func initVoiceHudView() {
        
        let voiceHudView = VoiceHudView.init(frame: CGRectZero)
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
        bgControl?.addTarget(self, action: #selector(WeChatViewController.bgControlTouch), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(bgControl!)
        bgControl?.snp_makeConstraints(closure: { (make) in
            
            make.left.equalTo(0)
            make.right.equalTo(self.view.snp_right)
            make.top.equalTo(self.view.snp_top)
            make.bottom.equalTo(self.view.snp_bottom).offset(-50)
        })
        bgControl?.hidden = true
    }

    func bgControlTouch() {
        
        self.view.endEditing(true)
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
    
    func WKeyBoardWillShow(keyBoardHeight: CGFloat) {
        
        bgControl?.hidden = false
        
    }
    
    func WKeyBoardWillHide() {
        
        bgControl?.hidden = true
    }
}
