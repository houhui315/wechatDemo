//
//  textInfoCell.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 16/8/15.
//  Copyright © 2016年 zhixueyun. All rights reserved.
//

import UIKit

class TextInfoCell: UITableViewCell {

    internal static let cellIdentifier = "TextInfoCellIdentifier"
    
    static let cellHeight: CGFloat = 44.0
    //标题
    var titleLabel: UILabel!
    //内容
    var contentLabel: UILabel!
    
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
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(15)
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.width.equalTo(150)
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
        
        contentLabel = UILabel.init()
        contentLabel.backgroundColor = UIColor.clear
        contentLabel.textColor = GlobalColor.headerTitleColor
        contentLabel.font = UIFont.systemFont(ofSize: 14)
        contentLabel.textAlignment = NSTextAlignment.right
        self.contentView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(titleLabel.snp.right).offset(5)
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.right.equalTo(arrowImageView.snp.left).offset(-10)
            make.height.equalTo(20)
        }
    }
    
    func configforContactObject(_ message: TextInfoModel) {
        
        titleLabel.text = message.titleString
        contentLabel.text = message.contentString
    }
    
    internal class func heightForCell() -> CGFloat {
        
        return 44.0
    }
}
