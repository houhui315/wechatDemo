//
//  ZXYAlertAction.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 16/8/16.
//  Copyright © 2016年 zhixueyun. All rights reserved.
//

import Foundation

public enum ZXYAlertActionStyle : Int {
    
    case Default
    case Cancel
    case Destructive
}

class ZXYAlertAction: NSObject {

    var _title: String?
    var _stype: ZXYAlertActionStyle!
    var _handle: ((ZXYAlertAction) -> Void)?
    
    init(title: String, style: ZXYAlertActionStyle,handle: ((ZXYAlertAction) -> Void)?) {
        
        _title = title
        _stype = style
        _handle = handle
    }
}
