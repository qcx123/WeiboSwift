//
//  WBNetworkManager+Extension.swift
//  Weibo
//
//  Created by 乔春晓 on 2018/10/16.
//  Copyright © 2018年 乔春晓. All rights reserved.
//

import Foundation


// MARK: - 封装新浪微博的请求
extension WBNetworkManager {
    
    
    /// 加载微博的网络请求方法
    /// - Parameters:
    ///   - since_id: 返回id比since_id大的微博（即比since_id时间晚的微博，下拉刷新用到）默认是0
    ///   - max_id: 返回id小于或等于max_id的微博，默认是0
    ///   - completion: 完成回调
    func statusList(since_id: Int64 = 0, max_id: Int64 = 0, completion:@escaping (_ list: [[String :AnyObject]]?,_ isSuccess: Bool)->()) {
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        // Swift 中Int可以转成AnyObject/ 但是Int64不行
//        let params = ["since_id" : "\(since_id)"]
        let params = ["since_id" : since_id, "max_id": max_id > 0 ? max_id - 1 : 0]
        
        tokenRequest(URLString: urlString, parameters: params as [String : AnyObject]) { (json, isSuccess) in
            // 从json获取statuses数组，如果失败就是nil
            let result = json?["statuses"] as? [[String : AnyObject]]
            
            completion(result,isSuccess)
        }
    }
}
