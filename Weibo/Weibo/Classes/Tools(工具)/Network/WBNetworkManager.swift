//
//  WBNetworkManager.swift
//  Weibo
//
//  Created by 乔春晓 on 2018/10/15.
//  Copyright © 2018年 乔春晓. All rights reserved.
//

import UIKit
import AFNetworking // 导入框架文件夹的名字

// 网络管理工具
class WBNetworkManager: AFHTTPSessionManager {

    // 单例
    // 静态去 / 常量 / 闭包
    // 在第一次访问时，执行闭包，并且将结果保存在shared常量中
    static let shared = WBNetworkManager()
    
}
