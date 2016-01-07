//
//  ZZRefreshView.swift
//  ZZChatUI
//
//  Created by duzhe on 16/1/6.
//  Copyright © 2016年 dz. All rights reserved.
//

import UIKit

class ZZRefreshView: UIView,UIScrollViewDelegate {
    
    var scrollView:UIScrollView!
    var isRefreshing = false
    var isAnimating = false
    
    private lazy var shapeLayer = CAShapeLayer()
    private var activityIndicator:UIActivityIndicatorView!
    
    
    var refresh:(()->())?   //刷新的闭包
    var progress:CGFloat = 0.0
    
    init(frame: CGRect,scrollView:UIScrollView) {
        super.init(frame: frame)
        self.scrollView = scrollView
        
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.activityIndicatorViewStyle = .Gray
        activityIndicator.hidden = true
        if let tableView = self.scrollView as? UITableView{
            let headV = UIView(frame: CGRectMake(0,0,UIScreen.mainScreen().bounds.width,30))
            headV.backgroundColor = UIColor.whiteColor()
            tableView.tableHeaderView = headV
            headV.addSubview(activityIndicator)
            activityIndicator.frame = CGRectMake((UIScreen.mainScreen().bounds.width-20)/2, (headV.zz_height-20)/2, 20, 20)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(scrollView:UIScrollView){
        if let sv = scrollView.superview {
            self.init(frame:CGRectMake(0,-30, sv.frame.size.width ,30),scrollView:scrollView)
        }else{
            self.init(frame:CGRectMake(0,-30, scrollView.frame.size.width ,30),scrollView:scrollView)
        }
    }
    
    //计算进度
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentSize.height <= scrollView.zz_height{
            var inSet = scrollView.contentInset
            inSet.top = 34
            scrollView.contentInset = inSet
        }else{
            var inSet = scrollView.contentInset
            inSet.top = 64
            scrollView.contentInset = inSet

        }
        if isAnimating{
            return
        }
        let offY = max(-1*(scrollView.contentOffset.y+scrollView.contentInset.top),0)
        if offY>=1{
            beginRefresh()
        }
    }
    
    func beginRefresh(){
        isAnimating = true
        activityIndicator.hidden = false
        activityIndicator.startAnimating()
        refresh?()  //执行刷新操作
    }
    
    func endRefresh(){
        isAnimating = false
        activityIndicator.startAnimating()
        activityIndicator.hidden = true
    }
}
