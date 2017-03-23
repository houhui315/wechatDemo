//
//  MoreFuncCell.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 16/8/12.
//  Copyright © 2016年 zhixueyun. All rights reserved.
//

import UIKit
import SnapKit

class MoreFuncCell: UITableViewCell {

    internal static let cellIdentifier = "MoreFuncCellIdentifier"
    
    var iconImageView: UIImageView!
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
            
            make.left.equalTo(12)
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
        
        titleLabel = UILabel.init()
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(iconImageView.snp.right).offset(15)
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.right.equalTo(self.contentView.snp.right)
            make.height.equalTo(20)
        }
        
        self.selectionStyle = UITableViewCellSelectionStyle.none
        
        self.backgroundColor = UIColor.clear
        self.backgroundView = nil
    }
    
    func congigforMoreAddModel(_ model: MoreAddModel) {
        
        iconImageView.image = UIImage.init(named: model.iconImageString!)
        titleLabel.text = model.titleString!
    }
    
    internal class func heightForCell() -> CGFloat {
        
        return 44
    }
}
