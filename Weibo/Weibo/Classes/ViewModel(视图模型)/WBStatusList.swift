//
//  WBStatusList.swift
//  Weibo
//
//  Created by 乔春晓 on 2018/10/16.
//  Copyright © 2018年 乔春晓. All rights reserved.
//

import Foundation

// 微博数据列表视图模型

/*
 父类的使用
 
 - 如果类需要使用KVC 或者字典转模型框架设置对象值，类就需要继承自NSObject
 - 如果类知识包含装了一些代码逻辑（写了一些函数），可以不用任何父类，好处：更加轻量级
 - 提示：如果用OC写，一律都继承自NSObject即可
 
 使用：负责微博的数据处理
 1.字典转模型
 2.下拉 / 上拉刷新数据处理
 
 */
class WBStatusListViewModel {
    
    // 微博模型数组懒加载
    lazy var statusList = [WBStatus]()
    
    
    
    /// 加载微博列表
    ///
    /// - Parameter completion: 完成回调
    func loadStatus(completion: @escaping (_ isSuccess: Bool)->()) {
        
        WBNetworkManager.shared.statusList { (list, isSuccess) in
            
            // 1. 字典转模型
            guard let array = NSArray.yy_modelArray(with: WBStatus.self, json: list ?? []) as? [WBStatus] else{
                completion(isSuccess)
                return
            }
            // 2.拼接数据
            self.statusList += array
            // 3.完成回调
            completion(isSuccess)
            
        }
        
    }
}
