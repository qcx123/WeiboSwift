//
//  WBNetworkManager.swift
//  Weibo
//
//  Created by 乔春晓 on 2018/10/15.
//  Copyright © 2018年 乔春晓. All rights reserved.
//

import UIKit
import AFNetworking // 导入框架文件夹的名字

// Swift 的枚举支持任意类型
enum WBHTTPMethod {
    case GET
    case POST
}

// 网络管理工具
class WBNetworkManager: AFHTTPSessionManager {

    // 单例
    // 静态去 / 常量 / 闭包
    // 在第一次访问时，执行闭包，并且将结果保存在shared常量中
    static let shared = WBNetworkManager()
    
    
    /// 使用afn封装GET/POST请求
    ///
    ///   - Parameters:
    ///   - method: GET / POST
    ///   - URLString: url
    ///   - parameters: 参数字典
    ///   - completion: 完成回调[json(字典/数组)，是否成功]
    func request(method: WBHTTPMethod = .GET, URLString: String, parameters: [String : AnyObject], completion: @escaping (_ json: AnyObject?, _ isSuccess: Bool) -> Void) {

        let success = {(task: URLSessionDataTask, json: Any?)->() in
            completion(json as AnyObject,true)
        }

        let failure = {(task: URLSessionDataTask?, error: Error)->() in
            print(error)
            completion(nil,false)
        }

        if method == .GET {
            get(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }else{
            post(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
    }
}
