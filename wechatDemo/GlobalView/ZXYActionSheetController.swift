//
//  ZXYActionSheetController.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 16/8/16.
//  Copyright © 2016年 zhixueyun. All rights reserved.
//

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class ZXYActionSheetController: UIViewController {

    var control: UIControl!
    var titleString: String?
    var bottomView: UIView!
    
    let animateTime = 0.25
    
    var actionList = [ZXYAlertAction]()
    
    init(message: String?){
        
        super.init(nibName: nil, bundle: nil)
        titleString = message
        self.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    func addAction(_ action: ZXYAlertAction)  {
        
        actionList.append(action)
    }
    
    func initControl() {
        
        
        control = UIControl.init(frame: GlobalDevice.screenBounds)
        self.view.addSubview(control)
        control.backgroundColor = UIColor.black
        control.alpha = 0
        control.addTarget(self, action: #selector(ZXYActionSheetController.controlTouch), for: UIControl.Event.touchUpInside)
        UIView.animate(withDuration: animateTime, animations: {
            self.control.alpha = 0.5
        }) 
    }
    
    func initBottomView() {
        
        var isHaveTitle = false
        if titleString?.utf8.count > 0 {
            isHaveTitle = true
        }
        
        var heightOfTitle: CGFloat = 0
        
        if isHaveTitle {
            
            let attributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14)]
            let string = NSString(cString: titleString!, encoding: String.Encoding.utf8.rawValue)
            let rectOfTitle: CGRect = (string?.boundingRect(with: CGSize(width: GlobalDevice.screenWidth - 40, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes, context: nil))! as CGRect
            heightOfTitle = rectOfTitle.size.height + 40
        }
        
        let heightOfActionButton: CGFloat = 44.0
        
        let heightOfBottomView = heightOfTitle + CGFloat(actionList.count)*(heightOfActionButton+1)+5.0
        
        let bottomView = UIView.init(frame: CGRect(x: 0, y: GlobalDevice.screenHeight-heightOfBottomView, width: GlobalDevice.screenWidth, height: heightOfBottomView))
        bottomView.backgroundColor = UIColor.white
        self.view.addSubview(bottomView)
        self.bottomView = bottomView
        
        if isHaveTitle {
            let titleLabel = UILabel.init(frame: CGRect(x: 20, y: 0, width: GlobalDevice.screenWidth - 40, height: heightOfTitle))
            titleLabel.backgroundColor = UIColor.clear
            titleLabel.numberOfLines = 0
            titleLabel.textAlignment = NSTextAlignment.center
            titleLabel.textColor = GlobalColor.headerTitleColor
            titleLabel.text = titleString
            titleLabel.font = UIFont.systemFont(ofSize: 14)
            bottomView.addSubview(titleLabel)
        }
        
        let heightOfTop = heightOfTitle
        
        for index in 0...(actionList.count-1) {
            
            let line: UILabel!
            if index == actionList.count-1 {
                
                line = UILabel.init(frame: CGRect(x: 0, y: heightOfTop+CGFloat(index)*(heightOfActionButton+1), width: GlobalDevice.screenWidth, height: 5))
                line.backgroundColor = GlobalColor.bgColor
                bottomView.addSubview(line)
            }else{
                line = UILabel.init(frame: CGRect(x: 0, y: heightOfTop+CGFloat(index)*(heightOfActionButton+1), width: GlobalDevice.screenWidth, height: 1))
                line.backgroundColor = GlobalColor.lineColor
                bottomView.addSubview(line)
            }
            
            let button = UIButton.init(type: UIButton.ButtonType.custom)
            button.frame = CGRect(x: 0, y: line.frame.maxY, width: GlobalDevice.screenWidth, height: heightOfActionButton)
            bottomView.addSubview(button)
            button.addTarget(self, action: #selector(ZXYActionSheetController.buttonTouch(_:)), for: UIControl.Event.touchUpInside)
            button.tag = 10 + index
            let action = actionList[index]
            button.setTitle(action._title, for: UIControl.State.normal)
            button.setBackgroundImage(GlobalImage.imageWithColor(GlobalColor.RGB(r: 247, g: 247, b: 247), size: CGSize(width: 10, height: 10)), for: UIControl.State.highlighted)
            
            if action._stype == ZXYAlertActionStyle.destructive {
                button.setTitleColor(GlobalColor.RGB(r: 233, g: 83, b: 78), for: UIControl.State.normal)
            }else if action._stype == ZXYAlertActionStyle.cancel{
                button.setTitleColor(UIColor.black, for: UIControl.State.normal)
            }else if action._stype == ZXYAlertActionStyle.default{
                button.setTitleColor(UIColor.black, for: UIControl.State.normal)
            }else{
                button.setTitleColor(UIColor.black, for: UIControl.State.normal)
            }
        }
        
        let afterRectOfButtomView = bottomView.frame
        
        var beginRectOfButtonView = bottomView.frame
        beginRectOfButtonView.origin.y = GlobalDevice.screenHeight
        self.bottomView.frame = beginRectOfButtonView
        
        UIView.animate(withDuration: animateTime, animations: {
            self.bottomView.frame = afterRectOfButtomView
        }) 
    }
    
    @objc func buttonTouch(_ btn: UIButton) {
        
        let action = actionList[btn.tag - 10]
        action._handle!(action)
        self.controlTouch()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear
        self.edgesForExtendedLayout = UIRectEdge()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        self.initControl()
        self.initBottomView()
    }
    
    func removeSubViewsOfBottomView() {
        
        for subView in self.bottomView.subviews {
            subView.removeFromSuperview()
        }
    }
    
    func disMissAndRemoveSubViews(_ callBack: @escaping ()->Void) {
        
        var afterControlRect = bottomView.frame
        afterControlRect.origin.y = GlobalDevice.screenHeight
        UIView.animate(withDuration: animateTime, animations: {
            
            self.bottomView.frame = afterControlRect
            self.control.alpha = 0
        }, completion: { (bl: Bool) in
            
            self.removeSubViewsOfBottomView()
            self.bottomView.removeFromSuperview()
            self.control.removeFromSuperview()
            
            callBack()
        }) 
    }
    
    @objc func controlTouch() {
        
        self.disMissAndRemoveSubViews { 
            self.dismiss(animated: false, completion: nil)
        }
    }
    
}
