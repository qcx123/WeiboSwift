//
//  WBBaseViewController.swift
//  Weibo
//
//  Created by 乔春晓 on 2018/9/4.
//  Copyright © 2018年 乔春晓. All rights reserved.
//

import UIKit

// 面试题：OC中支持多继承吗？ 如果不支持如何替代。不支持，用协议替代
// Swift 的写法更类似于多继承
//class WBBaseViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

// Swift 中 利用 extension 可以吧函数按照功能分类管理，便于阅读和维护
// 注意：
// 1. extension 中不能有属性
// 2. extension 中不能重写父类方法，重写父类方法是子类的职责，扩展事对类的扩展

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
        // 设置数据源&代理 目的：子类直接实现数据源方法
        tableView?.dataSource = self
        tableView?.delegate = self
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

extension WBBaseViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    // 基类只是准备方法，子类负责具体实现
    // 子类的数据源方法不需要 super
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 只是保证没有语法错误
        return UITableViewCell()
    }
    
}
