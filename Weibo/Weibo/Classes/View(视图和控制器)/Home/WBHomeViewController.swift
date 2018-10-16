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

// 恢复

class WBHomeViewController: WBBaseViewController {

    private lazy var listViewModel = WBStatusListViewModel()

    override func loadData() {
        
        listViewModel.loadStatus { (isSuccess) in
            // 结束刷新
            self.refreshControl?.endRefreshing()
            // 恢复上拉刷新标记
            self.isPullup = false
            // 刷新
            self.tableView?.reloadData()
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
        return listViewModel.statusList.count
    }

    override  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = listViewModel.statusList[indexPath.row].text
        
        return cell
    }
}

// MARK: - 设置界面
extension WBHomeViewController {
    
    override func setupTableView() {
        super.setupTableView()
        // 设置导航栏按钮
        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", fontSize: 12, target: self, action: #selector(showFriends))
        
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
}
