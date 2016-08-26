//
//  MoreAddView.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 16/8/12.
//  Copyright © 2016年 zhixueyun. All rights reserved.
//

import UIKit

protocol MoreAddViewDelegate {
    
    func MoreAddViewDidSelectWithIndex(index: Int)
    func MoreAddViewCancelSelect()
}

class MoreAddView: UIView ,UITableViewDelegate,UITableViewDataSource{

    var control: UIControl!
    
    var moreFunctionView: UIView!
    
    var myTableView: UITableView!
    
    var messageList = [MoreAddModel]()
    
    var delegate: MoreAddViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
        self.initBgControl(frame)
        self.initData()
        self.initMoreFunctionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initData(){
        
        let model1 = MoreAddModel()
        model1.iconImageString = "contacts_add_newmessage"
        model1.titleString = "发起群聊"
        
        let model2 = MoreAddModel()
        model2.iconImageString = "barbuttonicon_add_cube"
        model2.titleString = "添加朋友"
        
        let model3 = MoreAddModel()
        model3.iconImageString = "contacts_add_scan"
        model3.titleString = "扫一扫"
        
        let model4 = MoreAddModel()
        model4.iconImageString = "receipt_payment_icon"
        model4.titleString = "收付款"
        
        messageList.append(model1)
        messageList.append(model2)
        messageList.append(model3)
        messageList.append(model4)
    }
    
    func initBgControl(frame: CGRect) {
        
        control = UIControl.init(frame: frame)
        control.addTarget(self, action: #selector(MoreAddView.controlTouch), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(control)
    }
    
    func initMoreFunctionView() {
        
        moreFunctionView = UIView.init()
        moreFunctionView.backgroundColor = UIColor.clearColor()
        self.addSubview(moreFunctionView)
        moreFunctionView.snp_makeConstraints { (make) in
            
            make.top.equalTo(self.snp_top)
            make.right.equalTo(self.snp_right)
            make.width.equalTo(150)
            make.height.equalTo(193)
        }
        
        let bgImageView = UIImageView.init(image: UIImage.init(named: "MoreFunctionFrame")?.resizableImageWithCapInsets(UIEdgeInsetsMake(15, 10, 10, 40)))
        moreFunctionView.addSubview(bgImageView)
        bgImageView.snp_makeConstraints { (make) in
            
            make.right.equalTo(moreFunctionView.snp_right).offset(-3)
            make.top.equalTo(moreFunctionView.snp_top).offset(3)
            make.left.equalTo(moreFunctionView.snp_left)
            make.bottom.equalTo(moreFunctionView.snp_bottom)
        }
        
        let tableView = UITableView.init(frame: CGRectMake(10, 10, 140, 180), style: UITableViewStyle.Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(MoreFuncCell.classForCoder(), forCellReuseIdentifier: MoreFuncCell.cellIdentifier)
        tableView.scrollEnabled = false
        tableView.backgroundView = nil;
        tableView.backgroundColor = UIColor.clearColor()
        tableView.separatorColor = GlobalColor.RGB(r: 89, g: 88, b: 90)
        tableView.separatorInset = UIEdgeInsetsMake(43.5, 10, 0, 10)
        moreFunctionView.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            
            make.left.equalTo(10)
            make.right.equalTo(moreFunctionView.snp_right).offset(-15)
            make.top.equalTo(10)
            make.bottom.equalTo(moreFunctionView.snp_bottom)
        }
    }
    
    func controlTouch() {
        
        self.removeMyself()
        
        delegate?.MoreAddViewCancelSelect()
    }
    
    func removeMyself() {
        
        control.removeFromSuperview()
        moreFunctionView.removeFromSuperview()
        self.removeFromSuperview()
    }
    
    // MARK: - UITableViewDataSource, UITableViewDelegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(MoreFuncCell.cellIdentifier, forIndexPath: indexPath) as! MoreFuncCell
        cell.congigforMoreAddModel(messageList[indexPath.row])
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return MoreFuncCell.heightForCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.removeMyself()
        delegate?.MoreAddViewDidSelectWithIndex(indexPath.row)
    }
}
