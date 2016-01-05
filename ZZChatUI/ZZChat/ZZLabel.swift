//
//  ZZLabel.swift
//  ZZChatUI
//
//  Created by duzhe on 16/1/5.
//  Copyright © 2016年 dz. All rights reserved.
//

import UIKit


public class ZZLabel: UILabel {
    
    // MARK: - init functions
    override public init(frame: CGRect) {
        super.init(frame: frame)
        attachTapHandler()
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        attachTapHandler()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}



//MARK: -添加复制功能
extension ZZLabel{
    
    public override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    public override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        return (action == Selector("copy:"))
    }
    
    public override func copy(sender: AnyObject?) {
        let pboard = UIPasteboard.generalPasteboard()
        pboard.string = self.text
    }
    
    func attachTapHandler(){
        self.userInteractionEnabled = true
        let longPress = UILongPressGestureRecognizer(target: self, action: "longPress:")
        self.addGestureRecognizer(longPress)
    }
    
    //MARK: -长按
    func longPress(gesture:UILongPressGestureRecognizer){
        //        let location = gesture.locationInView(self)
        self.becomeFirstResponder()
        //        let copy = UIMenuItem(title: "拷贝", action: "zzCopy")
        //        UIMenuController.sharedMenuController().menuItems = [copy]
        UIMenuController.sharedMenuController().setTargetRect(self.frame, inView: self.superview!)
        UIMenuController.sharedMenuController().setMenuVisible(true, animated: true)
    }
    
}


extension ZZLabel: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}

