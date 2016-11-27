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
        self.view.backgroundColor = UIColor.white
        
        self.initLoginView()
    }
    
    func initLoginView() {
        
        let loginView = UIView.init()
        self.view.addSubview(loginView)
        loginView.snp.makeConstraints { (make) in
            
            make.edges.equalTo(UIEdgeInsetsMake(GlobalDevice.navStatusBarHeight, 0, 0, 0))
        }
        
        let avatarImageView = UIImageView.init()
        loginView.addSubview(avatarImageView)
        avatarImageView.image = UIImage.init(named: "userinfoAvatar")
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = 4
        avatarImageView.snp.makeConstraints { (make) in
            
            make.top.equalTo(10)
            make.width.equalTo(80)
            make.height.equalTo(80)
            make.centerX.equalTo(loginView.snp.centerX)
        }
        
        let userNameLabel = UILabel.init()
        loginView.addSubview(userNameLabel)
        userNameLabel.text = "403262655"
        userNameLabel.textAlignment = NSTextAlignment.center
        userNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        userNameLabel.snp.makeConstraints { (make) in
            
            make.top.equalTo(avatarImageView.snp.bottom).offset(10)
            make.width.equalTo(loginView.snp.width)
            make.height.equalTo(20)
            make.centerX.equalTo(loginView.snp.centerX)
        }
        
        let pwdLabel = UILabel.init()
        pwdLabel.text = "密码"
        pwdLabel.font = UIFont.systemFont(ofSize: 18)
        loginView.addSubview(pwdLabel)
        pwdLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(20)
            make.top.equalTo(userNameLabel.snp.bottom).offset(40)
            make.width.equalTo(40)
            make.height.equalTo(20)
        }
        
        let pwdTextField = UITextField.init()
        pwdTextField.placeholder = "请填写密码"
        pwdTextField.textAlignment = NSTextAlignment.center
        pwdTextField.font = UIFont.systemFont(ofSize: 18)
        loginView.addSubview(pwdTextField)
        pwdTextField.snp.makeConstraints { (make) in
            
            make.top.equalTo(pwdLabel.snp.top)
            make.left.equalTo(pwdLabel.snp.right).offset(10)
            make.right.equalTo(loginView.snp.right).offset(-80)
            make.height.equalTo(20)
        }
        
        let line = UILabel.init()
        line.backgroundColor = GlobalColor.lineColor
        loginView.addSubview(line)
        line.snp.makeConstraints { (make) in
            
            make.left.equalTo(20)
            make.right.equalTo(loginView.snp.right)
            make.top.equalTo(pwdLabel.snp.bottom).offset(10)
            make.height.equalTo(0.5)
        }
        
        let button = UIButton.init()
        button.setBackgroundImage(GlobalImage.resizeImageWithEdge(image: "LoginGreenBigBtn", edge: UIEdgeInsetsMake(0, 15, 0, 15)), for: UIControlState())
        button.setTitle("登录", for: UIControlState())
        button.addTarget(self, action: #selector(LoginViewController.loginAction), for: UIControlEvents.touchUpInside)
        loginView.addSubview(button)
        button.snp.makeConstraints { (make) in
            
            make.top.equalTo(line.snp.bottom).offset(20)
            make.left.equalTo(20)
            make.right.equalTo(loginView.snp.right).offset(-20)
            make.height.equalTo(47)
        }
        
        let questionButton = UIButton.init()
        questionButton.setTitle("登录遇到问题?", for: UIControlState())
        questionButton.setTitleColor(GlobalColor.RGB(r: 107, g: 125, b: 158), for: UIControlState())
        questionButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        loginView.addSubview(questionButton)
        questionButton.snp.makeConstraints { (make) in
            
            make.centerX.equalTo(loginView.snp.centerX)
            make.top.equalTo(button.snp.bottom).offset(30)
            make.width.equalTo(200)
            make.height.equalTo(20)
        }
        
        let moreButton = UIButton.init()
        moreButton.setTitle("更多", for: UIControlState())
        moreButton.setTitleColor(GlobalColor.RGB(r: 107, g: 125, b: 158), for: UIControlState())
        moreButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        moreButton.addTarget(self, action: #selector(LoginViewController.moreButtonTouch), for: UIControlEvents.touchUpInside)
        loginView.addSubview(moreButton)
        moreButton.snp.makeConstraints { (make) in
            
            make.centerX.equalTo(loginView.snp.centerX)
            make.bottom.equalTo(loginView.snp.bottom).offset(-30)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
    }
    
    func loginAction() {
        
        NotificationCenter.default.post(Notification.init(name: Notification.Name(rawValue: "LoginSuccess"), object: nil))
    }
    
    func moreButtonTouch() {
        
        let actionController = ZXYActionSheetController.init(message: nil)
        actionController.addAction(ZXYAlertAction.init(title: "切换帐号...", style: ZXYAlertActionStyle.default, handle: { (action:ZXYAlertAction) in
            print("切换帐号")
            
        }))
        actionController.addAction(ZXYAlertAction.init(title: "注册", style: ZXYAlertActionStyle.default, handle: { (action:ZXYAlertAction) in
            print("注册")
            
        }))
        actionController.addAction(ZXYAlertAction.init(title: "前往微信安全中心", style: ZXYAlertActionStyle.default, handle: { (action:ZXYAlertAction) in
            print("前往微信安全中心")
            
        }))
        actionController.addAction(ZXYAlertAction.init(title: "取消", style: ZXYAlertActionStyle.cancel, handle: { (action:ZXYAlertAction) in
            print("取消")
        }))
        self.present(actionController, animated: false, completion:nil)
    }
    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        self.setEditing(true, animated: true)
//    }
}
