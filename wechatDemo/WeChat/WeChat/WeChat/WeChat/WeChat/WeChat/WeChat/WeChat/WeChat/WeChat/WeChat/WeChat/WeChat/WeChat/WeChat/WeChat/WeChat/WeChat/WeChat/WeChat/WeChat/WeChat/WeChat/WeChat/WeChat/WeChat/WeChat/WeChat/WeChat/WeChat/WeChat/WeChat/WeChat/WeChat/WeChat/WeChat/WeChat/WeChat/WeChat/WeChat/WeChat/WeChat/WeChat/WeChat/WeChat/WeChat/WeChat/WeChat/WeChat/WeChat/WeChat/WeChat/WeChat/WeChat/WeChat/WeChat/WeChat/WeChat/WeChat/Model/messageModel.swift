//
//  messageModel.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 16/8/11.
//  Copyright © 2016年 zhixueyun. All rights reserved.
//

import Foundation

class messageModel: NSObject {

    var imageName: String?
    var title: String?
    var content: String?
    var time: String?
    
    init(imageName:String, title:String, content:String, time:String) {
        
        self.imageName = imageName
        self.title = title
        self.content = content
        self.time = time
    }
}
