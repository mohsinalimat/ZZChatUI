//
//  ZZMessageView.swift
//  ZZChatUI
//
//  Created by duzhe on 16/1/5.
//  Copyright © 2016年 dz. All rights reserved.
//

import UIKit

@IBDesignable
class ZZMessageView: UIView {
    
    @IBInspectable var messageColor:UIColor = UIColor.grayColor()
    @IBInspectable var leftWidth:CGFloat = 5
    var contentLable:UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func drawRect(rect: CGRect) {
        //画一个气泡
        let color0 = messageColor
        let shapePath = UIBezierPath()
        shapePath.moveToPoint(CGPointMake(self.zz_width, self.zz_height))
        shapePath.addLineToPoint(CGPointMake(self.zz_width, 2))
        shapePath.addCurveToPoint(CGPointMake(self.zz_width-2, 0), controlPoint1: CGPointMake(self.zz_width, 0.89), controlPoint2: CGPointMake(self.zz_width-2, 0))
        shapePath.addLineToPoint(CGPointMake(0, 0))
        shapePath.addLineToPoint(CGPointMake(8, 8))
        shapePath.addLineToPoint(CGPointMake(8, self.zz_height))
        shapePath.addCurveToPoint(CGPointMake(10, self.zz_height), controlPoint1: CGPointMake(8, self.zz_height-2), controlPoint2: CGPointMake(8.9, self.zz_height))
        shapePath.addLineToPoint(CGPointMake(self.zz_width-2, self.zz_height))
        shapePath.addCurveToPoint(CGPointMake(self.zz_width, self.zz_height-2), controlPoint1: CGPointMake(self.zz_width-2, self.zz_height), controlPoint2: CGPointMake(self.zz_width, self.zz_height-2))
        shapePath.addLineToPoint(CGPointMake(self.zz_width, self.zz_height-2))
        shapePath.closePath()
        shapePath.miterLimit = 4;
        
        shapePath.usesEvenOddFillRule = true;
        color0.setFill()
        shapePath.fill()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setNeedsDisplay()
    }
}
