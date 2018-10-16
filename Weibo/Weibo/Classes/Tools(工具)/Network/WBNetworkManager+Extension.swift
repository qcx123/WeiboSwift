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
    ///
    /// - Parameter completion: 完成回调
    func statusList(completion:@escaping (_ list: [[String :AnyObject]]?,_ isSuccess: Bool)->()) {
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        let paramer = ["access_token": "2.00x4d2dF0eUCYR60b0914887sYRpWC"]
        
        
        request(URLString: urlString, parameters: paramer as [String : AnyObject]) { (json, isSuccess) in
            // 从json获取statuses数组，如果失败就是nil
            let result = json?["statuses"] as? [[String : AnyObject]]
            
            completion(result,isSuccess)
        }
    }
}
