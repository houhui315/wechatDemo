//
//  MsgExternItemView.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 2017/3/20.
//  Copyright © 2017年 zhixueyun. All rights reserved.
//

import UIKit

/**
 点击+出现的菜单选项
 */

class MsgExternItemView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var mybgButton:UIButton? = nil
    
    var myIndex:Int = 0

    init(frame: CGRect, title: String, img: String, idx:Int) {
        super.init(frame: frame)
        
        myIndex = idx
        
        let bgButton = UIButton.init()
        bgButton.setBackgroundImage(UIImage.init(named: "sharemore_other"), for: UIControl.State.normal)
        self.addSubview(bgButton)
        self.mybgButton = bgButton
        bgButton.snp.makeConstraints { (make) in
            
            make.left.top.right.equalToSuperview()
            make.height.equalTo(self.snp.width)
        }
        
        let iconImageView = UIImageView.init(image: UIImage.init(named: img))
        bgButton.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { (make) in
            
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        
        let titleLabel = UILabel.init()
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = title
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            
            make.top.equalTo(bgButton.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
