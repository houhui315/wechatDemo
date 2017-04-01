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
    func WKeyBoardWillShow(_ keyBoardHeight: CGFloat)
    func WKeyBoardWillHide()
    
    //显示和隐藏背景control
    func showBackGroundControl()
    func hideBackGroundControl()
    
}

enum KeyBoardBoxType {
    
    case None
    case KeyBoard
    case ExternBox
    case EmojiBox
    case VoiceBox
}

class WKeyBoardViewController: UIViewController ,UITextViewDelegate,EmojiKeyBoardViewDelegate {

    var delegate: WKeyBoardViewControllerDelegate?
    
    var externDelegate: MsgExternViewDelegate?
    
    var _voiceButton: UIButton!
    var _keyBoardButton: UIButton!
    var _emojiBoardButton: UIButton!
    var _inputTextView: UITextView!
    var _sayHelloButton: UIButton!
    
    var _keyBoadToolView: UIView!
    
    let keyBoardToolHeight:CGFloat = 50.0
    
    let externBoxHeight: CGFloat = 250.0
    
    let emojiBoxHeight: CGFloat = 250.0
    
    var myExternView: MsgExternView? = nil
    
    var myEmojiView: EmojiKeyBoardView? = nil
    
    var keyBoxType: KeyBoardBoxType = .None
    
    var keyBoardViewNormalOriginY: CGFloat = 0.0
    
