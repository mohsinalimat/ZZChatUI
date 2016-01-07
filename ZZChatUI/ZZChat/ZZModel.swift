//
//  ZZModel.swift
//  ZZChatUI
//
//  Created by duzhe on 16/1/5.
//  Copyright © 2016年 dz. All rights reserved.
//

import UIKit

enum ZZChatFrom : Int {
    case Me
    case Other
}

class ZZModel: NSObject {

    var from:ZZChatFrom = .Me
    var userName:String!
    var time:String!
    var headImage:UIImage!
    
    var text:String?
    
    static func creatMessageFromMeByText(text:String) -> ZZChatFrame{
        let chatFrame = ZZChatFrame()
        let model = ZZModel()
        model.text = text
        model.configMeBaseInfo()
        chatFrame.model = model
        return chatFrame
    }
    
    private func configMeBaseInfo() {
        self.from = .Me
        self.userName = "小王"
        let formatter = NSDateFormatter()
        formatter.dateFormat = " HH:mm:ss"
        self.time = formatter.stringFromDate(NSDate())
        self.headImage = UIImage(named: "headImage")
    }
    
    static func creatRandomArray(count count:Int) -> [ZZChatFrame] {
        var array = [ZZChatFrame]()
        for _ in 0...(count) {
            let chatFrame = ZZChatFrame()
            let model:ZZModel = ZZModel()
            model.from = random()%2==0 ? .Me:.Other
            model.userName = model.from == .Me ? "小美":"小王"
            let formatter = NSDateFormatter()
            formatter.dateFormat = " HH:mm:ss"
            model.time = formatter.stringFromDate(NSDate())
            model.headImage = UIImage(named: "headImage")
            model.text = ZZModel.randomStr()
            chatFrame.model = model
            array.append(chatFrame)
        }
        return array
    }
    
    class func randomStr() -> String {
        let str:NSMutableString = "我一听，觉得异常别扭，本来我就是一个心直口快的人，见不到别人因为这种事情受什么委屈。我对w说：如果是你问我要书，二话不说一定送你。别跟我提钱不钱的事情，因为你不仅是我同事，也是我朋友对吧。我送的乐意，你也接的开心。但是，你这个初中同学呢？她虽说是你同学，经常动不动找你帮忙，一次是心甘情愿，毕竟看在老同学的面子上，像这种次次都帮忙，就说不过去了吧？你帮的心不甘情不愿的，她反倒接受的心安理得，并且认为你无所不能，她继而得寸进尺还有完没完了？之后引发的矛盾可远远不是心里委屈这种小儿科了。"
        let index: Int = random()%100 + 5
        return str.substringToIndex(index)
    }


}
