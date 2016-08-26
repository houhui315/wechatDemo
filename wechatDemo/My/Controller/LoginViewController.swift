//
//  loginViewController.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 16/8/17.
//  Copyright © 2016年 zhixueyun. All rights reserved.
//

import UIKit

class LoginViewController: ZXYViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.initLoginView()
    }
    
    func initLoginView() {
        
        let loginView = UIView.init()
        self.view.addSubview(loginView)
        loginView.snp_makeConstraints { (make) in
            
            make.edges.equalTo(UIEdgeInsetsMake(GlobalDevice.navStatusBarHeight, 0, 0, 0))
        }
        
        let avatarImageView = UIImageView.init()
        loginView.addSubview(avatarImageView)
        avatarImageView.image = UIImage.init(named: "userinfoAvatar")
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = 4
        avatarImageView.snp_makeConstraints { (make) in
            
            make.top.equalTo(10)
            make.width.equalTo(80)
            make.height.equalTo(80)
            make.centerX.equalTo(loginView.snp_centerX)
        }
        
        let userNameLabel = UILabel.init()
        loginView.addSubview(userNameLabel)
        userNameLabel.text = "403262655"
        userNameLabel.textAlignment = NSTextAlignment.Center
        userNameLabel.font = UIFont.boldSystemFontOfSize(18)
        userNameLabel.snp_makeConstraints { (make) in
            
            make.top.equalTo(avatarImageView.snp_bottom).offset(10)
            make.width.equalTo(loginView.snp_width)
            make.height.equalTo(20)
            make.centerX.equalTo(loginView.snp_centerX)
        }
        
        let pwdLabel = UILabel.init()
        pwdLabel.text = "密码"
        pwdLabel.font = UIFont.systemFontOfSize(18)
        loginView.addSubview(pwdLabel)
        pwdLabel.snp_makeConstraints { (make) in
            
            make.left.equalTo(20)
            make.top.equalTo(userNameLabel.snp_bottom).offset(40)
            make.width.equalTo(40)
            make.height.equalTo(20)
        }
        
        let pwdTextField = UITextField.init()
        pwdTextField.placeholder = "请填写密码"
        pwdTextField.textAlignment = NSTextAlignment.Center
        pwdTextField.font = UIFont.systemFontOfSize(18)
        loginView.addSubview(pwdTextField)
        pwdTextField.snp_makeConstraints { (make) in
            
            make.top.equalTo(pwdLabel.snp_top)
            make.left.equalTo(pwdLabel.snp_right).offset(10)
            make.right.equalTo(loginView.snp_right).offset(-80)
            make.height.equalTo(20)
        }
        
        let line = UILabel.init()
        line.backgroundColor = GlobalColor.lineColor
        loginView.addSubview(line)
        line.snp_makeConstraints { (make) in
            
            make.left.equalTo(20)
            make.right.equalTo(loginView.snp_right)
            make.top.equalTo(pwdLabel.snp_bottom).offset(10)
            make.height.equalTo(0.5)
        }
        
        let button = UIButton.init()
        button.setBackgroundImage(GlobalImage.resizeImageWithEdge(image: "LoginGreenBigBtn", edge: UIEdgeInsetsMake(0, 15, 0, 15)), forState: UIControlState.Normal)
        button.setTitle("登录", forState: UIControlState.Normal)
        button.addTarget(self, action: #selector(LoginViewController.loginAction), forControlEvents: UIControlEvents.TouchUpInside)
        loginView.addSubview(button)
        button.snp_makeConstraints { (make) in
            
            make.top.equalTo(line.snp_bottom).offset(20)
            make.left.equalTo(20)
            make.right.equalTo(loginView.snp_right).offset(-20)
            make.height.equalTo(47)
        }
        
        let questionButton = UIButton.init()
        questionButton.setTitle("登录遇到问题?", forState: UIControlState.Normal)
        questionButton.setTitleColor(GlobalColor.RGB(r: 107, g: 125, b: 158), forState: UIControlState.Normal)
        questionButton.titleLabel?.font = UIFont.systemFontOfSize(16)
        loginView.addSubview(questionButton)
        questionButton.snp_makeConstraints { (make) in
            
            make.centerX.equalTo(loginView.snp_centerX)
            make.top.equalTo(button.snp_bottom).offset(30)
            make.width.equalTo(200)
            make.height.equalTo(20)
        }
        
        let moreButton = UIButton.init()
        moreButton.setTitle("更多", forState: UIControlState.Normal)
        moreButton.setTitleColor(GlobalColor.RGB(r: 107, g: 125, b: 158), forState: UIControlState.Normal)
        moreButton.titleLabel?.font = UIFont.systemFontOfSize(18)
        moreButton.addTarget(self, action: #selector(LoginViewController.moreButtonTouch), forControlEvents: UIControlEvents.TouchUpInside)
        loginView.addSubview(moreButton)
        moreButton.snp_makeConstraints { (make) in
            
            make.centerX.equalTo(loginView.snp_centerX)
            make.bottom.equalTo(loginView.snp_bottom).offset(-30)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
    }
    
    func loginAction() {
        
        NSNotificationCenter.defaultCenter().postNotification(NSNotification.init(name: "LoginSuccess", object: nil))
    }
    
    func moreButtonTouch() {
        
        let actionController = ZXYActionSheetController.init(message: nil)
        actionController.addAction(ZXYAlertAction.init(title: "切换帐号...", style: ZXYAlertActionStyle.Default, handle: { (action:ZXYAlertAction) in
            print("切换帐号")
            
        }))
        actionController.addAction(ZXYAlertAction.init(title: "注册", style: ZXYAlertActionStyle.Default, handle: { (action:ZXYAlertAction) in
            print("注册")
            
        }))
        actionController.addAction(ZXYAlertAction.init(title: "前往微信安全中心", style: ZXYAlertActionStyle.Default, handle: { (action:ZXYAlertAction) in
            print("前往微信安全中心")
            
        }))
        actionController.addAction(ZXYAlertAction.init(title: "取消", style: ZXYAlertActionStyle.Cancel, handle: { (action:ZXYAlertAction) in
            print("取消")
        }))
        self.presentViewController(actionController, animated: false, completion:nil)
    }
    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        self.setEditing(true, animated: true)
//    }
}
