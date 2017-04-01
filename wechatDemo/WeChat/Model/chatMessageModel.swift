//
//  chatMessageModel.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 2017/3/24.
//  Copyright © 2017年 zhixueyun. All rights reserved.
//

import UIKit

class chatMessageModel: NSObject {
    
    var senderAvatar: String? = nil
    var senderIsMe: Bool = false
    var messageType: String? = nil
    var content: String? = nil
}
