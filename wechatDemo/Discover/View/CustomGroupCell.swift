//
//  CustomGroupCell.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 16/8/11.
//  Copyright © 2016年 zhixueyun. All rights reserved.
//

import UIKit
import SnapKit

class CustomGroupCell: UITableViewCell {

    internal static let cellIdentifier = "CustomGroupCellIdentifier"
    
    //图标
    var iconImageView: UIImageView!
    //标题
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
            make.width.equalTo(24)
            make.height.equalTo(24)
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
    
    func configforContactObject(_ message: CustomGroupModel) {
        
        iconImageView.image = UIImage.init(named: message.imageName!)
        titleLabel.text = message.title
    }
    
    internal class func heightForCell() -> CGFloat {
        
        return 44.0
    }
}
