//
//  WBNavigationController.swift
//  Weibo
//
//  Created by 乔春晓 on 2018/9/4.
//  Copyright © 2018年 乔春晓. All rights reserved.
//

import UIKit

class WBNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.isHidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        print(viewController)
        // 如果不是栈底控制器才需要隐藏，根控制器不需要处理
        if childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            if let vc = viewController as? WBBaseViewController {
                var title = "返回"
                
                // 判断控制器的级数
                if childViewControllers.count == 1 {
                    // title显示首页标题
                    title = childViewControllers.first?.title ?? "返回"
                }
                // 取出自定义的item
                vc.navItem.leftBarButtonItem = UIBarButtonItem(title: title, fontSize: 12, target: self, action: #selector(popToPatent), isBack: true)
            }
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc private func popToPatent() {
        popViewController(animated: true)
    }

}
