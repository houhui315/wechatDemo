//
//  UserContactModel.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 16/8/15.
//  Copyright © 2016年 zhixueyun. All rights reserved.
//

import Foundation

class UserContactModel: NSObject {

    var avatarString: String?
    var userNameString: String?
    init(avatarString:String, userNameString:String) {
        
        self.avatarString = avatarString
        self.userNameString = userNameString
    }
}
