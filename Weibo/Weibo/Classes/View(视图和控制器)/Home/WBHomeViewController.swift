//
//  WBHomeViewController.swift
//  Weibo
//
//  Created by 乔春晓 on 2018/9/4.
//  Copyright © 2018年 乔春晓. All rights reserved.
//

import UIKit

// 定义全局常量，尽量使用 private 修饰，否则到处都可以访问
private let cellId = "cellId"

class WBHomeViewController: WBBaseViewController {

    private lazy var stateList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.cyan
        setupUI()
        loadData()
    }

    func loadData() {
        for i in 1..<10 {
            stateList.insert(i.description, at: 0)
        }
    }
    
    @objc private func showFriends() {
        let vc = WBDemoViewController()
        navigationController?.pushViewController(vc, animated: true)
        
        print(#function)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - 表格数据源方法，具体数据源方法实现，不需要 super
extension WBHomeViewController {
    
    override  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stateList.count
    }

    override  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = stateList[indexPath.row]
        
        return cell
    }
}

// MARK: - 设置界面
extension WBHomeViewController {
    
    override func setupUI() {
        super.setupUI()
        // 设置导航栏按钮
        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", fontSize: 12, target: self, action: #selector(showFriends))
        
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
}
