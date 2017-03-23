//
//  MsgExternView.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 2017/3/20.
//  Copyright © 2017年 zhixueyun. All rights reserved.
//

import UIKit

class MsgExternView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
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
        self.addSubview(scrollView)
        self.myScrollView =  scrollView
        scrollView.snp.makeConstraints { (make) in
            
            make.top.equalTo(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(200)
        }
        
        let pageControl = UIPageControl.init()
        pageControl.numberOfPages = 2
        self.addSubview(pageControl)
        self.myPageControl = pageControl
        pageControl.snp.makeConstraints { (make) in
            
            make.top.equalTo(self.myScrollView.snp.bottom)
            make.height.equalTo(20)
            make.left.right.equalToSuperview()
        }
    }
    
    func initItems() {
        
        
    }
}
