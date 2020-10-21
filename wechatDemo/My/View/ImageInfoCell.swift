//
//  ImageInfoCell.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 16/8/15.
//  Copyright © 2016年 zhixueyun. All rights reserved.
//

import UIKit

class ImageInfoCell: UITableViewCell {

    internal static let cellIdentifier = "ImageInfoCellIdentifier"
    
    static let cellHeight: CGFloat = 44.0
    
    //图标
    var iconImageView: UIImageView!
    //标题
    var titleLabel: UILabel!
    //微信id
    var wechatIdLabel: UILabel!
    
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
        titleLabel.text = "我的二维码"
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
        
        let qrImageView = UIImageView.init()
        qrImageView.image = UIImage.init(named: "setting_myQR")
        self.contentView.addSubview(qrImageView)
        qrImageView.snp.makeConstraints { (make) in
            
            make.right.equalTo(arrowImageView.snp.left).offset(-10)
            make.centerY.equalTo(arrowImageView.snp.centerY)
            make.width.equalTo(18)
            make.height.equalTo(18)
        }
    }
    
    internal class func heightForCell() -> CGFloat {
        
        return cellHeight
    }
}
