//
//  WBCommon.swift
//  Weibo
//
//  Created by 乔春晓 on 2019/3/14.
//  Copyright © 2019 乔春晓. All rights reserved.
//

import Foundation

// MARK: - 应用程序信息
// 应用程序 ID
let WBAppKey = "259310452"
// 应用h程序加密信息（开发者可以申请修改）
let WBAppSecret = "0f65fb78704b5d2e8a2d992dca88a4b7"
// 回调地址 - 登录完成跳转的 URL 参数以GET形式拼接
let WBRedirectURI = "http://baidu.com"


// MARK: - 全局通知定义
// 用户需要登录通知
let WBUserShouldLoginNotification = "WBUserShouldLoginNotification"
