//
//  ZZTableView.swift
//  ZZChatUI
//
//  Created by duzhe on 16/1/6.
//  Copyright © 2016年 dz. All rights reserved.
//

import UIKit

public class ZZTableView: UITableView {

    var fromSend = false
    
    public override var contentSize:CGSize{
        didSet{
            
            if !fromSend{
                if !CGSizeEqualToSize(oldValue, CGSizeZero){
                    print("\(oldValue.height) .... \(contentSize.height)")
                    if contentSize.height >  oldValue.height
                    {
                        var offset = self.contentOffset;
                        offset.y += (contentSize.height - oldValue.height);
                        self.contentOffset = offset;
                    }
                }
            }
        }
    }

    
}

func CGSizeEqual (sizeA:CGSize,_ sizeB:CGSize)->Bool{
    if sizeA.width == sizeB.width && sizeA.height == sizeB.height{
        return true
    }
    return false
}
