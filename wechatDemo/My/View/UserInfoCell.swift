//
//  UserInfoCell.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 16/8/12.
//  Copyright © 2016年 zhixueyun. All rights reserved.
//

import UIKit

class UserInfoCell: UITableViewCell {

    internal static let cellIdentifier = "UserInfoCellIdentifier"
    
    static let cellHeight: CGFloat = 88.0
    
    //图标
    var iconImageView: UIImageView!
    //标题
    var titleLabel: UILabel!
    //微信id
    var wechatIdLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.initSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    func initSubViews() {
        
        iconImageView = UIImageView.init()
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.cornerRadius = 4
        self.contentView.addSubview(iconImageView)
        iconImageView.snp_makeConstraints { (make) in
            
            make.left.equalTo(10)
            make.top.equalTo(10)
            make.width.equalTo(UserInfoCell.cellHeight - 20)
            make.height.equalTo(UserInfoCell.cellHeight - 20)
        }
        
        let arrowImageView = UIImageView.init()
        arrowImageView.image = UIImage.init(named: "tableview_arrow")
        self.contentView.addSubview(arrowImageView)
        arrowImageView.snp_makeConstraints { (make) in
            
            make.right.equalTo(self.contentView.snp_right).offset(-10)
            make.centerY.equalTo(self.contentView.snp_centerY)
            make.width.equalTo(8)
            make.height.equalTo(13)
        }
        
        let qrImageView = UIImageView.init()
        qrImageView.image = UIImage.init(named: "setting_myQR")
        self.contentView.addSubview(qrImageView)
        qrImageView.snp_makeConstraints { (make) in
            
            make.right.equalTo(arrowImageView.snp_left).offset(-10)
            make.centerY.equalTo(arrowImageView.snp_centerY)
            make.width.equalTo(18)
            make.height.equalTo(18)
        }
        
        titleLabel = UILabel.init()
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.font = UIFont.systemFontOfSize(16)
        self.contentView.addSubview(titleLabel)
        titleLabel.snp_makeConstraints { (make) in
            
            make.left.equalTo(iconImageView.snp_right).offset(10)
            make.top.equalTo(self.contentView.snp_top).offset(20)
            make.right.equalTo(qrImageView.snp_left).offset(-10)
            make.height.equalTo(20)
        }
        
        wechatIdLabel = UILabel.init()
        wechatIdLabel.backgroundColor = UIColor.clearColor()
        wechatIdLabel.textColor = UIColor.blackColor()
        wechatIdLabel.font = UIFont.systemFontOfSize(16)
        self.contentView.addSubview(wechatIdLabel)
        wechatIdLabel.snp_makeConstraints { (make) in
            
            make.left.equalTo(titleLabel.snp_left)
            make.top.equalTo(titleLabel.snp_bottom).offset(10)
            make.right.equalTo(titleLabel.snp_right)
            make.height.equalTo(20)
        }
    }
    
    func configforContactObject(message: UserInfoModel) {
        
        iconImageView.image = UIImage.init(named: message.avatarImageName!)
        titleLabel.text = message.userName
        wechatIdLabel.text = "微信号：\(message.wechatID!)"
    }
    
    internal class func heightForCell() -> CGFloat {
        
        return cellHeight
    }
}