    deinit{
        
        self.removeKeyBoardObserver()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.isMultipleTouchEnabled = false
        
        self.initKeyoardTool()
        self.initExternView()
        self.perform(#selector(self.initEmojiView), with: nil, afterDelay: 0.2)
        
        self.registerKeyBoardObserver()
        
    }
    
    func registerKeyBoardObserver() {
        
        let notificationCenter = NotificationCenter.default
        let mainQueue = OperationQueue.main
        notificationCenter.addObserver(forName: NSNotification.Name.UIKeyboardWillShow, object: nil, queue: mainQueue) { (notification: Notification) in
            
            self.keyBoardWillShowOrWillHide(notification)
        }
        
        notificationCenter.addObserver(forName: NSNotification.Name.UIKeyboardWillHide, object: nil, queue: mainQueue) { (notification: Notification) in
            
            self.keyBoardWillShowOrWillHide(notification)
        }
    }
    
    func removeKeyBoardObserver() {
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        notificationCenter.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyBoardWillShowOrWillHide(_ notification: Notification) {
        
        let userInfo = (notification as NSNotification).userInfo
        let keyboardFrame = (userInfo![UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        
        var keyboardHeight = keyboardFrame?.height
        
        let animationDutation = (userInfo![UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
        let animationCurve = (userInfo![UIKeyboardAnimationCurveUserInfoKey] as AnyObject).uint32Value
        var isShowNotification: Bool = false
        if notification.name == NSNotification.Name.UIKeyboardWillShow {
            
            isShowNotification = true
        }
        if !isShowNotification {
            keyboardHeight = 0
        }
        var rect = self.view.frame
        rect.origin.y = GlobalDevice.appFrameHeight-_keyBoadToolView.bounds.height-keyboardHeight!
        
        UIView.animate(withDuration: animationDutation!, delay: 0, options: UIViewAnimationOptions(rawValue: UInt(Int(animationCurve!))), animations: {
            
            self.view.frame = rect
            
        }) { (bi) in
            
        }
        
        if isShowNotification {
            
            self.myEmojiView?.isHidden = true
            self.myExternView?.isHidden = true
            self.keyBoxType = .KeyBoard
            self.delegate?.WKeyBoardWillShow(keyboardHeight!)
        }else{
            self.keyBoxType = .None
            self.delegate?.WKeyBoardWillHide()
        }
    }
    
    func initKeyoardTool() {
        
        let toolView = UIView.init()
        toolView.backgroundColor = UIColor.white
        toolView.layer.borderColor = GlobalColor.lineColor.cgColor
        toolView.layer.borderWidth = 0.5
        toolView.backgroundColor = GlobalColor.RGB(r: 245, g: 245, b: 247)
        _keyBoadToolView = toolView
        self.view.addSubview(toolView)
        toolView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(self.view.snp.right)
            make.top.equalTo(0)
            make.height.equalTo(keyBoardToolHeight)
        }
        
        let voiceButton = UIButton.init(type: UIButtonType.custom)
        voiceButton.setImage(UIImage.init(named: "ToolViewInputVoice"), for: UIControlState())
        voiceButton.setImage(UIImage.init(named: "ToolViewInputVoiceHL"), for: UIControlState.highlighted)
        _voiceButton = voiceButton
        voiceButton.addTarget(self, action: #selector(self.voiceButtonTouch), for: UIControlEvents.touchUpInside)
        toolView.addSubview(voiceButton)
        voiceButton.snp.makeConstraints { (make) in
            
            make.left.equalTo(2)
            make.bottom.equalTo(toolView.snp.bottom).offset(-7.5)
            make.size.equalTo(CGSize(width: 35, height: 35))
        }
        
        let keyBoardButton = UIButton.init(type: UIButtonType.custom)
        keyBoardButton.setImage(UIImage.init(named: "ToolViewKeyboard"), for: UIControlState())
        keyBoardButton.setImage(UIImage.init(named: "ToolViewKeyboardHL"), for: UIControlState.highlighted)
        _keyBoardButton = keyBoardButton
        keyBoardButton.addTarget(self, action: #selector(WKeyBoardViewController.keyBoardButtonTouch), for: UIControlEvents.touchUpInside)
        toolView.addSubview(keyBoardButton)
        keyBoardButton.snp.makeConstraints { (make) in
            
            make.left.equalTo(2)
            make.bottom.equalTo(voiceButton)
            make.size.equalTo(CGSize(width: 35, height: 35))
        }
        
        let moreButton = UIButton.init(type: UIButtonType.custom)
        moreButton.setImage(UIImage.init(named: "TypeSelectorBtn_Black"), for: UIControlState())
        moreButton.setImage(UIImage.init(named: "TypeSelectorBtnHL_Black"), for: UIControlState.highlighted)
        moreButton.addTarget(self, action: #selector(WKeyBoardViewController.moreButtonTouch), for: UIControlEvents.touchUpInside)
        toolView.addSubview(moreButton)
        moreButton.snp.makeConstraints { (make) in
            
            make.right.equalTo(toolView.snp.right).offset(-2)
            make.bottom.equalTo(voiceButton)
            make.size.equalTo(CGSize(width: 35, height: 35))
        }
        
        let emojiButton = UIButton.init(type: UIButtonType.custom)
        emojiButton.setImage(UIImage.init(named: "ToolViewEmotion"), for: UIControlState())
        emojiButton.setImage(UIImage.init(named: "ToolViewEmotionHL"), for: UIControlState.highlighted)
        emojiButton.addTarget(self, action: #selector(WKeyBoardViewController.emojiButtonTouch), for: UIControlEvents.touchUpInside)
        toolView.addSubview(emojiButton)
        _emojiBoardButton = emojiButton
        emojiButton.snp.makeConstraints { (make) in
            
            make.right.equalTo(moreButton.snp.left).offset(-2)
            make.bottom.equalTo(voiceButton)
            make.size.equalTo(CGSize(width: 35, height: 35))
        }
        
        let inputTextView = UITextView.init()
        inputTextView.layer.cornerRadius = 4
        inputTextView.layer.masksToBounds = true
        inputTextView.layer.borderColor = GlobalColor.lineColor.cgColor
        inputTextView.layer.borderWidth = 0.5
        inputTextView.backgroundColor = GlobalColor.RGB(r: 252, g: 252, b: 252)
        inputTextView.font = UIFont.systemFont(ofSize: 18)
        inputTextView.delegate = self
        toolView.addSubview(inputTextView)
        self._inputTextView = inputTextView
        inputTextView.snp.makeConstraints { (make) in
            
            make.top.equalTo(8)
            make.left.equalTo(voiceButton.snp.right).offset(5)
            make.right.equalTo(emojiButton.snp.left).offset(-5)
            make.bottom.equalTo(toolView.snp.bottom).offset(-8)
        }
        
        let sayHelloButton = UIButton.init(type: UIButtonType.custom)
        sayHelloButton.layer.cornerRadius = 4
        sayHelloButton.layer.masksToBounds = true
        sayHelloButton.layer.borderColor = GlobalColor.lineColor.cgColor
        sayHelloButton.layer.borderWidth = 0.5
        sayHelloButton.setBackgroundImage(GlobalImage.imageWithColor(GlobalColor.RGB(r: 245, g: 245, b: 247), size: CGSize(width: 10, height: 10)), for: UIControlState())
        sayHelloButton.setTitle("按住说话", for: UIControlState())
        sayHelloButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        sayHelloButton.setTitleColor(GlobalColor.RGB(r: 63, g: 63, b: 63), for: UIControlState())
        
        sayHelloButton.addTarget(self, action: #selector(WKeyBoardViewController.TouchDown), for: UIControlEvents.touchDown)
        sayHelloButton.addTarget(self, action: #selector(WKeyBoardViewController.TouchDownRepeat), for: UIControlEvents.touchDownRepeat)
        sayHelloButton.addTarget(self, action: #selector(WKeyBoardViewController.TouchDragEnter), for: UIControlEvents.touchDragEnter)
        sayHelloButton.addTarget(self, action: #selector(WKeyBoardViewController.TouchDragExit), for: UIControlEvents.touchDragExit)
        sayHelloButton.addTarget(self, action: #selector(WKeyBoardViewController.TouchUpInside), for: UIControlEvents.touchUpInside)
        sayHelloButton.addTarget(self, action: #selector(WKeyBoardViewController.TouchUpOutside), for: UIControlEvents.touchUpOutside)
        sayHelloButton.setBackgroundImage(GlobalImage.imageWithColor(GlobalColor.RGB(r: 198, g: 199, b: 202), size: CGSize(width: 10, height: 10)), for: UIControlState.highlighted)
        _sayHelloButton = sayHelloButton
        toolView.addSubview(sayHelloButton)
        sayHelloButton.snp.makeConstraints { (make) in
            
            make.top.equalTo(8)
            make.left.equalTo(voiceButton.snp.right).offset(5)
            make.right.equalTo(emojiButton.snp.left).offset(-5)
            make.bottom.equalTo(toolView.snp.bottom).offset(-8)
        }
        
        keyBoardButton.isHidden = true
        sayHelloButton.isHidden = true
        
    }
    
    func voiceButtonTouch() {
        
        self.messagePageBackgroundTouch()
        
        _voiceButton.isHidden = true
        _keyBoardButton.isHidden = false
        _sayHelloButton.isHidden = false
        
        _inputTextView.endEditing(true)
        
        self.keyBoxType = .VoiceBox
    }
    
    func keyBoardButtonTouch() {
        
        _voiceButton.isHidden = false
        _keyBoardButton.isHidden = true
        _sayHelloButton.isHidden = true
        
        _inputTextView.becomeFirstResponder()
        
        self.keyBoxType = .KeyBoard
    }
    
    func moreButtonTouch() {
        
        switch self.keyBoxType {
        case .KeyBoard, .None:
            
            self.myEmojiView?.isHidden = true
            self.myExternView?.isHidden = false
            
            self.delegate?.showBackGroundControl()
            
            _inputTextView.resignFirstResponder()
            
            var externBoxFrame = self.myExternView?.frame
            externBoxFrame?.origin.y = _keyBoadToolView.bounds.height
            self.myExternView?.frame = externBoxFrame!
            
            var emojiFrame = self.myEmojiView?.frame
            emojiFrame?.origin.y = _keyBoadToolView.bounds.height
            self.myEmojiView?.frame = emojiFrame!
            
            var rect = self.view.frame
            rect.origin.y = GlobalDevice.appFrameHeight-_keyBoadToolView.bounds.height-self.externBoxHeight
            
            UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                
                self.view.frame = rect
                
            }, completion: { (bl) in
                
                self.keyBoxType = .ExternBox
            })
            
            break
        case .ExternBox:
            
            _inputTextView.becomeFirstResponder()
            
            self.myEmojiView?.isHidden = true
            self.myExternView?.isHidden = true
            
            self.keyBoxType = .KeyBoard
            
            break
        case .EmojiBox:
            
            _emojiBoardButton.setImage(UIImage.init(named: "ToolViewEmotion"), for: UIControlState())
            _emojiBoardButton.setImage(UIImage.init(named: "ToolViewEmotionHL"), for: UIControlState.highlighted)
            
            self.myEmojiView?.isHidden = true
            self.myExternView?.isHidden = false
            
            self.keyBoxType = .ExternBox
            
            break
        case .VoiceBox:
            
            _voiceButton.isHidden = false
            _keyBoardButton.isHidden = true
            _sayHelloButton.isHidden = true
            
            self.myEmojiView?.isHidden = true
            self.myExternView?.isHidden = false
            
            self.delegate?.showBackGroundControl()
            
            _inputTextView.resignFirstResponder()
            
            var rect = self.view.frame
            rect.origin.y = GlobalDevice.appFrameHeight-_keyBoadToolView.bounds.height-self.externBoxHeight
            
            UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                
                self.view.frame = rect
                
            }, completion: { (bl) in
                
                self.keyBoxType = .ExternBox
            })
            
            break
        }
        
    }
    
    func isShowEmojiBoxOrExternBox() -> Bool {
        
        if self.keyBoxType == .EmojiBox || self.keyBoxType == .ExternBox {
            return true
        }else {
            return false
        }
    }
    
    func initExternView() {
        
        let externView = MsgExternView.init(frame: CGRect.init(x: 0, y: keyBoardToolHeight, width: GlobalDevice.screenWidth, height: self.externBoxHeight))
        externView.delegate = self.externDelegate
        self.view.addSubview(externView)
        self.myExternView = externView
        externView.isHidden = true
    }
    
    func initEmojiView() {
        
        let emojiView = EmojiKeyBoardView.init(frame: CGRect.init(x: 0, y: keyBoardToolHeight, width: GlobalDevice.screenWidth, height: self.emojiBoxHeight))
        emojiView.delegate = self
        self.view.addSubview(emojiView)
        self.myEmojiView = emojiView
        emojiView.isHidden = true
    }
    
    func emojiButtonTouch() {
        
        switch self.keyBoxType {
        case .KeyBoard:
            
            self.myExternView?.isHidden = true
            self.myEmojiView?.isHidden = false
            
            self.delegate?.showBackGroundControl()
            
            _inputTextView.resignFirstResponder()
            
            _emojiBoardButton.setImage(UIImage.init(named: "ToolViewKeyboard"), for: UIControlState())
            _emojiBoardButton.setImage(UIImage.init(named: "ToolViewKeyboardHL"), for: UIControlState.highlighted)
            
            var emojiFrame = self.myEmojiView?.frame
            emojiFrame?.origin.y = _keyBoadToolView.bounds.height
            self.myEmojiView?.frame = emojiFrame!
            
            var externBoxFrame = self.myExternView?.frame
            externBoxFrame?.origin.y = _keyBoadToolView.bounds.height
            self.myExternView?.frame = externBoxFrame!
            
            var rect = self.view.frame
            rect.origin.y = GlobalDevice.appFrameHeight-_keyBoadToolView.bounds.height-self.emojiBoxHeight
            
            UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                
                self.view.frame = rect
                
            }, completion: { (bl) in
                
                self.keyBoxType = .EmojiBox
            })
            
            break
        case .ExternBox:
            
            self.myExternView?.isHidden = true
            self.myEmojiView?.isHidden = false
            
            _emojiBoardButton.setImage(UIImage.init(named: "ToolViewKeyboard"), for: UIControlState())
            _emojiBoardButton.setImage(UIImage.init(named: "ToolViewKeyboardHL"), for: UIControlState.highlighted)
            
            self.keyBoxType = .EmojiBox
            
            break
        case .EmojiBox:
            
            _inputTextView.becomeFirstResponder()
            
            _emojiBoardButton.setImage(UIImage.init(named: "ToolViewEmotion"), for: UIControlState())
            _emojiBoardButton.setImage(UIImage.init(named: "ToolViewEmotionHL"), for: UIControlState.highlighted)
            
            self.myExternView?.isHidden = true
            self.myEmojiView?.isHidden = true
            
            self.keyBoxType = .KeyBoard
            
            break
        case .VoiceBox:
            
            _voiceButton.isHidden = false
            _keyBoardButton.isHidden = true
            _sayHelloButton.isHidden = true
            
            self.myExternView?.isHidden = true
            self.myEmojiView?.isHidden = false
            
            self.delegate?.showBackGroundControl()
            
            _inputTextView.resignFirstResponder()
            
            _emojiBoardButton.setImage(UIImage.init(named: "ToolViewEmotion"), for: UIControlState())
            _emojiBoardButton.setImage(UIImage.init(named: "ToolViewEmotionHL"), for: UIControlState.highlighted)
            
            var rect = self.view.frame
            rect.origin.y = GlobalDevice.appFrameHeight-_keyBoadToolView.bounds.height-self.emojiBoxHeight
            
            UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                
                self.view.frame = rect
                
            }, completion: { (bl) in
                
                self.keyBoxType = .EmojiBox
            })
            
            break
        case .None:
            
            self.myExternView?.isHidden = true
            self.myEmojiView?.isHidden = false
            
            self.delegate?.showBackGroundControl()
            
            _inputTextView.resignFirstResponder()
            
            _emojiBoardButton.setImage(UIImage.init(named: "ToolViewKeyboard"), for: UIControlState())
            _emojiBoardButton.setImage(UIImage.init(named: "ToolViewKeyboardHL"), for: UIControlState.highlighted)
            
            var rect = self.view.frame
            rect.origin.y = GlobalDevice.appFrameHeight-_keyBoadToolView.bounds.height-self.emojiBoxHeight
            
            UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                
                self.view.frame = rect
                
            }, completion: { (bl) in
                
                self.keyBoxType = .EmojiBox
            })
            
            break
        }
        
        
    }
    
    func messagePageBackgroundTouch() {
        
        if self.keyBoxType == .EmojiBox || self.keyBoxType == .ExternBox || self.keyBoxType == .KeyBoard {
            
            self.keyBoxType = .None
            
            self.delegate?.hideBackGroundControl()
            
            _emojiBoardButton.setImage(UIImage.init(named: "ToolViewEmotion"), for: UIControlState())
            _emojiBoardButton.setImage(UIImage.init(named: "ToolViewEmotionHL"), for: UIControlState.highlighted)
            
            var rect = self.view.frame
            rect.origin.y = GlobalDevice.appFrameHeight-_keyBoadToolView.bounds.height
            
            UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                
                self.view.frame = rect
                
            }, completion: { (bl) in
                
            })
            
        }
    }
    
    
    func TouchDown() {
        
        _sayHelloButton.setBackgroundImage(GlobalImage.imageWithColor(GlobalColor.RGB(r: 198, g: 199, b: 202), size: CGSize(width: 10, height: 10)), for: UIControlState())
        _sayHelloButton.setTitle("松开结束", for: UIControlState())
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
        _sayHelloButton.setBackgroundImage(GlobalImage.imageWithColor(GlobalColor.RGB(r: 245, g: 245, b: 247), size: CGSize(width: 10, height: 10)), for: UIControlState())
        _sayHelloButton.setTitle("按住说话", for: UIControlState())
    }
    
//    #MARK: - UITextViewDelegate
    
    //只有在内容改变时才触发，而且这个改变内容是手动输入有效
    func textViewDidChange(_ textView: UITextView) {
        
//        self.resizeHeightOfTextView(textView)
    }
    
    //几乎所有操作都会触发textViewDidChangeSelection，包括点击文本框、增加内容删除内容
    func textViewDidChangeSelection(_ textView: UITextView) {

        self.resizeHeightOfTextView(textView)
    }
    
    
    func resizeHeightOfTextView(_ textView: UITextView) {
        
        let attributes = [NSFontAttributeName:UIFont.systemFont(ofSize: 18)]
        let option:NSStringDrawingOptions = .usesLineFragmentOrigin
        let text: NSString = textView.text as NSString
        let height = text.boundingRect(with: CGSize(width: textView.bounds.width, height: CGFloat.greatestFiniteMagnitude), options: option, attributes: attributes, context: nil).size.height
        
        //高度最小值50，最大值100
        let myheight = min(max(height+28, 50), 100)
        
        _keyBoadToolView.snp.updateConstraints { (make) in
            
            make.height.equalTo(myheight)
        }
        
        
        if self.keyBoxType == .EmojiBox {
            
            self.myEmojiView?.frame = CGRect.init(x: 0, y: myheight, width: GlobalDevice.screenWidth, height: self.emojiBoxHeight)
            
            var rect = self.view.frame
            rect.origin.y = GlobalDevice.appFrameHeight-myheight-self.emojiBoxHeight
            self.view.frame = rect
        }else{
            var rect = self.view.frame
            rect.origin.y = GlobalDevice.appFrameHeight-myheight-216
            self.view.frame = rect
        }
        
    }
    
    //Mark: - EmojiKeyBoardViewDelegate methods
    
    func emojiKeyBoardViewDidSelectEmojiWithName(emojiView: EmojiKeyBoardView, text: String) {
        _inputTextView.text.append(text)
    }
    
    func emojiKeyBoardViewDidSelectDeleteButton(emojiView: EmojiKeyBoardView) {
        
        let inputString = _inputTextView.text
        if inputString?.characters.count == 0 {
            return;
        }
        
        if inputString?.characters.last != "]" {
            return;
        }
        
        //startIndex 第一个字符的位置
        let startIndex: String.Index = inputString!.startIndex
        
        //endIndex 最后一个字符的位置
        let endIndex: String.Index = inputString!.endIndex
        
        let offsetRange = startIndex ..< endIndex
        
        let range: Range = (inputString?.range(of: "[", options: .backwards, range: offsetRange, locale: Locale.current))!
        if range.isEmpty {
            return
        }
        
        let subString = _inputTextView.text.substring(to: range.lowerBound)
        _inputTextView.text = subString
    }
    
}
