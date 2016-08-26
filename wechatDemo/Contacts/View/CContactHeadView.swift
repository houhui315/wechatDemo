//
//  CContactHeadView.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 16/8/15.
//  Copyright © 2016年 zhixueyun. All rights reserved.
//

import UIKit
import SnapKit

class CContactHeadView: UITableViewHeaderFooterView {

    internal static let cellIdentifier = "CContactHeadViewIdentifier"
    
    var titleLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.initSubViews()
    }
    
    func initSubViews() {
        
        titleLabel = UILabel.init()
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.textColor = GlobalColor.headerTitleColor
        titleLabel.font = UIFont.systemFontOfSize(16)
        self.contentView.addSubview(titleLabel)
        titleLabel.snp_makeConstraints { (make) in
            
            make.left.equalTo(self.contentView.snp_left).offset(10)
            make.top.equalTo(self.contentView.snp_top)
            make.right.equalTo(self.contentView.snp_right)
            make.bottom.equalTo(self.contentView.snp_bottom)
        }
        
        self.contentView.backgroundColor = GlobalColor.bgColor
    }
    
    func configforContactObject(message: String) {
        
        titleLabel.text = message
    }
    
    internal class func heightForView() -> CGFloat {
        
        return 20.0
    }
}
