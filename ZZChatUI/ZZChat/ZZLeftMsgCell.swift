//
//  ZZLeftMsgCell.swift
//  ZZChatUI
//  左边试图msg
//  Created by duzhe on 16/1/5.
//  Copyright © 2016年 dz. All rights reserved.
//

import UIKit

class ZZLeftMsgCell: UITableViewCell {

    internal var dateLabel: UILabel!
    internal var headImageView: UIButton!
    internal var nameLabel: UILabel!
    
    internal var contentLabel: ZZLabel!
    
    internal var messageView:ZZMessageView!
    
    var imageHeightConstraint: NSLayoutConstraint!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        // 日期
        dateLabel = UILabel()
        contentView.addSubview(dateLabel)
        dateLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
        dateLabel.textColor = UIColor.grayColor()
        dateLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(contentView).offset(4)
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
            make.leading.equalTo(10)
            make.top.equalTo(dateLabel).offset(20)
        }
        
        nameLabel = UILabel()
        nameLabel.textColor = UIColor.darkGrayColor()
        nameLabel.font = UIFont.systemFontOfSize(14)
        nameLabel.textAlignment = .Left
        contentView.addSubview(nameLabel)
        nameLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(headImageView.snp_right).offset(5)
            make.right.equalTo(contentView).offset(10)
            make.top.equalTo(headImageView)
            make.height.equalTo(20)
        }
        
        // 内容frame辅助
        contentLabel = ZZLabel()
        contentView.addSubview(contentLabel)
        contentLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        contentLabel.numberOfLines = 0
        contentLabel.textColor = UIColor.grayColor()
        contentLabel.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(90)
            make.width.lessThanOrEqualTo(contentView).multipliedBy(0.6)
            make.top.equalTo(nameLabel.snp_bottom).offset(15)
            make.bottom.equalTo(-20).priorityLow()
        }
        
        // 内容视图
        messageView = ZZMessageView()
        messageView.leftWidth = 0
        messageView.messageColor = MESSAGE_BACK
        contentView.insertSubview(messageView, belowSubview: contentLabel)
        
        messageView.snp_makeConstraints { (make) -> Void in
            make.leading.equalTo(contentView).offset(70)
            make.trailing.equalTo(contentLabel.snp_trailing).offset(10)
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
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configUIWithModel(model:ZZModel){
        self.contentLabel.text = model.text
        self.dateLabel.text =  model.time
        self.nameLabel.text = "小美"
    }
    
}
