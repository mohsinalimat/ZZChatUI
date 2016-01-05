//
//  ZZRightCell.swift
//  ZZChatUI
//
//  Created by duzhe on 16/1/5.
//  Copyright © 2016年 dz. All rights reserved.
//

import UIKit


let MAIN_COLOR = UIColor(red: 52/255.0, green: 197/255.0, blue:170/255.0, alpha: 1.0)
let MESSAGE_BACK =  UIColor(red: 0xE6/255.0, green: 0xE5/255.0, blue: 0xEB/255.0, alpha: 1.0)
class ZZRightMsgCell: UITableViewCell {

    internal var dateLabel: UILabel!
    internal var headImageView: UIButton!
    internal var nameLabel: UILabel!
    
    internal var contentLabel: ZZLabel!
    
    internal var messageView:ZZMessageView!
    
    internal var imageHeightConstraint: NSLayoutConstraint!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        // 日期
        dateLabel = UILabel()
        contentView.addSubview(dateLabel)
        dateLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
        dateLabel.textColor = UIColor.grayColor()
        dateLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(contentView)
            make.centerX.equalTo(contentView)
        }
        
        // 头像
        headImageView = UIButton()
        contentView.addSubview(headImageView)
        headImageView.layer.borderWidth = 4
        headImageView.layer.borderColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.5).CGColor
        headImageView.layer.cornerRadius = 25
        headImageView.clipsToBounds = true
        headImageView.setImage(UIImage(named: "headImage"), forState: UIControlState.Normal)
        headImageView.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.right.equalTo(self.contentView).inset(16)
            make.top.equalTo(dateLabel).offset(20)
        }
        
        nameLabel = UILabel()
        nameLabel.textColor = UIColor.darkGrayColor()
        nameLabel.font = UIFont.systemFontOfSize(14)
        nameLabel.textAlignment = .Right
        contentView.addSubview(nameLabel)
        nameLabel.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(headImageView.snp_left).offset(-5)
            make.left.equalTo(contentView).offset(10)
            make.top.equalTo(headImageView)
        }
        
        // 内容frame辅助
        contentLabel = ZZLabel()
        contentView.addSubview(contentLabel)
        contentLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        contentLabel.numberOfLines = 0
        contentLabel.textColor = UIColor.whiteColor()
        contentLabel.snp_makeConstraints { (make) -> Void in
            make.trailing.equalTo(-90)
            make.width.lessThanOrEqualTo(contentView).multipliedBy(0.6)
            make.top.equalTo(nameLabel.snp_bottom).offset(15)
            make.bottom.equalTo(-20).priorityLow()
        }
        
        
        // 内容视图
        messageView = ZZMessageView()
        messageView.leftWidth = 0
        messageView.messageColor = MAIN_COLOR
        contentView.insertSubview(messageView, belowSubview: contentLabel)

        messageView.snp_makeConstraints { (make) -> Void in
            make.trailing.equalTo(contentView).offset(-70)
            make.left.equalTo(contentLabel.snp_left).offset(-10)
            make.top.equalTo(nameLabel.snp_bottom).offset(5)
            make.bottom.equalTo(contentLabel.snp_bottom).offset(10)
        }
        
     
        
        // temporary method
        imageHeightConstraint = NSLayoutConstraint(
            item: messageView,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.LessThanOrEqual,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1,
            constant: 1000
        )
        imageHeightConstraint.priority = UILayoutPriorityRequired
        messageView.addConstraint(imageHeightConstraint)
        
        //旋转180度
        messageView.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI), 0, 1, 0)
        
    }
    
    func configUIWithModel(model: ZZModel){
        self.dateLabel.text = model.time
        self.contentLabel.text = model.text
        self.nameLabel.text = "小王"
    }
    
}
