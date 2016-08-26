//
//  GlobalDevice.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 16/8/12.
//  Copyright © 2016年 zhixueyun. All rights reserved.
//

import UIKit

//定义设备信息

class GlobalDevice: NSObject {

    //屏幕宽度
    internal static let screenWidth: CGFloat = UIScreen.mainScreen().bounds.width
    //屏幕高度
    internal static let screenHeight: CGFloat = UIScreen.mainScreen().bounds.height
    //屏幕bounds
    internal static let screenBounds: CGRect = UIScreen.mainScreen().bounds
    //导航栏高度
    internal static let navBarHeight: CGFloat = 44.0
    //状态栏高度
    internal static let statusBar: CGFloat = 20.0
    //导航和状态栏总高度
    internal static let navStatusBarHeight = GlobalDevice.navBarHeight+GlobalDevice.statusBar
    //除去导航栏和状态栏的应用高度
    internal static let appFrameHeight: CGFloat = GlobalDevice.screenHeight-GlobalDevice.navStatusBarHeight
}
