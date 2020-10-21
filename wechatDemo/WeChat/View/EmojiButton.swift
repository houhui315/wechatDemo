//
//  EmojiButton.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 2017/3/22.
//  Copyright © 2017年 zhixueyun. All rights reserved.
//

import UIKit

class EmojiButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var myName: String? = nil
    
    init(frame: CGRect,image :String, name :String, index:Int) {
        
        super.init(frame: frame)
        self.myName = name
        self.setImage(UIImage.init(named: image), for: UIControl.State.normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
