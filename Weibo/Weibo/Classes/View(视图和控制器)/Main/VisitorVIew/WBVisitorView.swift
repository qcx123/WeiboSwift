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
    
    
// MARK: - 私有控件
    // 图像视图
    private lazy var iconView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    // 小房子
    private lazy var houseView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    // 提示标签
    private lazy var tipLabel = UILabel.init(text: "sdhjafkbhdsajbvhfjdakvbhjfda", fontSize: 14, color: UIColor.darkGray)
    // 注册按钮
    private lazy var registerButton = UIButton.init(text: "注册", fontSize: 16, normalColor: UIColor.orange, hightLightedColor: UIColor.black, backgroundImageName: "common_button_white_disable")
    // 登录按钮
    private lazy var loginButton = UIButton.init(text: "登录", fontSize: 16, normalColor: UIColor.darkGray, hightLightedColor: UIColor.black, backgroundImageName: "common_button_white_disable")
}

extension WBVisitorView {
    func setupUI() {
        backgroundColor = UIColor.white
        
        // 1.添加控件
        addSubview(iconView)
        addSubview(houseView)
        addSubview(tipLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        
        // 2.取消autoresizing
        for v in subviews {
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // 3.自动布局
        // 1> 图像视图
        addConstraint(NSLayoutConstraint(item: iconView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: iconView,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerY,
                                         multiplier: 1.0,
                                         constant: -60))
        // 2> 小房子
        addConstraint(NSLayoutConstraint(item: houseView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: houseView,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute: .centerY,
                                         multiplier: 1.0,
                                         constant: 0))
    }
}
