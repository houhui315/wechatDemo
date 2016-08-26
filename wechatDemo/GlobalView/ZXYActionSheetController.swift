//
//  ZXYActionSheetController.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 16/8/16.
//  Copyright © 2016年 zhixueyun. All rights reserved.
//

import UIKit

class ZXYActionSheetController: UIViewController {

    var control: UIControl!
    var titleString: String?
    var bottomView: UIView!
    
    let animateTime = 0.25
    
    var actionList = [ZXYAlertAction]()
    
    init(message: String?){
        
        super.init(nibName: nil, bundle: nil)
        titleString = message
        self.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    func addAction(action: ZXYAlertAction)  {
        
        actionList.append(action)
    }
    
    func initControl() {
        
        
        control = UIControl.init(frame: GlobalDevice.screenBounds)
        self.view.addSubview(control)
        control.backgroundColor = UIColor.blackColor()
        control.alpha = 0
        control.addTarget(self, action: #selector(ZXYActionSheetController.controlTouch), forControlEvents: UIControlEvents.TouchUpInside)
        UIView.animateWithDuration(animateTime) {
            self.control.alpha = 0.5
        }
    }
    
    func initBottomView() {
        
        var isHaveTitle = false
        if titleString?.utf8.count > 0 {
            isHaveTitle = true
        }
        
        var heightOfTitle: CGFloat = 0
        
        if isHaveTitle {
            
            let attributes = [NSFontAttributeName:UIFont.systemFontOfSize(14)]
            let string = NSString(CString: titleString!, encoding: NSUTF8StringEncoding)
            let rectOfTitle: CGRect = (string?.boundingRectWithSize(CGSizeMake(GlobalDevice.screenWidth - 40, CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributes, context: nil))! as CGRect
            heightOfTitle = rectOfTitle.size.height + 40
        }
        
        let heightOfActionButton: CGFloat = 44.0
        
        let heightOfBottomView = heightOfTitle + CGFloat(actionList.count)*(heightOfActionButton+1)+5.0
        
        let bottomView = UIView.init(frame: CGRectMake(0, GlobalDevice.screenHeight-heightOfBottomView, GlobalDevice.screenWidth, heightOfBottomView))
        bottomView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(bottomView)
        self.bottomView = bottomView
        
        if isHaveTitle {
            let titleLabel = UILabel.init(frame: CGRectMake(20, 0, GlobalDevice.screenWidth - 40, heightOfTitle))
            titleLabel.backgroundColor = UIColor.clearColor()
            titleLabel.numberOfLines = 0
            titleLabel.textAlignment = NSTextAlignment.Center
            titleLabel.textColor = GlobalColor.headerTitleColor
            titleLabel.text = titleString
            titleLabel.font = UIFont.systemFontOfSize(14)
            bottomView.addSubview(titleLabel)
        }
        
        let heightOfTop = heightOfTitle
        
        for index in 0...(actionList.count-1) {
            
            let line: UILabel!
            if index == actionList.count-1 {
                
                line = UILabel.init(frame: CGRectMake(0, heightOfTop+CGFloat(index)*(heightOfActionButton+1), GlobalDevice.screenWidth, 5))
                line.backgroundColor = GlobalColor.bgColor
                bottomView.addSubview(line)
            }else{
                line = UILabel.init(frame: CGRectMake(0, heightOfTop+CGFloat(index)*(heightOfActionButton+1), GlobalDevice.screenWidth, 1))
                line.backgroundColor = GlobalColor.lineColor
                bottomView.addSubview(line)
            }
            
            let button = UIButton.init(type: UIButtonType.Custom)
            button.frame = CGRectMake(0, CGRectGetMaxY(line.frame), GlobalDevice.screenWidth, heightOfActionButton)
            bottomView.addSubview(button)
            button.addTarget(self, action: #selector(ZXYActionSheetController.buttonTouch(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            button.tag = 10 + index
            let action = actionList[index]
            button.setTitle(action._title, forState: UIControlState.Normal)
            button.setBackgroundImage(GlobalImage.imageWithColor(GlobalColor.RGB(r: 247, g: 247, b: 247), size: CGSizeMake(10, 10)), forState: UIControlState.Highlighted)
            
            if action._stype == ZXYAlertActionStyle.Destructive {
                button.setTitleColor(GlobalColor.RGB(r: 233, g: 83, b: 78), forState: UIControlState.Normal)
            }else if action._stype == ZXYAlertActionStyle.Cancel{
                button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            }else if action._stype == ZXYAlertActionStyle.Default{
                button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            }else{
                button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            }
        }
        
        let afterRectOfButtomView = bottomView.frame
        
        var beginRectOfButtonView = bottomView.frame
        beginRectOfButtonView.origin.y = GlobalDevice.screenHeight
        self.bottomView.frame = beginRectOfButtonView
        
        UIView.animateWithDuration(animateTime) {
            self.bottomView.frame = afterRectOfButtomView
        }
    }
    
    func buttonTouch(btn: UIButton) {
        
        let action = actionList[btn.tag - 10]
        action._handle!(action)
        self.controlTouch()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clearColor()
        self.edgesForExtendedLayout = UIRectEdge.None
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        self.initControl()
        self.initBottomView()
    }
    
    func removeSubViewsOfBottomView() {
        
        for subView in self.bottomView.subviews {
            subView.removeFromSuperview()
        }
    }
    
    func disMissAndRemoveSubViews(callBack: ()->Void) {
        
        var afterControlRect = bottomView.frame
        afterControlRect.origin.y = GlobalDevice.screenHeight
        UIView.animateWithDuration(animateTime, animations: {
            
            self.bottomView.frame = afterControlRect
            self.control.alpha = 0
        }) { (bl: Bool) in
            
            self.removeSubViewsOfBottomView()
            self.bottomView.removeFromSuperview()
            self.control.removeFromSuperview()
            
            callBack()
        }
    }
    
    func controlTouch() {
        
        self.disMissAndRemoveSubViews { 
            self.dismissViewControllerAnimated(false, completion: nil)
        }
    }
    
}
