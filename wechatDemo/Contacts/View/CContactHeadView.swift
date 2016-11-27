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
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = GlobalColor.headerTitleColor
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(self.contentView.snp.left).offset(10)
            make.top.equalTo(self.contentView.snp.top)
            make.right.equalTo(self.contentView.snp.right)
            make.bottom.equalTo(self.contentView.snp.bottom)
        }
        
        self.contentView.backgroundColor = GlobalColor.bgColor
    }
    
    func configforContactObject(_ message: String) {
        
        titleLabel.text = message
    }
    
    internal class func heightForView() -> CGFloat {
        
        return 20.0
    }
}
