//
//  Common.swift
//  ADish
//
//  Created by 邹圳巡 on 16/1/19.
//  Copyright © 2016年 zouzhenxun. All rights reserved.
//

import Foundation

var XCF_FirstDate : String = "2016-02-24"
let XCF_Limit_Num : Int = 7
let XCF_Main_Userdefault : String = "XCF.MAIN.CACHE"
let XCF_Menu_Cell_Height : CGFloat = 50

let screenWidth  = UIScreen.mainScreen().bounds.size.width
let screenHeight  = UIScreen.mainScreen().bounds.size.height

let XCF_Notification_Save : String = "XCF.Notification.Save"
let XCF_Notification_Share : String = "XCF.Notification.Share"
let XCF_Notification_DownLoad : String = "XCF.Notification.DownLoad"



func IPHONE6P() -> Bool {
    if screenHeight == 736{
        return true
    }
    return false
}

func IPHONE6() -> Bool {
    if screenHeight == 667{
        return true
    }
    return false
}

func IPHONE5() -> Bool {
    if screenHeight == 568{
        return true
    }
    return false
}

func IPHONE4() -> Bool {
    if screenHeight == 480{
        return true
    }
    return false
}