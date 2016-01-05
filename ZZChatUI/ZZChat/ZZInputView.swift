//
//  ZZInputView.swift
//  ZZChatUI
//
//  Created by duzhe on 16/1/5.
//  Copyright © 2016年 dz. All rights reserved.
//

import UIKit
import SnapKit

typealias ZZTextBlock  = (text:String,textView:UITextView)->Void

@available(iOS 8.0,*)
final class ZZInputView: UIToolbar,UITextViewDelegate{
    
    var rightButton: UIButton!
    var contentTextView: UITextView!
    var placeHolderLabel: UILabel!
    
    var contentViewHeightConstraint: NSLayoutConstraint!
    
    var sendZZTextBlock:ZZTextBlock?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //右边发送按钮
        rightButton = UIButton()
        self.addSubview(rightButton)
        rightButton.setImage(UIImage(named: "send3"), forState: .Normal)
        rightButton.addTarget(self, action: "sendMsg", forControlEvents: .TouchUpInside)
        rightButton.snp_makeConstraints { (make) -> Void in
            make.trailing.bottom.equalTo(self).offset(-8)
            make.height.width.equalTo(30)
        }
        
        contentTextView = UITextView()
        self.addSubview(contentTextView)
        contentTextView.layer.cornerRadius = 4
        contentTextView.layer.borderWidth = 0.5
        contentTextView.layer.borderColor = UIColor.lightGrayColor().CGColor
        contentTextView.delegate = self
        contentTextView.returnKeyType = .Send
        contentTextView.enablesReturnKeyAutomatically = true
        contentTextView.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(self).offset(8)
            make.trailing.equalTo(self).offset(-45)
            make.top.equalTo(self).offset(8)
            make.bottom.equalTo(self).offset(-8)
            make.height.greaterThanOrEqualTo(30)
        }
        
        // temporary method
        contentViewHeightConstraint = NSLayoutConstraint(
            item: contentTextView,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1,
            constant: 30
        )
        contentViewHeightConstraint.priority = UILayoutPriorityDefaultHigh
        contentTextView.addConstraint(contentViewHeightConstraint)
        
        placeHolderLabel = UILabel()
        placeHolderLabel.text = "请在这里输入文本内容"
        placeHolderLabel.font = UIFont.systemFontOfSize(13)
        
        placeHolderLabel.textColor = UIColor.lightGrayColor()
        placeHolderLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        contentTextView.addSubview(placeHolderLabel)
        placeHolderLabel.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(contentTextView)
            make.left.equalTo(contentTextView).offset(10)
        }
    }

    //发送信息
    func sendMsg(){
        print("发送信息")
        self.sendZZTextBlock?(text: contentTextView.text, textView: contentTextView)
        contentTextView.text = ""
        self.textViewDidChange(contentTextView)
        contentTextView.resignFirstResponder()
    }
    
    
    //MARK: textViewDelegate
    func textViewDidBeginEditing(textView: UITextView) {
        placeHolderLabel.hidden = true
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        placeHolderLabel.hidden = !textView.text.isEmpty
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text != "\n" {
            return true
        } else {
            // 发送文本
            self.sendZZTextBlock?(text: contentTextView.text, textView: contentTextView)
            textView.text = ""
            self.textViewDidChange(textView)
            return false
        }
    }
    
    //文本变化时变化textview的高度 30 - 100
    func textViewDidChange(textView: UITextView) {
        let textContentH = textView.contentSize.height
        print("高度：\(textContentH)")
        let textHeight = textContentH>30 ? (textContentH<100 ? textContentH:100):30
        UIView.animateWithDuration(0.2) { () -> Void in
            self.contentViewHeightConstraint.constant = textHeight
            self.layoutIfNeeded()
            self.superview?.layoutIfNeeded()
            if let vc = self.responderViewController() as? ViewController{
                vc.view.layoutIfNeeded()
                //TODO  - 发送次数多的时候 按下第一个字母 会下沉一点---不知道为啥呀
                vc.chatTableView.scrollToBottom(animation: false)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
