//
//  ContactCell.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 16/8/11.
//  Copyright © 2016年 zhixueyun. All rights reserved.
//

import UIKit
import SnapKit

class ContactCell: UITableViewCell {

    internal static let cellIdentifier = "ContactCellIdentifier"
    
    //图标
    var iconImageView: UIImageView!
    //时间
    var titleLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.initSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    func initSubViews() {
        
        iconImageView = UIImageView.init()
        self.contentView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { (make) in
            
            make.left.equalTo(10)
            make.top.equalTo(10)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        titleLabel = UILabel.init()
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(iconImageView.snp.right).offset(10)
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.right.equalTo(self.contentView.snp.right)
            make.height.equalTo(20)
        }
    }
    
    func configforContactObject(_ message: ContactModel) {
        
        iconImageView.image = UIImage.init(named: message.imageName!)
        titleLabel.text = message.title
    }
    
    internal class func heightForCell() -> CGFloat {
        
        return 60.0
    }
}
