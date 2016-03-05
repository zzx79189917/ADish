//
//  XCFShadowBackView.swift
//  ADish
//
//  Created by 邹圳巡 on 16/1/21.
//  Copyright © 2016年 zouzhenxun. All rights reserved.
//

import UIKit

class XCFShadowBackView: UIButton ,UITableViewDelegate , UITableViewDataSource{
    let menuTitle = ["收藏", "分享", "下载"]
    let menuImage = ["saveBtn", "shareBtn", "downLoadBtn"]
    var tableView : XCFMoreMenuView!
    let reuserIdentifier = "menuCell"
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let height : CGFloat = XCF_Menu_Cell_Height * CGFloat(self.menuTitle.count)
        self.tableView = XCFMoreMenuView(frame: CGRectMake(screenWidth-160, 10, 150, height))
        self.tableView?.backgroundColor = UIColor.redColor()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerClass(XCFMenuViewCell.self, forCellReuseIdentifier: reuserIdentifier)
        self.tableView.scrollEnabled = false
        self.addSubview(self.tableView)
        
        if self.tableView.respondsToSelector("setSeparatorInset:"){
            self.tableView.separatorInset = UIEdgeInsetsZero
        }
        if self.tableView.respondsToSelector("setLayoutMargins:"){
            self.tableView.layoutMargins = UIEdgeInsetsZero
        }
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        let trianglePath = UIBezierPath()
        let point  = [ CGPointMake(screenWidth-30, 0), CGPointMake(screenWidth - 40, 10),CGPointMake(screenWidth-20, 10)]
        trianglePath.moveToPoint(point[0])
        trianglePath.addLineToPoint(point[0])
        trianglePath.addLineToPoint(point[1])
        trianglePath.addLineToPoint(point[2])
        UIColor.whiteColor().setFill()
        trianglePath.fill()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuTitle.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return XCF_Menu_Cell_Height
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(reuserIdentifier, forIndexPath: indexPath) as! XCFMenuViewCell
        cell.titleImage.image = UIImage(named: self.menuImage[indexPath.row])
        cell.titleText.text = self.menuTitle[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.row == 0{
            NSNotificationCenter.defaultCenter().postNotificationName(XCF_Notification_Save, object: nil)
        }else if indexPath.row == 1{
             NSNotificationCenter.defaultCenter().postNotificationName(XCF_Notification_Share, object: nil)
        }else if indexPath.row == 2{
             NSNotificationCenter.defaultCenter().postNotificationName(XCF_Notification_DownLoad, object: nil)
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if cell.respondsToSelector("setLayoutMargins:"){
            cell.layoutMargins = UIEdgeInsetsZero
        }
        if cell.respondsToSelector("setSeparatorInset:"){
            cell.separatorInset = UIEdgeInsetsZero
        }
    }
    
}
