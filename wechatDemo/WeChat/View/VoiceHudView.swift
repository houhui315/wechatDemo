//
//  VoiceHudView.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 16/8/19.
//  Copyright © 2016年 zhixueyun. All rights reserved.
//

import UIKit

class VoiceHudView: UIView {

    var changeIconImageView: UIImageView!
    var bottomTextlabel: UILabel!
    var iconImageView: UIImageView!
    var cancelImageView: UIImageView!
    var bottomView: UIView!
    
    override init(frame: CGRect) {
        
        var rect = GlobalDevice.screenBounds;
        rect.size.height -= 50;
        super.init(frame: rect)
        self.backgroundColor = UIColor.clearColor()
        self.initSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initSubViews() {
        
        let hud = UIView.init()
        hud.backgroundColor = UIColor.blackColor();
        hud.alpha = 0.5
        hud.layer.masksToBounds = true
        hud.layer.cornerRadius = 5
        self.addSubview(hud)
        hud.snp_makeConstraints { (make) in
            
            make.center.equalTo(self.snp_center)
            make.size.equalTo(CGSizeMake(150, 150))
        }
        
        let iconImageView = UIImageView.init()
        iconImageView.image = UIImage.init(named: "RecordingBkg")
        self.iconImageView = iconImageView
        hud.addSubview(iconImageView)
        iconImageView.snp_makeConstraints { (make) in
            
            make.left.equalTo(25)
            make.top.equalTo(20)
            make.size.equalTo(CGSizeMake(62, 100))
        }
        
        var imageArray = [UIImage]()
        
        for index in 1...8 {
            
            let string = "RecordingSignal00\(index)"
            let image = UIImage.init(named: string)
            imageArray.append(image!)
        }
        
        let changeIconImagView = UIImageView.init()
        changeIconImagView.animationImages = imageArray
        changeIconImagView.animationDuration = 4
        changeIconImagView.startAnimating()
        changeIconImageView = changeIconImagView
        hud.addSubview(changeIconImagView)
        changeIconImagView.snp_makeConstraints { (make) in
            
            make.left.equalTo(iconImageView.snp_right)
            make.top.equalTo(iconImageView.snp_top)
            make.size.equalTo(CGSizeMake(38, 100))
        }
        
        let bottomView = UIView.init()
        bottomView.backgroundColor = GlobalColor.RGB(r: 157, g: 46, b: 54)
        bottomView.layer.masksToBounds = true
        bottomView.layer.cornerRadius = 2
        self.bottomView = bottomView
        hud.addSubview(bottomView)
        bottomView.snp_makeConstraints { (make) in
            
            make.left.equalTo(5)
            make.right.equalTo(hud.snp_right).offset(-5)
            make.bottom.equalTo(-10)
            make.height.equalTo(20)
        }
        
        let bottomLabel = UILabel.init()
        bottomLabel.backgroundColor = UIColor.clearColor()
        bottomLabel.textColor = GlobalColor.RGBA(r: 255, g: 255, b: 255, a: 0.8)
        bottomLabel.textAlignment = NSTextAlignment.Center
        bottomLabel.text = "手指上滑，取消发送"
        bottomLabel.font = UIFont.systemFontOfSize(14)
        bottomTextlabel = bottomLabel
        hud.addSubview(bottomLabel)
        bottomLabel.snp_makeConstraints { (make) in
            
            make.bottom.equalTo(hud.snp_bottom).offset(-10)
            make.left.equalTo(0)
            make.right.equalTo(hud.snp_right)
            make.height.equalTo(20)
        }
        
        let cancelImageView = UIImageView.init()
        cancelImageView.image = UIImage.init(named: "RecordCancel")
        self.cancelImageView = cancelImageView
        hud.addSubview(cancelImageView)
        cancelImageView.snp_makeConstraints { (make) in
            
            make.centerX.equalTo(hud.snp_centerX)
            make.centerY.equalTo(hud.snp_centerY).offset(-10)
            make.size.equalTo(CGSizeMake(100, 100))
        }
        
        cancelImageView.hidden = true
        bottomView.hidden = true
    }
    
    func showNormalStatus() {
        
        bottomTextlabel.text = "手指上滑，取消发送"
        cancelImageView.hidden = true
        bottomView.hidden = true
        
        self.iconImageView.hidden = false
        self.changeIconImageView.hidden = false
        self.changeIconImageView.startAnimating()
    }
    
    func showCancelStatus() {
        
        bottomTextlabel.text = "放开手指，取消发送"
        cancelImageView.hidden = false
        bottomView.hidden = false
        
        self.iconImageView.hidden = true
        self.changeIconImageView.hidden = true
        self.changeIconImageView.stopAnimating()
    }
    
    func showInWindow() {
        
        UIApplication.sharedApplication().keyWindow!.addSubview(self)
    }
    
    func removeFromWindow() {
        
        changeIconImageView.removeFromSuperview()
        bottomTextlabel.removeFromSuperview()
        self.removeFromSuperview()
    }
}
