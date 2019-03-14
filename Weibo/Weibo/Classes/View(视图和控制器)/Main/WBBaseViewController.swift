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

    var visitorInfo : [String : String]?
    
    
    // 表哥视图 - 如果没有登录，就不创建
    var tableView : UITableView?
    
    // 下拉刷新
    var refreshControl : UIRefreshControl?
    
    // 上拉刷新标记
    var isPullup = false
    
    
    // 自定义导航条
    lazy var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: UIScreen.main.screenW, height: 44))
    // 自定义导航条目
    lazy var navItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        WBNetworkManager.shared.userLogon ? loadData() : ()
        // Do any additional setup after loading the view.
    }

    @objc func loadData() {
        // 如果子类不重写这个方法，默认关闭刷新控件
        refreshControl?.endRefreshing()
    }
    
    override var title: String? {
        didSet{
            navItem.title = title
        }
    }
    
}

// MARK: - 访客视图监听方法
extension WBBaseViewController {
    
    @objc private func login() {
        print("用户登录")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: WBUserShouldLoginNotification), object: nil)
    }
    
    @objc private func register() {
        print("用户注册")
    }
}

// MARK: - 设置界面
extension WBBaseViewController {
    
    private func setupUI() {
        
        // 取消自动缩进 如果隐藏了导航栏，会缩进 20 个点
        automaticallyAdjustsScrollViewInsets = false
        
        setupNavigationBar()
        WBNetworkManager.shared.userLogon ? setupTableView() : setupVisitorView()
    }
    
    @objc func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.insertSubview(tableView!, belowSubview: navigationBar)
        // 设置数据源&代理 目的：子类直接实现数据源方法
        tableView?.dataSource = self
        tableView?.delegate = self
        
        // 设置内容缩进
        tableView?.contentInset = UIEdgeInsets(top: navigationBar.bounds.height, left: 0, bottom: 0, right: 0)
        
        
        // 设置刷新控件
        // 1> 实例化控件
        refreshControl = UIRefreshControl()
        
        // 2> 添加到表哥视图
        tableView?.addSubview(refreshControl!)
        
        // 3> 添加监听事件
        refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
        
    }
    
    private func setupVisitorView() {
        let visitorView = WBVisitorView(frame: view.bounds)
        self.view.insertSubview(visitorView, belowSubview: navigationBar)
        // 1、根据字典设置访客视图
        visitorView.visitorInfo = visitorInfo
        
        // 2、添加访客视图按钮点击事件
        visitorView.loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        visitorView.registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
        
        // 3、设置导航条按钮
        navItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(register))
        navItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(login))
    }
    
    private func setupNavigationBar() {
        // 添加导航条
        view.addSubview(navigationBar)
        // 将item设置给bar
        navigationBar.items = [navItem]
        // 设置navBar的渲染颜色
        // 设置整个背景的颜色
        navigationBar.barTintColor = UIColor(hexString: "0xF6F6F6")
        navigationBar.backgroundColor = UIColor(hexString: "0xF6F6F6")
        // navbar字体颜色
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.darkGray]
        // 设置系统颜色的文字渲染颜色
        navigationBar.tintColor = UIColor.orange
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
    
    // 在显示最后一行的时候，做上拉刷新
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        // 1.判断indexPath是否是最后一行
        let row = indexPath.row
        let section = tableView.numberOfSections - 1
        
        if row < 0 || section < 0 {
            return
        }
        
        // 行数
        let count = tableView.numberOfRows(inSection: section)
        
        if row == (count - 1) && !isPullup {
            // 上啦刷新
            print("上拉刷新")
            isPullup = true
            
            // 开始刷新
            loadData()
        }
    }
}



