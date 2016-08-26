//
//  TextInfoNoArrowCell.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 16/8/15.
//  Copyright © 2016年 zhixueyun. All rights reserved.
//

import UIKit

class TextInfoNoArrowCell: UITableViewCell {

    internal static let cellIdentifier = "TextInfoNoArrowCellIdentifier"
    
    static let cellHeight: CGFloat = 44.0
    //标题
    var titleLabel: UILabel!
    //内容
    var contentLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.initSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    func initSubViews() {
        
        titleLabel = UILabel.init()
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.font = UIFont.systemFontOfSize(16)
        self.contentView.addSubview(titleLabel)
        titleLabel.snp_makeConstraints { (make) in
            
            make.left.equalTo(15)
            make.centerY.equalTo(self.contentView.snp_centerY)
            make.width.equalTo(150)
            make.height.equalTo(20)
        }
        
        contentLabel = UILabel.init()
        contentLabel.backgroundColor = UIColor.clearColor()
        contentLabel.textColor = GlobalColor.headerTitleColor
        contentLabel.font = UIFont.systemFontOfSize(14)
        contentLabel.textAlignment = NSTextAlignment.Right
        self.contentView.addSubview(contentLabel)
        contentLabel.snp_makeConstraints { (make) in
            
            make.left.equalTo(titleLabel.snp_right).offset(5)
            make.centerY.equalTo(self.contentView.snp_centerY)
            make.right.equalTo(self.contentView.snp_right).offset(-10)
            make.height.equalTo(20)
        }
    }
    
    func configforContactObject(message: TextInfoModel) {
        
        titleLabel.text = message.titleString
        contentLabel.text = message.contentString
    }
    
    internal class func heightForCell() -> CGFloat {
        
        return 44.0
    }
}
