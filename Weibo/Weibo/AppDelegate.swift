//
//  AppDelegate.swift
//  Weibo
//
//  Created by 乔春晓 on 2018/9/4.
//  Copyright © 2018年 乔春晓. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var blockRotation = Bool()
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .carPlay, .sound]) { (isSuccess, error) in
                print("授权\(isSuccess ? "成功" : "失败")")
            }
        } else {
            // iOS 10.0以下
            // 获得用户授权显示通知（提示条/声音/badgeNumber）
            let notifySettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(notifySettings)
        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = WBMainViewController()
        window?.makeKeyAndVisible()
        
        loadAppInfo()
        
        return true
    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if blockRotation {
            return .allButUpsideDown
        }
        return .portrait
    }


}


// MARK: - 从服务器加载应用程序信息

extension AppDelegate {
    
    private func loadAppInfo() {
        
        // 1.模拟异步
        DispatchQueue.global().async {
            // 1> url
            let url = Bundle.main.url(forResource: "main.json", withExtension: nil)
            
            // 2> data
            let data = NSData(contentsOf: url!)
            
            // 3>写入磁盘
            let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            let jsonPath = (docDir as NSString).appendingPathComponent("main,json")

            data?.write(toFile: jsonPath, atomically: true)
            print("应用加载完毕 \(jsonPath)")
            
        }
        
    }
    
}

