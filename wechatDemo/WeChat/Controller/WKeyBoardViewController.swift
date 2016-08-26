//
//  WKeyBoardViewController.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 16/8/18.
//  Copyright © 2016年 zhixueyun. All rights reserved.
//

import UIKit

protocol WKeyBoardViewControllerDelegate {
    
    //录音按钮事件处理
    func WkeyBoardVoiceTouchDown()
    func WkeyBoardVoiceTouchInside()
    func WkeyBoardVoiceTouchOutside()
    func WkeyBoardVoiceTouchDragEnter()
    func WkeyBoardVoiceTouchDragExit()
    
    //键盘处理
    func WKeyBoardWillShow(keyBoardHeight: CGFloat)
    func WKeyBoardWillHide()
    
}

class WKeyBoardViewController: UIViewController , UITextViewDelegate{

    var delegate: WKeyBoardViewControllerDelegate?
    
    var _voiceButton: UIButton!
    var _keyBoardButton: UIButton!
    var _inputTextView: UITextView!
    var _sayHelloButton: UIButton!
    
    var _keyBoadToolView: UIView!
    
    deinit{
        
        self.removeKeyBoardObserver()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.multipleTouchEnabled = false
        
        self.initKeyoardTool()
        self.registerKeyBoardObserver()
        
    }
    
    func registerKeyBoardObserver() {
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        let mainQueue = NSOperationQueue.mainQueue()
        notificationCenter.addObserverForName(UIKeyboardWillShowNotification, object: nil, queue: mainQueue) { (notification: NSNotification) in
            
            self.keyBoardWillShowOrWillHide(notification)
        }
        
        notificationCenter.addObserverForName(UIKeyboardWillHideNotification, object: nil, queue: mainQueue) { (notification: NSNotification) in
            
            self.keyBoardWillShowOrWillHide(notification)
        }
    }
    
    func removeKeyBoardObserver() {
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyBoardWillShowOrWillHide(notification: NSNotification) {
        
        let userInfo = notification.userInfo
        let keyboardFrame = userInfo![UIKeyboardFrameEndUserInfoKey]?.CGRectValue()
        
        var keyboardHeight = keyboardFrame?.height
        
        let animationDutation = userInfo![UIKeyboardAnimationDurationUserInfoKey]?.doubleValue
        let animationCurve = userInfo![UIKeyboardAnimationCurveUserInfoKey]?.integerValue
        var isShowNotification: Bool = false
        if notification.name == UIKeyboardWillShowNotification {
            
            isShowNotification = true
        }
        if !isShowNotification {
            keyboardHeight = 0
        }
        var rect = self.view.frame
        rect.origin.y = GlobalDevice.appFrameHeight-_keyBoadToolView.bounds.height-keyboardHeight!
        
        
        UIView.beginAnimations("UIViewController+KeyboardAdditions-Animation", context: nil)
        UIView.setAnimationDuration(animationDutation!)
        UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: animationCurve!)!)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDelegate(self)
        
        self.view.frame = rect
        
        UIView.commitAnimations()
        
