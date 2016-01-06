//
//  Extension+Add.swift
//  ZZChatUI
//
//  Created by duzhe on 16/1/5.
//  Copyright © 2016年 dz. All rights reserved.
//

import UIKit


extension UIView {
    
    var zz_height:CGFloat{
        set(v){
            self.frame.size.height = v
        }
        get{
            return self.frame.size.height
        }
    }
    
    var zz_width:CGFloat{
        set(v){
            self.frame.size.width = v
        }
        get{
            return self.frame.size.width
        }
    }

    
    var zz_size:CGSize{
        set(v){
            self.frame.size = v
        }
        get{
            return self.frame.size
        }
    }
    
    public var zz_left:CGFloat{
        set(new){
            self.frame.origin.x = new
        }
        get{
            return self.frame.origin.x
        }
    }
    
    public var zz_right:CGFloat{
        set(new){
            self.frame.origin.x = new
        }
        get{
            return  self.frame.origin.x + self.frame.size.width
        }
    }
    
    public var zz_top:CGFloat{
        set(v){
            frame.origin.y = v
        }
        get{
            return self.frame.origin.y
        }
    }
    
    public var zz_bottom:CGFloat{
        set(v){
            self.frame.origin.y = v - self.frame.size.height
        }
        get{
            return self.frame.origin.y + self.frame.size.height
        }
    }
    
    
    public var zz_origin:CGPoint{
        set(v){
            self.frame.origin = v
        }
        get{
            return self.frame.origin
        }
    }
    
    //查找vc
    func responderViewController() -> UIViewController {
        var responder: UIResponder! = nil
        for var next = self.superview; (next != nil); next = next!.superview {
            responder = next?.nextResponder()
            if (responder!.isKindOfClass(UIViewController)){
                return (responder as! UIViewController)
            }
        }
        return (responder as! UIViewController)
    }
}


extension UIScrollView {
    
    func scrollToBottom(animation animation:Bool) {
        let visibleBottomRect = CGRectMake(0, contentSize.height-1, 1, 1)
        UIView.animateWithDuration(animation ? 0.2:0.0) { () -> Void in
            self.scrollRectToVisible(visibleBottomRect, animated: true)
        }
        
    }
    
}





