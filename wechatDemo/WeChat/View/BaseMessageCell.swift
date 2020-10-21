//
//  BaseMessageCell.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 2017/3/24.
//  Copyright © 2017年 zhixueyun. All rights reserved.
//

import UIKit

class BaseMessageCell: UITableViewCell {

    
    var isSender: Bool = false
    
    var msgAvatarView :UIButton? = nil
    
    var myModel: chatMessageModel? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.initSubViews()
        
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
    }
    
    override func updateConstraints() {
        
        if !(self.myModel?.senderIsMe)! {
            
            self.msgAvatarView?.snp.updateConstraints({ (make) in
                
                make.left.equalToSuperview().offset(10)
            })
            
        }else{
            
            self.msgAvatarView?.snp.updateConstraints({ (make) in
                
                make.left.equalTo(GlobalDevice.screenWidth-45)
            })
        }
        
        super.updateConstraints()
    }
    
    
    func initSubViews() {
        
        let avatarView = UIButton.init(type: .custom)
        avatarView.addTarget(self, action: #selector(self.avatarTouch), for: .touchUpInside)
        self.contentView.addSubview(avatarView)
        self.msgAvatarView = avatarView
        avatarView.snp.makeConstraints { (make) in
            
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(15)
            make.size.equalTo(CGSize.init(width: 40, height: 40))
        }
    }
    
    @objc func avatarTouch() {
        
        
    }
    
    func configForBaseModel(model : chatMessageModel) {
        
        self.myModel = model
        self.msgAvatarView?.setImage(UIImage.init(named: model.senderAvatar!), for: .normal)
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
