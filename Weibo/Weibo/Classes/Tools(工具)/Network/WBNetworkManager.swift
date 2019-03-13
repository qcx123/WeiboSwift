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
    
    // 访问令牌，所有网络请求都要用到（登录除外）
    // 访问令牌有时限,g过期后服务器返回的是403
    var accessToken : String? = "2.00x4d2dF0eUCYR60b0914887sYRpWC"
    // 用户微博id
    var uid: String? = "5162097553"
    
    // 用户登录标记（计算型属性）
    var userLogon : Bool {
        return accessToken != nil
    }
    
    
    // 专门拼接 token 的网络请求方法
    func tokenRequest(method: WBHTTPMethod = .GET, URLString: String, parameters: [String : AnyObject]?, completion: @escaping (_ json: AnyObject?, _ isSuccess: Bool) -> Void) {
        
        // 处理token
        // 0> 判断token是否为nil
        guard let token = accessToken else {
            // FIXME: 发送通知
            print("没有token，需要登录")
            completion(nil, false)
            return
        }
        // 1> 判断参数字典是否存在
        var parameters = parameters
        
        if parameters == nil {
            parameters = [String : AnyObject]()
        }
        
        // 2> 设置参数字典，代码在此处，parameters一定有值
        parameters!["access_token"] = token as AnyObject
        
        // 调用request发起真正的请求
        request(URLString: URLString, parameters: parameters!, completion: completion)
    }
    
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
            if (task?.response as? HTTPURLResponse)?.statusCode == 403 {
                print("token过期了")
                // FIXME: 发送通知 提醒用户再次登陆
            }
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
