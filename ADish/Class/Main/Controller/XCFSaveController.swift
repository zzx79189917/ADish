//
//  XCFSaveController.swift
//  ADish
//
//  Created by 邹圳巡 on 16/1/22.
//  Copyright © 2016年 zouzhenxun. All rights reserved.
//

import UIKit
import CoreData

class XCFSaveController: XCFBaseTableViewController {
    
    var fetchResult : AnyObject?
    let reuserIdentifier = "XCFSaveController"
    override func viewDidLoad() {
        self.title = "收藏"
        self.tableView.registerClass(XCFSaveView.self, forCellReuseIdentifier: reuserIdentifier)
        getDataFromSQL()
        self.tableView.tableFooterView = UIView()
    }
    
    func getDataFromSQL(){
        let context:NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let fetchReq = NSFetchRequest(entityName: "Dish")
        do {
            self.fetchResult = try context.executeFetchRequest(fetchReq)
        } catch{
            print("查询失败")
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let context:NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let fetchReq = NSFetchRequest(entityName: "Dish")
        return context.countForFetchRequest(fetchReq, error: nil)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuserIdentifier, forIndexPath: indexPath) as! XCFSaveView

        
        cell.numOfDish.text = self.fetchResult![indexPath.row].valueForKey("numOfDish") as? String
        cell.titleOfDish.text = self.fetchResult![indexPath.row].valueForKey("titleOfDish") as? String
        cell.describeOfDish.text = self.fetchResult![indexPath.row].valueForKey("dishDescribe") as? String
        if let dishImage = cell.imageViewOfDish {
            let urlString = self.fetchResult![indexPath.row].valueForKey("urlString") as? String
            let URL = NSURL(string: urlString!)
            dishImage.kf_setImageWithURL(URL!)
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
