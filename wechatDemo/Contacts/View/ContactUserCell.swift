//
//  contactUserCell.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 16/8/15.
//  Copyright © 2016年 zhixueyun. All rights reserved.
//

import UIKit
import SnapKit

class ContactUserCell: UITableViewCell {

    internal static let cellIdentifier = "ContactUserCellIdentifier"
    
    //头像
    var avatarImageView: UIImageView!
    //姓名
    var userNameLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.initSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    func initSubViews() {
        
        avatarImageView = UIImageView.init()
        self.contentView.addSubview(avatarImageView)
        avatarImageView.snp_makeConstraints { (make) in
            
            make.left.equalTo(10)
            make.top.equalTo(10)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        userNameLabel = UILabel.init()
        userNameLabel.backgroundColor = UIColor.clearColor()
        userNameLabel.textColor = UIColor.blackColor()
        userNameLabel.font = UIFont.systemFontOfSize(16)
        self.contentView.addSubview(userNameLabel)
        userNameLabel.snp_makeConstraints { (make) in
            
            make.left.equalTo(avatarImageView.snp_right).offset(10)
            make.centerY.equalTo(self.contentView.snp_centerY)
            make.right.equalTo(self.contentView.snp_right)
            make.height.equalTo(20)
        }
    }
    
    func configforContactObject(message: UserContactModel) {
        
        avatarImageView.image = UIImage.init(named: message.avatarString!)
        userNameLabel.text = message.userNameString
    }
    
    internal class func heightForCell() -> CGFloat {
        
        return 60.0
    }
}
