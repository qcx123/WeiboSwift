//
//  WBMainViewController.swift
//  Weibo
//
//  Created by 乔春晓 on 2018/9/4.
//  Copyright © 2018年 乔春晓. All rights reserved.
//

import UIKit

class WBMainViewController: UITabBarController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appDelegate.blockRotation = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChildControllers()
        setupComposeButton()
        
        
        
    }
    
    private lazy var composeBtn : UIButton = UIButton.init(imageName: "tabbar_compose_icon_add", backgroundImageName: "tabbar_compose_button")

    // @objc 允许这个函数在 运行时 通过 OC 的消息机制被调用
    @objc private func composeBtnClick() {
        print("撰写微博")
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


// extension 类似于 OC 中的分类， 在Swift 中还可以用来切粉代码块
// 可以把相近功能的函数 放在一个extension中
// 便于代码维护
// 注意：和OC的分类一样，不能定义属性

// 设置界面
extension WBMainViewController {
    
    private func setupComposeButton() {
        tabBar.addSubview(composeBtn)
        // 计算高度
        let count = CGFloat(childViewControllers.count)
        // 向内缩进的宽度减少，能够让按钮的宽度变大，盖住容错点
        let w = tabBar.bounds.width / count - 1
        composeBtn.frame = CGRect(x: 0, y: 0, width: w, height: tabBar.bounds.height)
        composeBtn.frame = tabBar.bounds.insetBy(dx: 2 * w, dy: 0)// 缩紧
        
        composeBtn.addTarget(self, action: #selector(composeBtnClick), for: .touchUpInside)
    }
    
    // 设置所有自控制器
    private func setupChildControllers() {
        let array = [
            ["clsName" : "WBHomeViewController", "title" : "首页", "imageName" : "home", "visitorInfo" : ["imageName" : "", "message" : "关注一些人，回这里看看有什么惊喜"]],
            ["clsName" : "WBMessageViewController", "title" : "消息", "imageName" : "message_center", "visitorInfo" : ["imageName" : "visitordiscover_image_message", "message" : "登录后，别人评论你的微博，发给你的消息，都会在这里收到通知"]],
            ["clsName" : "UIViewController"],
            ["clsName" : "WBDiscoverViewController", "title" : "发现", "imageName" : "discover", "visitorInfo" : ["imageName" : "visitordiscover_image_message", "message" : "登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过"]],
            ["clsName" : "WBProfileViewController", "title" : "我", "imageName" : "profile", "visitorInfo" : ["imageName" : "visitordiscover_image_profile", "message" : "登录后，你的微博、相册、个人资料会显示在这里，展示给别人"]]
        ]
        // 测试数据格式是否正确，转换成plist更加直观
        (array as NSArray).write(toFile: "/Users/qiaochunxiao/Desktop/demo.plist", atomically: true)
        
        var arrayM = [UIViewController]()
        for dict in array {
            arrayM.append(controller(dict: dict as [String : AnyObject]))
        }
        
        viewControllers = arrayM
    }
    /// 使用字典创建一个子控制器
    ///
    /// - Parameter dict: 信息字典[clsName, title, imageName, visitorInfo]
    /// - Returns: 子控制器
    private func controller(dict : [String : AnyObject]) -> UIViewController {
        // 1.取字典内容
        guard let clsName = dict["clsName"] as? String,
            let title = dict["title"] as? String,
            let imageName = dict["imageName"] as? String,
            let cls = NSClassFromString(Bundle.main.nameSpace + "." + clsName) as? UIViewController.Type
        else {
            
            return UIViewController()
        }
        
        // 2. 创建视图控制器
        let vc = cls.init()
        vc.title = title
        // 3. 设置图片
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_highlighted")?.withRenderingMode(.alwaysOriginal)
        // 4. 设置tabbar标题字体
        vc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor .orange , NSAttributedStringKey.font : UIFont.systemFont(ofSize: 13)], for: UIControlState.selected)
        vc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 12)], for: UIControlState(rawValue: 0))
        let nav = WBNavigationController(rootViewController: vc)
        
        return nav
    }
}
