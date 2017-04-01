//
//  TextMessageCell.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 2017/3/31.
//  Copyright © 2017年 zhixueyun. All rights reserved.
//

import UIKit

class TextMessageCell: BaseMessageCell {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    internal static let cellIdentifier = "TextMessageCellIdentifier"
    
    var myTextLabel: UILabel? = nil
    var backGroundImageView: UIImageView? = nil

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func updateConstraints() {
        
        super.updateConstraints()
        
        let size = self.compomentTextSize(theString: (self.myModel?.content)!)
        
        if !(self.myModel?.senderIsMe)! {
            self.myTextLabel?.snp.updateConstraints({ (make) in
                
                make.left.equalTo(70)
                make.size.equalTo(size)
            })
            
            self.backGroundImageView?.image = UIImage.init(named: "ReceiverTextNodeBkg")?.stretchableImage(withLeftCapWidth: 65/2, topCapHeight: 80/2)
            
        }else{
            self.myTextLabel?.snp.updateConstraints({ (make) in
                
                make.left.equalTo(GlobalDevice.screenWidth-65.0-size.width)
                make.size.equalTo(size)
            })
            self.backGroundImageView?.image = UIImage.init(named: "SenderTextNodeBkg")?.stretchableImage(withLeftCapWidth: 65/2, topCapHeight: 80/2)
        }
    }
    
    override func initSubViews() {
        
        super.initSubViews()
        
        let textlabel = UILabel.init()
        textlabel.font = UIFont.systemFont(ofSize: 15)
        textlabel.numberOfLines = 0
        self.contentView.addSubview(textlabel)
        self.myTextLabel = textlabel
        textlabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(70)
            make.top.equalTo(25)
            make.size.equalTo(CGSize.init(width: GlobalDevice.screenWidth - 100 - 60, height: 20))
        }
        
        let bgImageView = UIImageView.init()
        self.contentView.addSubview(bgImageView)
        self.backGroundImageView = bgImageView
        bgImageView.snp.makeConstraints { (make) in
            
            make.left.equalTo(textlabel).offset(-15)
            make.top.equalTo(textlabel).offset(-10)
            make.right.equalTo(textlabel).offset(15)
            make.bottom.equalTo(textlabel).offset(15)
        }
        
        self.contentView.bringSubview(toFront: textlabel)
    }
    
    func compomentTextSize(theString: String) -> CGSize {
        
        let font = UIFont.systemFont(ofSize: 15)
        let maxWidth = GlobalDevice.screenWidth - 100 - 60
        
        let testLabel = UILabel.init()
        testLabel.numberOfLines = 0
        testLabel.text = theString
        testLabel.font = font
        let size = testLabel.sizeThatFits(CGSize.init(width: maxWidth, height: 300))
        
        return size
        
    }
    
    internal class func heightForCell(theString: String) -> CGFloat {
        
        let font = UIFont.systemFont(ofSize: 15)
        let maxWidth = GlobalDevice.screenWidth - 100 - 60
        
        let testLabel = UILabel.init()
        testLabel.numberOfLines = 0
        testLabel.text = theString
        testLabel.font = font
        let size = testLabel.sizeThatFits(CGSize.init(width: maxWidth, height: 300))
        
        let height = size.height + 40.0
        
        return height
    }
    
    override func configForBaseModel(model: chatMessageModel) {
        super.configForBaseModel(model: model)
        self.myTextLabel?.text = self.myModel?.content
        
        self.myTextLabel?.sizeToFit()
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
}
