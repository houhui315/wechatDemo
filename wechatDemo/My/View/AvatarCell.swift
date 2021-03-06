//
//  AvatarCell.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 16/8/15.
//  Copyright © 2016年 zhixueyun. All rights reserved.
//

import UIKit

class AvatarCell: UITableViewCell {

    internal static let cellIdentifier = "AvatarCellIdentifier"
    
    static let cellHeight: CGFloat = 88.0
    
    //图标
    var avatarImageView: UIImageView!
    //标题
    var titleLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.initSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    func initSubViews() {
        
        titleLabel = UILabel.init()
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.text = "头像"
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(15)
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.width.equalTo(150)
            make.height.equalTo(20)
        }
        
        avatarImageView = UIImageView.init()
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = 4
        self.contentView.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { (make) in
            
            make.right.equalTo(self.contentView.snp.right).offset(-28)
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.width.equalTo(AvatarCell.cellHeight - 20)
            make.height.equalTo(AvatarCell.cellHeight - 20)
        }
        
        let arrowImageView = UIImageView.init()
        arrowImageView.image = UIImage.init(named: "tableview_arrow")
        self.contentView.addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints { (make) in
            
            make.right.equalTo(self.contentView.snp.right).offset(-10)
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.width.equalTo(8)
            make.height.equalTo(13)
        }
    }
    
    func configforContactObject(_ message: String) {
        
        avatarImageView.image = UIImage.init(named: message)
    }
    
    internal class func heightForCell() -> CGFloat {
        
        return cellHeight
    }
}