        if isShowNotification {
            self.delegate?.WKeyBoardWillShow(keyboardHeight!)
        }else{
            self.delegate?.WKeyBoardWillHide()
        }
    }
    
    func initKeyoardTool() {
        
        let toolView = UIView.init()
        toolView.backgroundColor = UIColor.whiteColor()
        toolView.layer.borderColor = GlobalColor.lineColor.CGColor
        toolView.layer.borderWidth = 0.5
        toolView.backgroundColor = GlobalColor.RGB(r: 245, g: 245, b: 247)
        _keyBoadToolView = toolView
        self.view.addSubview(toolView)
        toolView.snp_makeConstraints { (make) in
            
            make.left.equalTo(0)
            make.right.equalTo(self.view.snp_right)
            make.top.equalTo(0)
            make.height.equalTo(50)
        }
        
        let voiceButton = UIButton.init(type: UIButtonType.Custom)
        voiceButton.setImage(UIImage.init(named: "ToolViewInputVoice"), forState: UIControlState.Normal)
        voiceButton.setImage(UIImage.init(named: "ToolViewInputVoiceHL"), forState: UIControlState.Highlighted)
        _voiceButton = voiceButton
        voiceButton.addTarget(self, action: #selector(WKeyBoardViewController.voiceButtonTouch), forControlEvents: UIControlEvents.TouchUpInside)
        toolView.addSubview(voiceButton)
        voiceButton.snp_makeConstraints { (make) in
            
            make.left.equalTo(2)
            make.bottom.equalTo(toolView.snp_bottom).offset(-7.5)
            make.size.equalTo(CGSizeMake(35, 35))
        }
        
        let keyBoardButton = UIButton.init(type: UIButtonType.Custom)
        keyBoardButton.setImage(UIImage.init(named: "ToolViewKeyboard"), forState: UIControlState.Normal)
        keyBoardButton.setImage(UIImage.init(named: "ToolViewKeyboardHL"), forState: UIControlState.Highlighted)
        _keyBoardButton = keyBoardButton
        keyBoardButton.addTarget(self, action: #selector(WKeyBoardViewController.keyBoardButtonTouch), forControlEvents: UIControlEvents.TouchUpInside)
        toolView.addSubview(keyBoardButton)
        keyBoardButton.snp_makeConstraints { (make) in
            
            make.left.equalTo(2)
            make.bottom.equalTo(voiceButton)
            make.size.equalTo(CGSizeMake(35, 35))
        }
        
        let moreButton = UIButton.init(type: UIButtonType.Custom)
        moreButton.setImage(UIImage.init(named: "TypeSelectorBtn_Black"), forState: UIControlState.Normal)
        moreButton.setImage(UIImage.init(named: "TypeSelectorBtnHL_Black"), forState: UIControlState.Highlighted)
        moreButton.addTarget(self, action: #selector(WKeyBoardViewController.moreButtonTouch), forControlEvents: UIControlEvents.TouchUpInside)
        toolView.addSubview(moreButton)
        moreButton.snp_makeConstraints { (make) in
            
            make.right.equalTo(toolView.snp_right).offset(-2)
            make.bottom.equalTo(voiceButton)
            make.size.equalTo(CGSizeMake(35, 35))
        }
        
        let emojiButton = UIButton.init(type: UIButtonType.Custom)
        emojiButton.setImage(UIImage.init(named: "ToolViewEmotion"), forState: UIControlState.Normal)
        emojiButton.setImage(UIImage.init(named: "ToolViewEmotionHL"), forState: UIControlState.Highlighted)
        emojiButton.addTarget(self, action: #selector(WKeyBoardViewController.emojiButtonTouch), forControlEvents: UIControlEvents.TouchUpInside)
        toolView.addSubview(emojiButton)
        emojiButton.snp_makeConstraints { (make) in
            
            make.right.equalTo(moreButton.snp_left).offset(-2)
            make.bottom.equalTo(voiceButton)
            make.size.equalTo(CGSizeMake(35, 35))
        }
        
        let inputTextView = UITextView.init()
        inputTextView.layer.cornerRadius = 4
        inputTextView.layer.masksToBounds = true
        inputTextView.layer.borderColor = GlobalColor.lineColor.CGColor
        inputTextView.layer.borderWidth = 0.5
        inputTextView.backgroundColor = GlobalColor.RGB(r: 252, g: 252, b: 252)
        inputTextView.font = UIFont.systemFontOfSize(18)
        inputTextView.delegate = self
        toolView.addSubview(inputTextView)
        self._inputTextView = inputTextView
        inputTextView.snp_makeConstraints { (make) in
            
            make.top.equalTo(8)
            make.left.equalTo(voiceButton.snp_right).offset(5)
            make.right.equalTo(emojiButton.snp_left).offset(-5)
            make.bottom.equalTo(toolView.snp_bottom).offset(-8)
        }
        
        let sayHelloButton = UIButton.init(type: UIButtonType.Custom)
        sayHelloButton.layer.cornerRadius = 4
        sayHelloButton.layer.masksToBounds = true
        sayHelloButton.layer.borderColor = GlobalColor.lineColor.CGColor
        sayHelloButton.layer.borderWidth = 0.5
        sayHelloButton.setBackgroundImage(GlobalImage.imageWithColor(GlobalColor.RGB(r: 245, g: 245, b: 247), size: CGSizeMake(10, 10)), forState: UIControlState.Normal)
        sayHelloButton.setTitle("按住说话", forState: UIControlState.Normal)
        sayHelloButton.titleLabel?.font = UIFont.boldSystemFontOfSize(16)
        sayHelloButton.setTitleColor(GlobalColor.RGB(r: 63, g: 63, b: 63), forState: UIControlState.Normal)
        
        sayHelloButton.addTarget(self, action: #selector(WKeyBoardViewController.TouchDown), forControlEvents: UIControlEvents.TouchDown)
        sayHelloButton.addTarget(self, action: #selector(WKeyBoardViewController.TouchDownRepeat), forControlEvents: UIControlEvents.TouchDownRepeat)
        sayHelloButton.addTarget(self, action: #selector(WKeyBoardViewController.TouchDragEnter), forControlEvents: UIControlEvents.TouchDragEnter)
        sayHelloButton.addTarget(self, action: #selector(WKeyBoardViewController.TouchDragExit), forControlEvents: UIControlEvents.TouchDragExit)
        sayHelloButton.addTarget(self, action: #selector(WKeyBoardViewController.TouchUpInside), forControlEvents: UIControlEvents.TouchUpInside)
        sayHelloButton.addTarget(self, action: #selector(WKeyBoardViewController.TouchUpOutside), forControlEvents: UIControlEvents.TouchUpOutside)
        sayHelloButton.setBackgroundImage(GlobalImage.imageWithColor(GlobalColor.RGB(r: 198, g: 199, b: 202), size: CGSizeMake(10, 10)), forState: UIControlState.Highlighted)
        _sayHelloButton = sayHelloButton
        toolView.addSubview(sayHelloButton)
        sayHelloButton.snp_makeConstraints { (make) in
            
            make.top.equalTo(8)
            make.left.equalTo(voiceButton.snp_right).offset(5)
            make.right.equalTo(emojiButton.snp_left).offset(-5)
            make.bottom.equalTo(toolView.snp_bottom).offset(-8)
        }
        
        keyBoardButton.hidden = true
        sayHelloButton.hidden = true
    }
    
    func voiceButtonTouch() {
        
        _voiceButton.hidden = true
        _keyBoardButton.hidden = false
        _sayHelloButton.hidden = false
        
        _inputTextView.endEditing(true)
    }
    
    func keyBoardButtonTouch() {
        
        _voiceButton.hidden = false
        _keyBoardButton.hidden = true
        _sayHelloButton.hidden = true
        
        _inputTextView.becomeFirstResponder()
    }
    
    func moreButtonTouch() {
        
        
    }
    
    func emojiButtonTouch() {
        
        
    }
    
    func TouchDown() {
        
        _sayHelloButton.setBackgroundImage(GlobalImage.imageWithColor(GlobalColor.RGB(r: 198, g: 199, b: 202), size: CGSizeMake(10, 10)), forState: UIControlState.Normal)
        _sayHelloButton.setTitle("松开结束", forState: UIControlState.Normal)
        self.delegate?.WkeyBoardVoiceTouchDown()
    }
    
    func TouchDownRepeat() {
        
        print("TouchDownRepeat")
    }
    
    func TouchDragEnter() {
        
        self.delegate?.WkeyBoardVoiceTouchDragEnter()
    }
    
    func TouchDragExit() {
        
        self.delegate?.WkeyBoardVoiceTouchDragExit()
    }
    func TouchUpInside() {
        
        self.sayHelloButtonNormalStatus()
        self.delegate?.WkeyBoardVoiceTouchInside()
    }
    
    func TouchUpOutside() {
        
        self.sayHelloButtonNormalStatus()
        self.delegate?.WkeyBoardVoiceTouchOutside()
    }
    
    func sayHelloButtonNormalStatus() {
        _sayHelloButton.setBackgroundImage(GlobalImage.imageWithColor(GlobalColor.RGB(r: 245, g: 245, b: 247), size: CGSizeMake(10, 10)), forState: UIControlState.Normal)
        _sayHelloButton.setTitle("按住说话", forState: UIControlState.Normal)
    }
    
//    #MARK: - UITextViewDelegate
    
    //只有在内容改变时才触发，而且这个改变内容是手动输入有效
    func textViewDidChange(textView: UITextView) {
        
//        self.resizeHeightOfTextView(textView)
    }
    
    //几乎所有操作都会触发textViewDidChangeSelection，包括点击文本框、增加内容删除内容
    func textViewDidChangeSelection(textView: UITextView) {

        self.resizeHeightOfTextView(textView)
    }
    
    
    func resizeHeightOfTextView(textView: UITextView) {
        
        let attributes = [NSFontAttributeName:UIFont.systemFontOfSize(18)]
        let option:NSStringDrawingOptions = .UsesLineFragmentOrigin
        let text: NSString = textView.text
        let height = text.boundingRectWithSize(CGSizeMake(textView.bounds.width, CGFloat.max), options: option, attributes: attributes, context: nil).size.height
        
        //高度最小值50，最大值100
        let myheight = min(max(height+28, 50), 100)
        
        print("height=\(myheight)")
        _keyBoadToolView.snp_updateConstraints { (make) in
            
            make.height.equalTo(myheight)
        }
        
        var rect = self.view.frame
        rect.origin.y = GlobalDevice.appFrameHeight-_keyBoadToolView.bounds.height-216
        self.view.frame = rect
    }
}
