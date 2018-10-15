//
//  UIBarButtonItem+Extensions.swift
//  Weibo
//
//  Created by 乔春晓 on 2018/9/5.
//  Copyright © 2018年 乔春晓. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    
    /// 创建UIBarButtonItem
    ///
    /// - Parameters:
    ///   - title: title
    ///   - fontSize: 字体发小 默认12
    ///   - target: target
    ///   - action: action
    ///   - isBack: 是否是返回按钮，如果是，加上尖头
    convenience init(title : String, fontSize : CGFloat = 12, target : AnyObject?, action : Selector, isBack : Bool = false) {
        
        let leftBtn = UIButton(type: .custom)
        leftBtn.setTitle(title, for: .normal)
        leftBtn.setTitleColor(UIColor.darkGray, for: .normal)
        leftBtn.setTitleColor(UIColor.orange, for: .highlighted)
        leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        leftBtn.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        if isBack {
            leftBtn.setImage(UIImage(named: "back"), for: .normal)
            leftBtn.setImage(UIImage(named: "backH"), for: .highlighted)
        }
        leftBtn.sizeToFit()
        self.init(customView: leftBtn)
//        self.imageInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
    
}
