//
//  WBBaseViewController.swift
//  Weibo
//
//  Created by 乔春晓 on 2018/9/4.
//  Copyright © 2018年 乔春晓. All rights reserved.
//

import UIKit

class WBBaseViewController: UIViewController {
    
    // 表哥视图 - 如果没有登录，就不创建
    var tableView : UITableView?
    
    
    // 自定义导航条
    lazy var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: UIScreen.main.screenW, height: 44))
    // 自定义导航条目
    lazy var navItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var title: String? {
        didSet{
            navItem.title = title
        }
    }
    
}


// MARK: - 设置界面
extension WBBaseViewController {
    
    @objc func setupUI() {
        setupNavigationBar()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.insertSubview(tableView!, belowSubview: navigationBar)
    }
    
    private func setupNavigationBar() {
        // 添加导航条
        view.addSubview(navigationBar)
        // 将item设置给bar
        navigationBar.items = [navItem]
        // 设置navBar的渲染颜色
        navigationBar.barTintColor = UIColor(hexString: "0xF6F6F6")
        navigationBar.backgroundColor = UIColor(hexString: "0xF6F6F6")
        // navbar字体颜色
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.darkGray]
    }
    
}
