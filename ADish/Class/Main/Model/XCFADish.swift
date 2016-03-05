//
//  XCFADish.swift
//  ADish
//
//  Created by 邹圳巡 on 16/1/17.
//  Copyright © 2016年 zouzhenxun. All rights reserved.
//

import UIKit

class XCFADish: NSObject {
    var numOfDish : String!
    var titleOfDish : String!
    var authorOfDish : String!
    var day : String!
    var month : String!
    var week : String!
    var descripetionOfDish : String!
    
    
    init(numOfDish : String ,titleOfDish : String, authorOfDish : String, day : String, month : String, week : String, descripetionOfDish : String) {
        self.numOfDish = numOfDish
        self.titleOfDish = titleOfDish
        self.authorOfDish = authorOfDish
        self.day = day
        self.month = month
        self.week = week
        self.descripetionOfDish = descripetionOfDish
    }
}
