//
//  MsgExternView.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 2017/3/20.
//  Copyright © 2017年 zhixueyun. All rights reserved.
//

import UIKit

protocol MsgExternViewDelegate {
    
    func sendPictureFromAlbum()
    func sendPictureFromCamera()
    func sendVoiceInfo()
    func sendLocation()
    func sendLuckyMoney()
    func payMoney()
    func sendUserCard()
    func sendMyFavourite()
    func sendMyWallert()
}

/**
 点击+号出现功能菜单
 */

class MsgExternView: UIView,UIScrollViewDelegate {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var delegate: MsgExternViewDelegate?
    
    var myScrollView: UIScrollView!
    var myPageControl:UIPageControl!
    
    override init(frame: CGRect){
        
        super.init(frame: frame)
        self.initSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initSubViews() {
        
        let scrollView = UIScrollView.init()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        self.addSubview(scrollView)
        self.myScrollView = scrollView
        scrollView.snp.makeConstraints { (make) in
            
            make.top.equalTo(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(200)
        }
        
        let pageControl = UIPageControl.init()
        pageControl.numberOfPages = 2
        pageControl.addTarget(self, action: #selector(self.pageControlValueChanged(pageControl:)), for: UIControlEvents.valueChanged)
        self.addSubview(pageControl)
        self.myPageControl = pageControl
        pageControl.snp.makeConstraints { (make) in
            
            make.top.equalTo(self.myScrollView.snp.bottom)
            make.height.equalTo(20)
            make.left.right.equalToSuperview()
        }
        
        self.initItems()
    }
    
    func initItems() {
        
        let buttonWidth = Float(69)
        let boxHeight = Float(95)
        
        let numberOfLine = Float(4)
        let numberOfRow = Float(2)
        
        let spaceWidth = Float((GlobalDevice.screenWidth - CGFloat(numberOfLine)*CGFloat(buttonWidth))/CGFloat(numberOfLine+1))
        
        let spaceHeight = Float(10)
        
        let path = Bundle.main.path(forResource: "msgExtern", ofType: "plist")
        
        let dataAry = NSArray.init(contentsOfFile: path!)
        
        let count = dataAry?.count
        for index in 0 ..< count! {
            
            //item在第几页
            let indexOfPage = index / Int(numberOfLine * numberOfRow)
            //item在当前页的index
            let indexOnPage = index % Int(numberOfLine * numberOfRow)
            
            let x = Float(indexOfPage)*Float(GlobalDevice.screenWidth) + Float(indexOnPage%Int(numberOfLine))*Float(spaceWidth+buttonWidth) + spaceWidth
            
            let y = Float(Int(indexOnPage)/Int(numberOfLine))*(boxHeight + spaceHeight)
            
            let frame = CGRect.init(x: CGFloat(x), y: CGFloat(y), width: CGFloat(buttonWidth), height: CGFloat(boxHeight))
            let data:NSDictionary = dataAry?.object(at: index) as! NSDictionary
            let title = data.object(forKey: "title") as! String
            let img = data.object(forKey: "img") as! String
            
            let itemView = MsgExternItemView.init(frame: frame, title: title, img: img, idx: index)
            self.myScrollView.addSubview(itemView)
            itemView.mybgButton?.addTarget(self, action: #selector(MsgExternView.myButtonTouch(button:)), for: UIControlEvents.touchUpInside)
        }
        
        
        self.myScrollView.contentSize = CGSize.init(width: GlobalDevice.screenWidth*2, height: 0)
        
    }
    
    func myButtonTouch(button: UIButton) {
        
        let itemView = button.superview as! MsgExternItemView
        let index = itemView.myIndex
        
        switch index {
            case 0: self.delegate?.sendPictureFromAlbum()
            case 1: self.delegate?.sendPictureFromCamera()
            case 2: self.delegate?.sendVoiceInfo()
            case 3: self.delegate?.sendLocation()
            case 4: self.delegate?.sendLuckyMoney()
            case 5: self.delegate?.payMoney()
            case 6: self.delegate?.sendUserCard()
            case 7: self.delegate?.sendMyFavourite()
            case 8: self.delegate?.sendMyWallert()
            
            default: break
        }
    }
    
    func pageControlValueChanged(pageControl: UIPageControl){
        
        let x = GlobalDevice.screenWidth * CGFloat(pageControl.currentPage)
        self.myScrollView.setContentOffset(CGPoint.init(x: x, y: 0), animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let page = Int(scrollView.contentOffset.x/GlobalDevice.screenWidth)
        self.myPageControl.currentPage = page
    }
}


