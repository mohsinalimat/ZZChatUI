//
//  ZZLeftChatCell.swift
//  ZZChatUI
//
//  Created by duzhe on 16/1/6.
//  Copyright © 2016年 dz. All rights reserved.
//

import UIKit

class ZZLeftChatCell: UITableViewCell {
    internal var dateLabel: UILabel!
    internal var headImageView: UIButton!
    internal var nameLabel: UILabel!
    internal var contentLabel: ZZLabel!
    internal var messageView:ZZMessageView!
    
    var charFrame:ZZChatFrame!{
        didSet{
            let model = charFrame.model
            
            self.headImageView.frame = charFrame.headImageViewRect
            self.messageView.frame = charFrame.messageViewRect
            self.contentLabel.frame = charFrame.contentLabelRect
            self.contentLabel.text = model.text
        }
    }
    
    
    var imageHeightConstraint: NSLayoutConstraint!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        // 日期
//        dateLabel = UILabel()
//        contentView.addSubview(dateLabel)
//        dateLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
//        dateLabel.textColor = UIColor.grayColor()
  
        
        // 头像
        headImageView = UIButton()
        contentView.addSubview(headImageView)
        headImageView.layer.borderWidth = 4
        headImageView.layer.borderColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.5).CGColor
        headImageView.layer.cornerRadius = 25
        headImageView.clipsToBounds = true
        headImageView.setImage(UIImage(named: "headImage"), forState: UIControlState.Normal)

        
//        nameLabel = UILabel()
//        nameLabel.textColor = UIColor.darkGrayColor()
//        nameLabel.font = UIFont.systemFontOfSize(14)
//        nameLabel.textAlignment = .Left
//        contentView.addSubview(nameLabel)

        
        // 内容frame辅助
        contentLabel = ZZLabel()
        contentView.addSubview(contentLabel)
        contentLabel.font = UIFont.systemFontOfSize(14)
        contentLabel.numberOfLines = 0
        contentLabel.textColor = UIColor.grayColor()

        // 内容视图
        messageView = ZZMessageView()
        messageView.leftWidth = 0
        messageView.messageColor = MESSAGE_BACK
        contentView.insertSubview(messageView, belowSubview: contentLabel)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    //设置内容
    func configUIWithModel(model:ZZModel){
//        self.contentLabel.text = model.text
//        self.dateLabel.text =  model.time
//        self.nameLabel.text = "小美"
    }

}
