//
//  chatMessageModel.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 2017/3/24.
//  Copyright © 2017年 zhixueyun. All rights reserved.
//

import UIKit

class chatMessageModel: NSObject {
    
    @objc var senderAvatar: String? = nil
    @objc var senderIsMe: Bool = false
    @objc var messageType: String? = nil
    @objc var content: String? = nil
}
