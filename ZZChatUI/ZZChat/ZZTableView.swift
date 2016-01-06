//
//  ZZTableView.swift
//  ZZChatUI
//
//  Created by duzhe on 16/1/6.
//  Copyright © 2016年 dz. All rights reserved.
//

import UIKit

public class ZZTableView: UITableView {

    var isFresh = false
    var indexPath:NSIndexPath?
//    public override var contentSize:CGSize {
//
//        didSet{
//            if isFresh{
//                if let indexPath = indexPath{
//                    
//                }
//            }
//        }
//    }
    
}

func CGSizeEqual (sizeA:CGSize,_ sizeB:CGSize)->Bool{
    if sizeA.width == sizeB.width && sizeA.height == sizeB.height{
        return true
    }
    return false
}
