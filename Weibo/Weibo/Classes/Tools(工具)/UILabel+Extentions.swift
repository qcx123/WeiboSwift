//
//  UILabel+Extentions.swift
//  Weibo
//
//  Created by 乔春晓 on 2018/9/27.
//  Copyright © 2018年 乔春晓. All rights reserved.
//

import Foundation

extension UILabel {
    convenience init(text : String, fontSize: CGFloat, color: UIColor) {
        self.init()
        self.text = text
        font = UIFont.systemFont(ofSize: fontSize)
        textColor = color
        numberOfLines = 0
        textAlignment = .center
    }
}
