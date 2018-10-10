//
//  WBVisitorView.swift
//  Weibo
//
//  Created by 乔春晓 on 2018/9/21.
//  Copyright © 2018年 乔春晓. All rights reserved.
//

import UIKit

class WBVisitorView: UIView {

    // 访客视图的信息字典 [imageName / message]
    // 如果首页 imageName = “”
    var visitorInfo : [String : String]? {
        didSet {
            guard let imageName = visitorInfo?["imageName"], let message = visitorInfo?["message"] else{
                return
            }
            tipLabel.text = message
            if imageName == "" {
                return
            }
            iconView.image = UIImage(named: imageName)
            // 其他的控制器的访客视图不需要显示小房子/遮罩视图
            houseView.isHidden = true
            maskIconView.isHidden = true
        }
    }
    
    
// MARK: - 构造函数
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
    // 遮罩图像 不要使用maskView
    private lazy var maskIconView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
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
        backgroundColor = UIColor.init(hex: 0xEDEDED, alpha: 1)
        
        // 1.添加控件
        addSubview(iconView)
        addSubview(maskIconView)
        addSubview(houseView)
        addSubview(tipLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        
        // label剧中
        tipLabel.textAlignment = .center
        
        // 2.取消autoresizing
        for v in subviews {
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // 3.自动布局
        let margin : CGFloat = 20
        
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
        
        // 3> 提示标签
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: margin))
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: 236))
        
        // 4> 注册按钮
        addConstraint(NSLayoutConstraint(item: registerButton,
                                         attribute: .left,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .left,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: registerButton,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: margin))
        addConstraint(NSLayoutConstraint(item: registerButton,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: 100))
        
        // 5> 登录按钮
        addConstraint(NSLayoutConstraint(item: loginButton,
                                         attribute: .right,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .right,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: loginButton,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: margin))
        addConstraint(NSLayoutConstraint(item: loginButton,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: registerButton,
                                         attribute: .width,
                                         multiplier: 1.0,
                                         constant: 0))
        
        // 遮罩图像
        // views 定义 VFL中的控件名称和实际名称的映射关系 H：水平方向 V：垂直方向
        // metrics：定义 VFL中()指定的常数映射关系
        let viewDict = ["maskIconView":maskIconView,"registerButton":registerButton]
        let metrics = ["spacing":-20]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[maskIconView]-0-|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: viewDict))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[maskIconView]-(spacing)-[registerButton]",
                                                      options: [],
                                                      metrics: metrics,
                                                      views: viewDict))
    }
}
