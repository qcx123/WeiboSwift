//
//  WBDemoViewController.swift
//  Weibo
//
//  Created by 乔春晓 on 2018/9/6.
//  Copyright © 2018年 乔春晓. All rights reserved.
//

import UIKit

class WBDemoViewController: WBBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.green
        setupTableView()
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - 设置界面
extension WBDemoViewController {
    
    override func setupTableView() {
        super.setupTableView()
        // 设置导航栏按钮
        navItem.rightBarButtonItem = UIBarButtonItem(title: "下一页", fontSize: 12, target: self, action: #selector(showFriends))
    }
}
