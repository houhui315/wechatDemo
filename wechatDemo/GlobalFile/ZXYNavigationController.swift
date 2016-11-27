//
//  ZXYNavigationController.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 16/8/11.
//  Copyright © 2016年 zhixueyun. All rights reserved.
//

import UIKit

class ZXYNavigationController: UINavigationController {

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.initConfig()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initConfig() {
        
        let navBar: UINavigationBar = UINavigationBar.appearance()
        navBar.barTintColor = GlobalColor.navBarBgColor
        navBar.tintColor = UIColor.white
        navBar.barStyle = UIBarStyle.black
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: GlobalColor.navTitleColor,NSFontAttributeName: GlobalFont.navTitleFont]
    }
    
}
