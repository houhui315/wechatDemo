//
//  MessageCell.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 16/8/11.
//  Copyright © 2016年 zhixueyun. All rights reserved.
//

import UIKit
import SnapKit

class MessageCell: UITableViewCell {

    internal static let cellIdentifier = "messageCellIdentifier"
    
    //图标
    var iconImageView: UIImageView!
    //时间
    var timeLabel: UILabel!
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
        
        iconImageView = UIImageView.init()
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.cornerRadius = 4
        self.contentView.addSubview(iconImageView)
        iconImageView.snp_makeConstraints { (make) in
         
            make.left.equalTo(10)
            make.top.equalTo(10)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        timeLabel = UILabel.init()
        timeLabel.backgroundColor = UIColor.clearColor()
        timeLabel.textColor = GlobalColor.RGB(r: 169, g: 169, b: 169)
        timeLabel.textAlignment = NSTextAlignment.Right
        timeLabel.font = UIFont.systemFontOfSize(13)
        self.contentView.addSubview(timeLabel)
        timeLabel.snp_makeConstraints { (make) in
            
            make.top.equalTo(iconImageView.snp_top)
            make.width.lessThanOrEqualTo(100)
            make.right.equalTo(self.contentView.snp_right).offset(-10)
            make.height.equalTo(20)
        }
        
        titleLabel = UILabel.init()
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.font = UIFont.systemFontOfSize(16)
        self.contentView.addSubview(titleLabel)
        titleLabel.snp_makeConstraints { (make) in
            
            make.left.equalTo(iconImageView.snp_right).offset(10)
            make.top.equalTo(iconImageView.snp_top)
            make.right.equalTo(timeLabel.snp_left)
            make.height.equalTo(20)
        }

        contentLabel = UILabel.init()
        contentLabel.backgroundColor = UIColor.clearColor()
        contentLabel.textColor = GlobalColor.RGB(r: 169, g: 169, b: 169)
        contentLabel.font = UIFont.systemFontOfSize(14)
        self.contentView.addSubview(contentLabel)
        contentLabel.snp_makeConstraints { (make) in
            
            make.left.equalTo(titleLabel.snp_left)
            make.right.equalTo(self.contentView.snp_right).offset(-10)
            make.top.equalTo(titleLabel.snp_bottom)
            make.height.equalTo(20)
        }
        
    }
    
    func configforMessageObject(message: messageModel) {
        
        iconImageView.image = UIImage.init(named: message.imageName!)
        titleLabel.text = message.title
        timeLabel.text = message.time
        contentLabel.text = message.content
    }
    
    internal class func heightForCell() -> CGFloat {
        
        return 60.0
    }
}
