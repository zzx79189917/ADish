//
//  XCFMainCollectionViewCell.swift
//  ADish
//
//  Created by 邹圳巡 on 16/1/16.
//  Copyright © 2016年 ZZX. All rights reserved.
//

import UIKit
import SnapKit

class XCFMainCollectionViewCell: UICollectionViewCell {
    
    var screenWidth = UIScreen.mainScreen().bounds.size.width
    
    var numOfDish : UILabel!
    var titleOfDish : UILabel!
    var authorOfDish : UILabel!
    var imageOfDish : UIImageView!
    var day  : UILabel!
    var month : UILabel!
    var week : UILabel!
    var divideLine : UIView!
    var descripetionOfDish : UILabel!
    var bgImageView : UIImageView!
    var starBtn : UIButton!
    var urlString : String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func adjustFont(numOfDishFont: CGFloat, titleOfDishFont: CGFloat, authorOfDishFont: CGFloat, dayFont: CGFloat, monthFont: CGFloat, weekFont: CGFloat, descripetionOfDishFont: CGFloat){
        self.numOfDish.font = UIFont.systemFontOfSize(numOfDishFont)
        self.titleOfDish.font = UIFont.systemFontOfSize(titleOfDishFont)
        self.authorOfDish.font = UIFont.systemFontOfSize(authorOfDishFont)
        self.day.font = UIFont.systemFontOfSize(dayFont)
        self.month.font = UIFont.systemFontOfSize(monthFont)
        self.week.font = UIFont.systemFontOfSize(weekFont)
        self.descripetionOfDish.font = UIFont.systemFontOfSize(descripetionOfDishFont)
    }
    
    func layoutViews(){
        self.numOfDish = UILabel()
        self.titleOfDish = UILabel()
        self.authorOfDish = UILabel()
        self.imageOfDish = UIImageView()
        self.day = UILabel()
        self.month = UILabel()
        self.week = UILabel()
        self.divideLine = UIView()
        self.descripetionOfDish = UILabel()
        self.bgImageView = UIImageView()
        self.starBtn = UIButton(type: .Custom)
        
        if IPHONE4(){
            adjustFont(10, titleOfDishFont: 20, authorOfDishFont: 10, dayFont: 50, monthFont: 18, weekFont: 24, descripetionOfDishFont: 13)
        }else if IPHONE5(){
            adjustFont(10, titleOfDishFont: 20, authorOfDishFont: 10, dayFont: 60, monthFont: 25, weekFont: 30, descripetionOfDishFont: 15)
        }else if IPHONE6(){
            adjustFont(13, titleOfDishFont: 23, authorOfDishFont: 13, dayFont: 70, monthFont: 32, weekFont: 36, descripetionOfDishFont: 17)
        }else if IPHONE6P(){
            adjustFont(15, titleOfDishFont: 25, authorOfDishFont: 15, dayFont: 80, monthFont: 35, weekFont: 40, descripetionOfDishFont: 18)
        }
        
        
        self.imageOfDish.layer.shadowOpacity = 0.8
        self.imageOfDish.layer.shadowColor = UIColor.blackColor().CGColor
        self.imageOfDish.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        self.titleOfDish.textColor = UIColor.redColor()
        self.day.textColor = UIColor(red: 230/225, green: 86/225, blue: 17/225, alpha: 1)
        self.month.textColor = UIColor(red: 230/225, green: 86/225, blue: 17/225, alpha: 1)
        self.week.textColor = UIColor(red: 127/225, green: 198/225, blue: 204/225, alpha: 1)
        
        self.descripetionOfDish.numberOfLines = 0
        self.divideLine.backgroundColor = UIColor.grayColor()
        self.bgImageView.image = UIImage(named: "imageBg")
        self.starBtn.setBackgroundImage(UIImage(named: "star_normal"), forState: .Normal)
        self.starBtn.setBackgroundImage(UIImage(named: "star_select"), forState: .Selected)
        self.starBtn.selected = false
        
        self.addSubview(self.bgImageView)
        self.addSubview(self.numOfDish)
        self.addSubview(self.titleOfDish)
        self.addSubview(self.authorOfDish)
        self.addSubview(self.imageOfDish)
        self.addSubview(self.day)
        self.addSubview(self.month)
        self.addSubview(self.week)
        self.addSubview(self.divideLine)
        self.addSubview(self.descripetionOfDish)
        self.addSubview(self.starBtn)
        
        self.bgImageView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp_top)
            make.bottom.equalTo(self.snp_bottom)
            make.left.equalTo(self.snp_left)
            make.right.equalTo(self.snp_right)
        }
        
        self.numOfDish.snp_makeConstraints{ (make) -> Void in
            make.top.equalTo(self.snp_top).offset(32 + 5)
            make.left.equalTo(self.snp_left).offset(10)
            make.bottom.equalTo(self.titleOfDish.snp_top).offset(-5)
        }
        
        self.titleOfDish.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self)
            make.top.equalTo(self.numOfDish.snp_bottom).offset(5)
            make.bottom.equalTo(self.authorOfDish.snp_top)
        }
        
        self.authorOfDish.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.titleOfDish.snp_right).offset(10)
            make.bottom.equalTo(self.imageOfDish.snp_top).offset(-5)
        }
        
        self.starBtn.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.authorOfDish.snp_top)
            make.right.equalTo(self.snp_right).offset(-20)
        }
        
        self.imageOfDish.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            if IPHONE4(){
                make.height.equalTo(150)
            }else{
                make.height.equalTo((screenWidth-20)*387/581)
            }
        }
        
        self.day.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.imageOfDish.snp_bottom).offset(10)
            make.left.equalTo(self.imageOfDish.snp_left)
            make.right.equalTo(self.month.snp_left).offset(-5)
            make.bottom.equalTo(self.divideLine.snp_top).offset(-5)
        }
        
        self.month.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.day).offset(-20)
        }
        
        self.week.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.divideLine.snp_top).offset(-25)
            make.right.equalTo(self.imageOfDish.snp_right).offset(-30)
        }
        
        self.divideLine.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.imageOfDish.snp_left)
            make.right.equalTo(self.imageOfDish.snp_right)
            make.height.equalTo(0.5)
        }
        
        self.descripetionOfDish.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.divideLine.snp_bottom).offset(10)
            make.left.equalTo(self.divideLine.snp_left).offset(1)
            make.right.equalTo(self.divideLine.snp_right).offset(-1)
        }
    }
    

    

}
