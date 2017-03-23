//
//  MoreAddView.swift
//  wechatDemo
//
//  Created by 蓝泰致铭        on 16/8/12.
//  Copyright © 2016年 zhixueyun. All rights reserved.
//

import UIKit

protocol MoreAddViewDelegate {
    
    func MoreAddViewDidSelectWithIndex(_ index: Int)
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
        
        self.backgroundColor = UIColor.clear
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
    
    func initBgControl(_ frame: CGRect) {
        
        control = UIControl.init(frame: frame)
        control.addTarget(self, action: #selector(MoreAddView.controlTouch), for: UIControlEvents.touchUpInside)
        self.addSubview(control)
    }
    
    func initMoreFunctionView() {
        
        moreFunctionView = UIView.init()
        moreFunctionView.backgroundColor = UIColor.clear
        self.addSubview(moreFunctionView)
        moreFunctionView.snp.makeConstraints { (make) in
            
            make.top.equalTo(self.snp.top)
            make.right.equalTo(self.snp.right)
            make.width.equalTo(150)
            make.height.equalTo(193)
        }
        
        let bgImageView = UIImageView.init(image: UIImage.init(named: "MoreFunctionFrame")?.resizableImage(withCapInsets: UIEdgeInsetsMake(15, 10, 10, 40)))
        moreFunctionView.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { (make) in
            
            make.right.equalTo(moreFunctionView.snp.right).offset(-3)
            make.top.equalTo(moreFunctionView.snp.top).offset(3)
            make.left.equalTo(moreFunctionView.snp.left)
            make.bottom.equalTo(moreFunctionView.snp.bottom)
        }
        
        let tableView = UITableView.init(frame: CGRect(x: 10, y: 10, width: 140, height: 180), style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MoreFuncCell.classForCoder(), forCellReuseIdentifier: MoreFuncCell.cellIdentifier)
        tableView.isScrollEnabled = false
        tableView.backgroundView = nil;
        tableView.backgroundColor = UIColor.clear
        tableView.separatorColor = GlobalColor.RGB(r: 89, g: 88, b: 90)
        tableView.separatorInset = UIEdgeInsetsMake(43.5, 10, 0, 10)
        moreFunctionView.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            
            make.left.equalTo(10)
            make.right.equalTo(moreFunctionView.snp.right).offset(-15)
            make.top.equalTo(10)
            make.bottom.equalTo(moreFunctionView.snp.bottom)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MoreFuncCell.cellIdentifier, for: indexPath) as! MoreFuncCell
        cell.congigforMoreAddModel(messageList[(indexPath as NSIndexPath).row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return MoreFuncCell.heightForCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.removeMyself()
        delegate?.MoreAddViewDidSelectWithIndex((indexPath as NSIndexPath).row)
    }
}
