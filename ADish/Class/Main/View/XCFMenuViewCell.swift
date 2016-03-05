//
//  XCFMenuViewCell.swift
//  ADish
//
//  Created by 邹圳巡 on 16/1/22.
//  Copyright © 2016年 zouzhenxun. All rights reserved.
//

import UIKit

class XCFMenuViewCell: UITableViewCell {
    
    var titleImage : UIImageView!
    var titleText : UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutViews(){
        self.titleImage = UIImageView()
        self.addSubview(self.titleImage)
        self.titleText = UILabel()
        self.addSubview(self.titleText)
        
        self.titleImage.contentMode = UIViewContentMode.ScaleAspectFill
        
        self.titleImage.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp_left).offset(10)
            make.top.equalTo(self.snp_top).offset(5)
            make.bottom.equalTo(self.snp_bottom).offset(-5)
            make.height.equalTo(self.frame.height - 10)
            make.width.equalTo(self.frame.height - 10)
        }
        
        self.titleText.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.titleImage)
            make.left.equalTo(self.titleImage.snp_right).offset(20)
            make.bottom.equalTo(self.titleImage.snp_bottom)
        }
    }
}
