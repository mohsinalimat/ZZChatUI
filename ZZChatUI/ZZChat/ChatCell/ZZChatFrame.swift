//
//  ZZLeftChatFrame.swift
//  ZZChatUI
//
//  Created by duzhe on 16/1/6.
//  Copyright © 2016年 dz. All rights reserved.
//

import UIKit

let Marginx:CGFloat = 5
let MarginY:CGFloat = 5
let kEdageMargin:CGFloat = 16
let kTopMargin:CGFloat = 20
let kHeadWidAndHei:CGFloat = 50
class ZZChatFrame: NSObject {

//    internal var dateLabelRect: CGRect!
    internal var headImageViewRect: CGRect!
//    internal var nameLabelRect: CGRect!
    internal var contentLabelRect: CGRect!
    internal var messageViewRect:CGRect!
    internal var model:ZZModel!{
        didSet{
            let winSize = UIScreen.mainScreen().bounds.size
            let contentY = kTopMargin + kHeadWidAndHei/2
            let content:NSString = model.text! as NSString
            let contentSize = content.boundingRectWithSize(CGSizeMake(winSize.width*0.6, CGFloat.max), options: [NSStringDrawingOptions.TruncatesLastVisibleLine ,NSStringDrawingOptions.UsesLineFragmentOrigin,NSStringDrawingOptions.UsesLineFragmentOrigin,NSStringDrawingOptions.UsesFontLeading] , attributes: [NSFontAttributeName:UIFont.systemFontOfSize(14)], context: nil).size
            var contentX:CGFloat = 0
            if model.from == ZZChatFrom.Other{ //其他人
                self.headImageViewRect = CGRectMake(kEdageMargin, kTopMargin, kHeadWidAndHei , kHeadWidAndHei)
                contentX = kEdageMargin + kHeadWidAndHei + Marginx + 20
                messageViewRect = CGRectMake(contentX - 20, contentY-10, contentSize.width+30, contentSize.height+20)
            }else{ //自己
                self.headImageViewRect = CGRectMake(winSize.width - kEdageMargin - kHeadWidAndHei, kTopMargin, kHeadWidAndHei , kHeadWidAndHei)
                contentX = headImageViewRect.origin.x - contentSize.width - Marginx - 20
                messageViewRect = CGRectMake(contentX - 10, contentY-10, contentSize.width+30, contentSize.height+20)
            }
            contentLabelRect = CGRectMake(contentX, contentY, contentSize.width, contentSize.height)

            cellHeight = max(CGRectGetMaxY(messageViewRect), CGRectGetMaxY(headImageViewRect)) + MarginY
        }
    }
    internal var cellHeight:CGFloat = 0
}
