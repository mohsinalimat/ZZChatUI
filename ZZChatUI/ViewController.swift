//
//  ViewController.swift
//  ZZChatUI
//
//  Created by duzhe on 16/1/5.
//  Copyright © 2016年 dz. All rights reserved.
//

import UIKit
import SnapKit

//MARK: - 延时执行
func delay(seconds: Double, completion:()->()) {
    let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
    dispatch_after(popTime, dispatch_get_main_queue()) {
        completion()
    }
}

private let leftCellId = "ZZChatLeftMessageCell"
private let rightCellId = "ZZChatRightMessageCell"
class ViewController: UIViewController {

    var chatTableView: ZZTableView!
    var zzinputView:ZZInputView!
    var dataArray:[ZZModel] = []
    
    var inputViewConstraint: Constraint? = nil
    var tableConstraint: Constraint? = nil
    
    var zzRefreshView:ZZRefreshView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "测试--聊天界面"
        zzinputView = ZZInputView()
        self.view.addSubview(zzinputView)
        
        self.dataArray = ZZModel.creatRandomArray(count: 10) //随机产生10条信息
        
        zzinputView.snp_makeConstraints { (make) -> Void in
            make.leading.trailing.equalTo(self.view)
            inputViewConstraint = make.bottom.equalTo(self.view).constraint
        }
        
        //发送文本内容
        zzinputView.sendZZTextBlock = { [weak self] (txt,textView) in
            if txt == ""{
                return
            }
            self?.dataArray.append(ZZModel.creatMessageFromMeByText(txt))
//          let indexPath = NSIndexPath(forRow:self!.dataArray.count-1, inSection: 0)
            self?.chatTableView.reloadData()
            self?.chatTableView.scrollToBottom(animation: true)  
        }
        
        chatTableView = ZZTableView.init(frame: CGRectZero, style: .Plain)
        chatTableView.dataSource = self
        chatTableView.delegate = self
        chatTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        chatTableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.Interactive
        self.view.addSubview(chatTableView)
        chatTableView.snp_makeConstraints { (make) -> Void in
            make.leading.trailing.equalTo(self.view)
            make.top.equalTo(self.snp_topLayoutGuideTop)
            make.bottom.equalTo(zzinputView.snp_top)
        }
//      chatTableView.frame = CGRectMake(0, 0, self.view.zz_width , self.view.zz_height-45)
        
        chatTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        chatTableView.estimatedRowHeight = 100
        
        chatTableView.registerClass(ZZLeftMsgCell.classForKeyedArchiver(), forCellReuseIdentifier: leftCellId)
        chatTableView.registerClass(ZZRightMsgCell.classForKeyedArchiver(), forCellReuseIdentifier: rightCellId)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action:"handleTouches:")
        tapGestureRecognizer.cancelsTouchesInView = false
        self.chatTableView.addGestureRecognizer(tapGestureRecognizer)

        
        zzRefreshView = ZZRefreshView(scrollView: self.chatTableView)
        self.chatTableView.addSubview(zzRefreshView)
        zzRefreshView.refresh = { [weak self] in
//            self.dataArray.append()
            //延时一秒 模拟网络等待
            delay(1, completion: { () -> () in
                let array = ZZModel.creatRandomArray(count: 10)
                
                let currCount = self!.dataArray.count - 1
                var indexPaths:[NSIndexPath] = []
                var i = 0
                for arr in array{
                    let indexPath = NSIndexPath(forRow: i, inSection: 0)
                    indexPaths.append(indexPath)
                    self!.dataArray.insert(arr, atIndex: 0)
                    i++
                }
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    UIView.setAnimationsEnabled(false)
//                    self?.chatTableView.isFresh = true
                    
//                    self?.chatTableView.indexPath = indexPath
                    self?.chatTableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.None)

                    print("\(self!.dataArray.count ) ---- \(array.count)")
                    let indexPath = NSIndexPath(forRow: self!.dataArray.count - currCount - 1 , inSection: 0)
                    self?.chatTableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Top, animated: false)
                    self?.zzRefreshView.endRefresh()
                    delay(0.1, completion: { () -> () in
//                        self?.chatTableView.isFresh = false
                    })
                    UIView.setAnimationsEnabled(true)
                })
            })

        }
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
    
    deinit{
        chatTableView.delegate = nil
        chatTableView.dataSource = nil
        zzinputView = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //Dispose of any resources that can be recreated.
    }
    
    func scrollToBottom(animated animated:Bool){
        let rows = self.chatTableView.numberOfRowsInSection(0)
        if rows == 0 {
            return
        }
        let finalRow = max(0,rows-1)
        let indexPath = NSIndexPath(forRow:finalRow, inSection: 0)
        self.chatTableView.scrollToRowAtIndexPath(indexPath,atScrollPosition: UITableViewScrollPosition.Bottom, animated:animated)
    }
}

extension ViewController{
    
    //键盘跟随
    @objc func keyboardFrameChanged(notification: NSNotification) {
        let dict = NSDictionary(dictionary: notification.userInfo!)
        let keyboardValue = dict.objectForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
        let bottomDistance = UIScreen.mainScreen().bounds.size.height - keyboardValue.CGRectValue().origin.y
        let duration = Double(dict.objectForKey(UIKeyboardAnimationDurationUserInfoKey) as! NSNumber)
//      self.chatTableView.contentOffset.y = self.chatTableView.contentSize.height - self.chatTableView.zz_height
        print(bottomDistance)
        UIView.animateWithDuration(duration, animations: {
               self.inputViewConstraint?.updateOffset(-bottomDistance)
               self.view.layoutIfNeeded()
               if bottomDistance>100{
                    self.scrollToBottom(animated: false)
               }else{
                   self.chatTableView.scrollToBottom(animation: false)
               }
            }, completion: { (value:Bool) in
        })
    }
    
    func handleTouches(sender:UITapGestureRecognizer){
        if sender.locationInView(self.view).y < self.view.bounds.height{
            UIApplication.sharedApplication().sendAction(Selector("resignFirstResponder"), to: nil, from: nil, forEvent: nil)
        }
    }
    
    
    func setTableViewInsetsWithBottomValue(bottom:CGFloat){
        let insets = self.tableViewInsetsWithBottomValue(bottom)
        self.chatTableView.contentInset = insets
        self.chatTableView.scrollIndicatorInsets = insets
    }
    
    // 返回内边距
    func tableViewInsetsWithBottomValue(bottom:CGFloat)->UIEdgeInsets{
        var insets = UIEdgeInsetsZero
        if self.respondsToSelector("topLayoutGuide"){
            insets.top = self.topLayoutGuide.length
        }
        insets.bottom = bottom
        return insets
    }

}

//MARK: - UITableViewDataSource,UITableViewDelegate
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
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.zzRefreshView.scrollViewDidScroll(scrollView)
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}


