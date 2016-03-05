//
//  XCFMoreMenuView.swift
//  ADish
//
//  Created by 邹圳巡 on 16/1/21.
//  Copyright © 2016年 zouzhenxun. All rights reserved.
//

import UIKit

class XCFMoreMenuView: UITableView {
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.layer.cornerRadius = 10
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
