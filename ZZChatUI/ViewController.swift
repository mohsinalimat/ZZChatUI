//
//  ViewController.swift
//  ZZChatUI
//
//  Created by duzhe on 16/1/5.
//  Copyright © 2016年 dz. All rights reserved.
//

import UIKit
import SnapKit

private let leftCellId = "ZZChatLeftMessageCell"
private let rightCellId = "ZZChatRightMessageCell"
class ViewController: UIViewController {

    var chatTableView: UITableView!
    var zzinputView:ZZInputView!
    var dataArray:[ZZModel] = []
    
    var inputViewConstraint: Constraint? = nil
    var tableConstraint: Constraint? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "测试--聊天界面"
        zzinputView = ZZInputView()
        self.view.addSubview(zzinputView)
        
        self.dataArray = ZZModel.creatRandomArray(count: 10) //随机产生10条信息
        
        zzinputView.snp_makeConstraints { (make) -> Void in
            make.leading.trailing.equalTo(self.view)
            inputViewConstraint = make.bottom.equalTo(self.view).constraint
        }
        
        zzinputView.sendZZTextBlock = { [weak self] (txt,textView) in
            
            if txt == ""{
                return
            }
            self?.dataArray.append(ZZModel.creatMessageFromMeByText(txt))
//            let indexPath = NSIndexPath(forRow:self!.dataArray.count-1, inSection: 0)
            self?.chatTableView.reloadData()
            self?.chatTableView.scrollToBottom(animation: true)
            
        }
        
        chatTableView = UITableView.init(frame: CGRectZero, style: .Plain)
        chatTableView.dataSource = self
        chatTableView.delegate = self
        chatTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        chatTableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.Interactive
        self.view.addSubview(chatTableView)
        chatTableView.snp_makeConstraints { (make) -> Void in
            make.top.leading.trailing.equalTo(self.view)
            tableConstraint = make.bottom.equalTo(zzinputView.snp_top).constraint
        }
        chatTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        chatTableView.estimatedRowHeight = 100
        
        chatTableView.registerClass(ZZLeftMsgCell.classForKeyedArchiver(), forCellReuseIdentifier: leftCellId)
        chatTableView.registerClass(ZZRightMsgCell.classForKeyedArchiver(), forCellReuseIdentifier: rightCellId)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action:"handleTouches:")
        tapGestureRecognizer.cancelsTouchesInView = false
        self.chatTableView.addGestureRecognizer(tapGestureRecognizer)

//        let indexPath = NSIndexPath(forRow: dataArray.count-1, inSection: 0)
//        chatTableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: false)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
//        print(self.chatTableView.contentSize.height)
        //将tableview 划到底部
        self.chatTableView.contentOffset.y = self.chatTableView.contentSize.height - self.chatTableView.zz_height
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardFrameChanged:"), name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidAppear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //Dispose of any resources that can be recreated.
    }
    
    func scrollToBottom(){
        print(self.chatTableView.zz_height)
         self.chatTableView.contentOffset.y = self.chatTableView.contentSize.height - self.chatTableView.zz_height
    }
}

extension ViewController{
    
    //键盘跟随
    @objc func keyboardFrameChanged(notification: NSNotification) {
        let dict = NSDictionary(dictionary: notification.userInfo!)
        let keyboardValue = dict.objectForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
        let bottomDistance = UIScreen.mainScreen().bounds.size.height - keyboardValue.CGRectValue().origin.y
        let duration = Double(dict.objectForKey(UIKeyboardAnimationDurationUserInfoKey) as! NSNumber)
        self.chatTableView.contentOffset.y = self.chatTableView.contentSize.height - self.chatTableView.zz_height
        UIView.animateWithDuration(duration, animations: {
            self.inputViewConstraint?.updateOffset(-bottomDistance)
            self.view.layoutIfNeeded()
            self.chatTableView.scrollToBottom(animation: false)
            }, completion: {
                (value: Bool) in
//          self.chatTableView.scrollToBottom(animation: true)
        })
    }
    
    func handleTouches(sender:UITapGestureRecognizer){
        if sender.locationInView(self.view).y < self.view.bounds.height{
            UIApplication.sharedApplication().sendAction(Selector("resignFirstResponder"), to: nil, from: nil, forEvent: nil)
        }
    }

}

//
extension ViewController:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let model = dataArray[indexPath.row]
        if model.from == .Me {
            let cell:ZZRightMsgCell = tableView.dequeueReusableCellWithIdentifier(rightCellId) as! ZZRightMsgCell
            cell.configUIWithModel(model)
            return cell
        }else {
            let cell:ZZLeftMsgCell = tableView.dequeueReusableCellWithIdentifier(leftCellId) as! ZZLeftMsgCell
            cell.configUIWithModel(model)
            return cell
        }
    }

}


