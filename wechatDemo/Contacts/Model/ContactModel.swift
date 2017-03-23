//
//  ContactModel.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 16/8/11.
//  Copyright © 2016年 zhixueyun. All rights reserved.
//

import Foundation

class ContactModel: NSObject {

    var imageName: String?
    var title: String?
    
    init(imageName:String, title:String) {
        
        self.imageName = imageName
        self.title = title
    }
}
