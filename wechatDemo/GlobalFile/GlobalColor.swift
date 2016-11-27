//
//  GlobalColor.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 16/8/12.
//  Copyright © 2016年 zhixueyun. All rights reserved.
//

import UIKit

//定义全局的颜色值

class GlobalColor: NSObject {

    internal static let navTitleColor = UIColor.white
    
    internal static let navBarBgColor = GlobalColor.RGB(r: 20, g: 20, b: 20)
    
    internal static let bgColor: UIColor = GlobalColor.RGB(r: 239, g: 239, b: 244)
    
    internal static let lineColor: UIColor = GlobalColor.RGB(r: 225, g: 225, b: 225)
    
    internal static let headerTitleColor: UIColor = GlobalColor.RGB(r: 169, g: 169, b: 169)
    
    internal static let sectionIndexColor: UIColor = GlobalColor.RGB(r: 85, g: 85, b: 85)
    
    internal static let controlBgColor: UIColor = GlobalColor.RGBA(r: 0, g: 0, b: 0, a: 0.5)
    
    internal class func RGB(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor{
        
        return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
    }
    
    internal class func RGBA(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor{
        
        return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
}
