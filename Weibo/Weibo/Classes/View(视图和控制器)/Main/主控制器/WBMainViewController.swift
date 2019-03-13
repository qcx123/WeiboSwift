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
    
    // 定时器
    private var timer: Timer?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appDelegate.blockRotation = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChildControllers()
        setupComposeButton()
        setupTimer()
        
        // 设置代理
        delegate = self
    }
    
    deinit {
        // 销毁时钟
        timer?.invalidate()
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

extension WBMainViewController: UITabBarControllerDelegate {
    
    /// 将要选择的TabbarItem
    ///
    /// - Parameters:
    ///   - tabBarController: tabBarController
    ///   - viewController: 目标控制器
    /// - Returns: 是否切换到目标控制器
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("将要切换到\(viewController)")
        
        // 1> 获取控制器在数组中的索引
//        let index = (viewControllers as! NSArray).index(of: UIViewController())
        let index = (childViewControllers as NSArray).index(of: viewController)
        // 2> 判断q当前索引是首页，同事index也是首页，重复点击首页b按钮
        if selectedIndex == 0 && index == selectedIndex {
            print("点击了首页")
            // 3> 让表格滚动到顶部
            let nav = childViewControllers[0] as! UINavigationController
            let vc = nav.childViewControllers[0] as! WBHomeViewController
            vc.tableView?.setContentOffset(CGPoint(x: 0, y: -64), animated: true)
            // 4> 刷新表格 -- 增加延迟，是保证表格先滚动到顶部再刷新
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                vc.loadData()
            }
        }
        
        return !viewController.isMember(of: UIViewController.self)
    }
    
}


// MARK: - 时钟相关方法
extension WBMainViewController {
    // 定义时钟
    private func setupTimer() {
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        
        if !WBNetworkManager.shared.userLogon {
            return
        }
        
        // 未读数量
        WBNetworkManager.shared.unreadCount { (count) in
            print("有\(count)条未读消息")
            // 设置首页tabbarItems的badgeNumber
            self.tabBar.items?[0].badgeValue = count > 0 ? "\(count)" : nil
            
            // 设置app的badgeNumber，需要授权才能显示
            UIApplication.shared.applicationIconBadgeNumber = count
        }
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
        // 向内缩进的宽度
        let w = tabBar.bounds.width / count
        composeBtn.frame = CGRect(x: 0, y: 0, width: w, height: tabBar.bounds.height)
        composeBtn.frame = tabBar.bounds.insetBy(dx: 2 * w, dy: 0)// 缩紧
        
        composeBtn.addTarget(self, action: #selector(composeBtnClick), for: .touchUpInside)
    }
    
    // 设置所有自控制器
    private func setupChildControllers() {
        
        // 0.获取沙盒的json路径
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let jsonPath = (docDir as NSString).appendingPathComponent("main.json")
        var data = NSData(contentsOfFile: jsonPath)
        
        // 判断data有没有内容
        if data == nil {
            // 从bundle加载
            let path = Bundle.main.path(forResource: "main.json", ofType: nil)
            data = NSData(contentsOfFile: path!)
            
        }
        
        // 从bundle加载配置json
        // 1.路径
        // 2.加载NSData
        // 3.反序列化
        guard let array = try? JSONSerialization.jsonObject(with: data! as Data, options: []) as? [[String : AnyObject]]
            else {
            return
        }
        
        // 遍历数组，循环创建控制器数组
        var arrayM = [UIViewController]()
        for dict in array! {
            arrayM.append(controller(dict: dict as [String : AnyObject]))
        }
        
        // 设置tabbar图标
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
            let cls = NSClassFromString(Bundle.main.nameSpace + "." + clsName) as? WBBaseViewController.Type,
            let visitorDict = dict["visitorInfo"] as? [String : String]
        else {
            
            return UIViewController()
        }
        
        // 2. 创建视图控制器
        let vc = cls.init()
        vc.title = title
        
        // 设置控制器的访客信息字典
        vc.visitorInfo = visitorDict
        
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
