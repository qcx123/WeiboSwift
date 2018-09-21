//
//  WBVisitorView.swift
//  Weibo
//
//  Created by 乔春晓 on 2018/9/21.
//  Copyright © 2018年 乔春晓. All rights reserved.
//

import UIKit

class WBVisitorView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension WBVisitorView {
    func setupUI() {
        backgroundColor = UIColor.white
    }
}
