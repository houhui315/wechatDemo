//
//  EmojiKeyBoardView.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 2017/3/22.
//  Copyright © 2017年 zhixueyun. All rights reserved.
//

import UIKit

protocol EmojiKeyBoardViewDelegate {
    
    //选择emoji表情回调
    func emojiKeyBoardViewDidSelectEmojiWithName(emojiView :EmojiKeyBoardView, text :String)
    //点击删除按钮回调
    func emojiKeyBoardViewDidSelectDeleteButton(emojiView :EmojiKeyBoardView)
}

/**
 表情键盘
 */
class EmojiKeyBoardView: UIView,UIScrollViewDelegate {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var delegate: EmojiKeyBoardViewDelegate?
    
    var myScrollView: UIScrollView!
    var myPageControl:UIPageControl!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = GlobalColor.bgColor
        self.initSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
            make.height.equalTo(150)
        }
        
        let pageControl = UIPageControl.init()
        pageControl.addTarget(self, action: #selector(EmojiKeyBoardView.pageControlValueChanged(pageControl:)), for: UIControl.Event.valueChanged)
        self.addSubview(pageControl)
        self.myPageControl = pageControl
        pageControl.snp.makeConstraints { (make) in
            
            make.top.equalTo(self.myScrollView.snp.bottom)
            make.height.equalTo(20)
            make.left.right.equalToSuperview()
        }
        
        let deleteEmojiBtn = UIButton.init(type: UIButton.ButtonType.custom)
        deleteEmojiBtn.setImage(UIImage.init(named: "DeleteEmoticonBtn"), for: UIControl.State.normal)
        deleteEmojiBtn.addTarget(self, action: #selector(self.deleteEmojiButtonTouch), for: UIControl.Event.touchUpInside)
        self.addSubview(deleteEmojiBtn)
        deleteEmojiBtn.snp.makeConstraints { (make) in
            
            make.top.equalTo(pageControl.snp.bottom)
            make.right.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 32.0, height: 32.0))
        }
        
        self.initItems()
        
    }
    
    func initItems() {
        
        let buttonWidth = Float(40)
        let buttonHeight = buttonWidth
        
        var numberOfLine = Float(7)
        if GlobalDevice.screenWidth >= 320 {
            
            numberOfLine = Float(8)
        }else{
            numberOfLine = Float(7)
        }
        
        let numberOfRow = Float(3)
        
        let spaceWidth = Float((GlobalDevice.screenWidth - CGFloat(numberOfLine)*CGFloat(buttonWidth))/CGFloat(numberOfLine+1))
        
        let spaceHeight = Float(10)
        
        let path = Bundle.main.path(forResource: "emojiData", ofType: "plist")
        
        let dataAry = NSArray.init(contentsOfFile: path!)
        
        let count: Int = (dataAry?.count)!
        
        var pageCount: Int = 0
        
        if (count%Int(numberOfLine * numberOfRow) == 0) {
            
            pageCount = count/Int(numberOfLine * numberOfRow)
        }else{
            pageCount = count/Int(numberOfLine * numberOfRow) + 1
        }
        
        for index in 0 ..< count {
            
            //item在第几页
            let indexOfPage = index / Int(numberOfLine * numberOfRow)
            //item在当前页的index
            let indexOnPage = index % Int(numberOfLine * numberOfRow)
            
            let x = Float(indexOfPage)*Float(GlobalDevice.screenWidth) + Float(indexOnPage%Int(numberOfLine))*Float(spaceWidth+buttonWidth) + spaceWidth
            
            let y = Float(Int(indexOnPage)/Int(numberOfLine))*(buttonHeight + spaceHeight)
            
            let frame = CGRect.init(x: CGFloat(x), y: CGFloat(y), width: CGFloat(buttonWidth), height: CGFloat(buttonHeight))
            let data:NSDictionary = dataAry?.object(at: index) as! NSDictionary
            let name = data.object(forKey: "name") as! String
            let img = data.object(forKey: "img") as! String
            
            let itemView = EmojiButton.init(frame: frame, image: img, name: name, index: index)
            
            self.myScrollView.addSubview(itemView)
            itemView.addTarget(self, action: #selector(EmojiKeyBoardView.myButtonTouch(button:)), for: UIControl.Event.touchUpInside)
        }
        
        self.myPageControl.numberOfPages = pageCount
        self.myScrollView.contentSize = CGSize.init(width: GlobalDevice.screenWidth*CGFloat(self.myPageControl.numberOfPages), height: 0)
    }
    
    @objc func myButtonTouch(button: EmojiButton) {
        
        if (self.delegate != nil) {
            
            self.delegate?.emojiKeyBoardViewDidSelectEmojiWithName(emojiView: self, text: button.myName!)
        }
    }
    
    @objc func deleteEmojiButtonTouch() {
        
        if (self.delegate != nil) {
            
            self.delegate?.emojiKeyBoardViewDidSelectDeleteButton(emojiView: self)
        }
    }
    
    @objc func pageControlValueChanged(pageControl: UIPageControl){
        
        let x = GlobalDevice.screenWidth * CGFloat(pageControl.currentPage)
        self.myScrollView.setContentOffset(CGPoint.init(x: x, y: 0), animated: true)
    }
    
    //MARK: - UIScrollViewDelegate method
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let page = Int(scrollView.contentOffset.x/GlobalDevice.screenWidth)
        self.myPageControl.currentPage = page
    }
}
