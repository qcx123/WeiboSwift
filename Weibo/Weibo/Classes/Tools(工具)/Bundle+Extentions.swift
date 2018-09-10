//
//  Bundle+Extentions.swift
//  Weibo
//
//  Created by 乔春晓 on 2018/9/4.
//  Copyright © 2018年 乔春晓. All rights reserved.
//

import Foundation

extension Bundle {
    var nameSpace : String {
        return infoDictionary?["CFBundleName"] as? String ?? ""
    }
    
}
