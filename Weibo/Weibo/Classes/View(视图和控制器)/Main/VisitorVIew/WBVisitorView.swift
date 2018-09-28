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
    }
}
