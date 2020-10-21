//
//  TextCenterCell.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 16/8/16.
//  Copyright © 2016年 zhixueyun. All rights reserved.
//

import UIKit

class TextCenterCell: UITableViewCell {

    internal static let cellIdentifier = "TextCenterCellIdentifier"
    
    static let cellHeight: CGFloat = 44.0
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
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
    
    func configforContactObject(_ message: String) {
        
        titleLabel.text = message
    }
    
    internal class func heightForCell() -> CGFloat {
        
        return 44.0
    }

}
