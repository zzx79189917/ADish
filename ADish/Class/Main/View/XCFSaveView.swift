//
//  XCFSaveView.swift
//  ADish
//
//  Created by 邹圳巡 on 16/1/28.
//  Copyright © 2016年 zouzhenxun. All rights reserved.
//

import UIKit

class XCFSaveView: UITableViewCell {
    
    var numOfDish : UILabel!
    var titleOfDish : UILabel!
    var describeOfDish : UILabel!
    var imageViewOfDish : UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func layoutViews(){
        
        self.numOfDish = UILabel()
        self.titleOfDish = UILabel()
        self.describeOfDish = UILabel()
        self.imageViewOfDish = UIImageView()
        
        self.numOfDish.font = UIFont.systemFontOfSize(12)
        self.titleOfDish.font = UIFont.systemFontOfSize(17)
        self.describeOfDish.font = UIFont.systemFontOfSize(14)
        
        self.titleOfDish.textColor = UIColor.redColor()
        self.describeOfDish.numberOfLines = 0
        
        self.addSubview(self.numOfDish)
        self.addSubview(self.titleOfDish)
        self.addSubview(self.describeOfDish)
        self.addSubview(self.imageViewOfDish)
        
        self.numOfDish.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp_top).offset(3)
            make.left.equalTo(self.imageViewOfDish.snp_left).offset(10)
            make.bottom.equalTo(self.imageViewOfDish.snp_top).offset(-2)
        }
        
        self.imageViewOfDish.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.numOfDish.snp_bottom).offset(-3)
            make.left.equalTo(self.snp_left).offset(3)
            make.bottom.equalTo(self.snp_bottom).offset(-3)
            make.width.equalTo(200)
        }

        self.titleOfDish.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.numOfDish.snp_top)
            make.left.equalTo(self.imageViewOfDish.snp_right).offset(15)
            make.bottom.equalTo(self.imageViewOfDish.snp_top)
        }
        
        self.describeOfDish.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.imageViewOfDish.snp_top).offset(5)
            make.right.equalTo(self.snp_right).offset(-3)
            make.bottom.equalTo(self.imageViewOfDish)
            make.left.equalTo(self.imageViewOfDish.snp_right).offset(2)
        }
    }

}
