//
//  AppDelegate.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 16/8/10.
//  Copyright © 2016年 zhixueyun. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func tabbarItemConfig(_ item: UITabBarItem, imageString : String, selectedImageString: String) -> Void {
        
        item.image = GlobalImage.renderImageWithImageName(imageString)
        item.selectedImage = GlobalImage.renderImageWithImageName(selectedImageString)
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow.init(frame: GlobalDevice.screenBounds)
        
//        self.initLoginViewController()
        self.initHomeViewController()
        window!.makeKeyAndVisible()
        
        let noti = NotificationCenter.default
        noti.addObserver(self, selector: #selector(AppDelegate.initHomeViewController), name: NSNotification.Name(rawValue: "LoginSuccess"), object: nil)
        noti.addObserver(self, selector: #selector(AppDelegate.initLoginViewController), name: NSNotification.Name(rawValue: "LogoutSuccess"), object: nil)
        
        return true
    }

    @objc func initHomeViewController() {
        
        let wechatViewController = WeChatTableViewController(style: UITableView.Style.plain)
        wechatViewController.title = "微信"
        
        let nav1 = ZXYNavigationController.init(rootViewController: wechatViewController)
        
        let contactsViewController = ContactTableViewController(style: UITableView.Style.plain)
        contactsViewController.title = "通讯录"
        let nav2 = ZXYNavigationController.init(rootViewController: contactsViewController)
        
        let discoverViewController = DiscoverTableViewController(style: UITableView.Style.grouped)
        discoverViewController.title = "发现"
        let nav3 = ZXYNavigationController.init(rootViewController: discoverViewController)
        
        let myViewController = MyTableViewController(style: UITableView.Style.grouped)
        myViewController.title = "我"
        let nav4 = ZXYNavigationController.init(rootViewController: myViewController)
        
        let tabbarController = UITabBarController()
        tabbarController.viewControllers = [nav1,nav2, nav3, nav4]
        
        let tabBar = tabbarController.tabBar;
        tabBar.isTranslucent = false
        tabBar.tintColor = GlobalColor.RGB(r: 9, g: 187, b: 7)
        tabBar.backgroundImage = GlobalImage.renderImageWithImageName("tabbarBkg")
        
        for (index, value) in (tabBar.items?.enumerated())! {
            
            switch index {
            case 0:
                self.tabbarItemConfig(value, imageString: "tabbar_mainframe", selectedImageString: "tabbar_mainframeHL")
            case 1:
                self.tabbarItemConfig(value, imageString: "tabbar_contacts", selectedImageString: "tabbar_contactsHL")
            case 2:
                self.tabbarItemConfig(value, imageString: "tabbar_discover", selectedImageString: "tabbar_discoverHL")
            case 3:
                self.tabbarItemConfig(value, imageString: "tabbar_me", selectedImageString: "tabbar_meHL")
            default:
                print("111");
            }
        }
        
        window!.rootViewController = tabbarController
    }
    
    @objc func initLoginViewController() {
        
        let loginVC = LoginViewController()
        window!.rootViewController = loginVC
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

