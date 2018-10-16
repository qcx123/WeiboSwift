//
//  WBStatus.swift
//  Weibo
//
//  Created by 乔春晓 on 2018/10/16.
//  Copyright © 2018年 乔春晓. All rights reserved.
//

import UIKit
import YYModel

// 微博数据模型
class WBStatus: NSObject {

    // Int 类型 在64位的机器上是64位，在32位机器上是32位
    // 如果不写 Int64 在iPad2/iPhone 5/5c/4s/4都无法正常运行
    var id: Int64 = 0
    // 微博信息内容
    var text: String?
    
    // 重写description的计算型属性
    override var description: String {
        return yy_modelDescription()
    }
}
