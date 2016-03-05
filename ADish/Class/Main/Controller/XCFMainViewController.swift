//
//  ViewController.swift
//  ADish
//
//  Created by 邹圳巡 on 16/1/10.
//  Copyright © 2016年 ZZX. All rights reserved.
//


import UIKit
import SnapKit
import Kingfisher
import ReachabilitySwift
import CoreData
import MBProgressHUD

class XCFMainViewController: XCFBaseViewController,UICollectionViewDelegate, UICollectionViewDataSource,UIScrollViewDelegate {
    
    let reuseIdentifier = "Cell"
    var mainCollectionView : UICollectionView!
    var dataModel : XCFADish?
    var dishArray : [[String: String]] = []
    var userDefault = NSUserDefaults()
    var wholeView = XCFShadowBackView!()
    var navView = UIButton!()
    var currentPage : Int!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        getDataFromBmob()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "A Dish"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "rightButton"), style: .Plain, target: self, action: "popMenu")
        buildCollectionView()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "notificationMethod:", name: XCF_Notification_Save, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "notificationMethod:", name: XCF_Notification_Share, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "notificationMethod:", name: XCF_Notification_DownLoad, object: nil)
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func notificationMethod(notificate : NSNotification){
        if notificate.name == XCF_Notification_Save {
            let vc = XCFSaveController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if notificate.name == XCF_Notification_Share{
            print(XCF_Notification_Share)
        }else if notificate.name == XCF_Notification_DownLoad{
            print(XCF_Notification_DownLoad)
            print(self.currentPage)
            downLoadImageToPhotoAlbum()
            
        }
        self.wholeView.removeFromSuperview()
        self.navView.removeFromSuperview()
    }
    
    func downLoadImageToPhotoAlbum(){
        
        let alert : UIAlertController = UIAlertController(title: "提示", message: "是否保存该图片", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "否", style: .Cancel, handler: nil)
        let sureAction = UIAlertAction(title: "是", style: .Default) { (action : UIAlertAction!) -> Void in
            let index = NSIndexPath(forRow: self.currentPage, inSection: 0)
            let cell = self.mainCollectionView.cellForItemAtIndexPath(index) as! XCFMainCollectionViewCell
            let image : UIImage = cell.imageOfDish.image!
            UIImageWriteToSavedPhotosAlbum(image, self, "image:didFinishSavingWithError:contextInfo:", nil)
        }
        alert.addAction(cancelAction)
        alert.addAction(sureAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func image(image: UIImage, didFinishSavingWithError: NSError?, contextInfo: AnyObject) {
        if didFinishSavingWithError != nil {
            mbProgressShow("保存失败")
            return
        }
        mbProgressShow("保存成功")

    }
    
    func mbProgressShow(text : String){
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.labelText = text
        hud.dimBackground = true
        hud.hide(true, afterDelay: 1)
    }
    
    func popMenu(){
        let menuColor : UIColor = UIColor(red: 105/255, green: 105/255, blue: 105/255, alpha: 0.2)
        
        let height :CGFloat = (self.navigationController?.navigationBar.frame.size.height)!
        self.navView = UIButton(frame: CGRectMake(0,0,screenWidth,height))
        self.navView.addTarget(self, action: "closeMenu", forControlEvents: .TouchUpInside)
        self.navView.backgroundColor = menuColor
        self.navigationController?.navigationBar.addSubview(self.navView)
        
        self.wholeView = XCFShadowBackView(frame: CGRectMake(0,64,screenWidth,screenHeight))
        self.wholeView.backgroundColor = menuColor
        self.wholeView.addTarget(self, action: "closeMenu", forControlEvents: .TouchUpInside)
        self.view.addSubview(self.wholeView)
    }
    
    func closeMenu(){
        self.wholeView.removeFromSuperview()
        self.navView.removeFromSuperview()
    }
    
    func buildCollectionView(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSizeMake(screenWidth, screenHeight)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        flowLayout.minimumLineSpacing = 0.0
        
        self.mainCollectionView = UICollectionView(frame: CGRectMake(0, 0, screenWidth, screenHeight), collectionViewLayout: flowLayout)
        self.mainCollectionView.backgroundColor = UIColor.whiteColor()
        self.mainCollectionView.alwaysBounceHorizontal = true
        self.mainCollectionView.showsHorizontalScrollIndicator = false
        self.mainCollectionView.pagingEnabled = true
        self.mainCollectionView.delegate = self
        self.mainCollectionView.dataSource = self
        self.mainCollectionView.registerClass(XCFMainCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.view.addSubview(self.mainCollectionView)
    }
    
    func getDataFromBmob(){
        let reachability: Reachability
        do {
            reachability = try Reachability.reachabilityForInternetConnection()
        } catch {
            print("Unable to create Reachability")
            return
        }
        if reachability.isReachable(){
            let query:BmobQuery = BmobQuery(className:"ADish")
            
            if let interval : Int = getTimeInterval() {
                if interval > XCF_Limit_Num{
                    query.limit = XCF_Limit_Num
                }else{
                    query.limit = interval
                }
            }
            
            if let interval : Int = getTimeInterval() {
                if interval > XCF_Limit_Num{
                    query.skip = interval - 7
                }
            }
            
            query.findObjectsInBackgroundWithBlock({array,error in
                if array.count > 0{
                    for data in array{
                        let numOfDish = data.objectForKey("numOfDish") as! String
                        let titleOfDish = data.objectForKey("dishTitle") as! String
                        let dishAuthor = data.objectForKey("dishAuthor") as! String
                        let day = data.objectForKey("dayToCreate") as! String
                        let month = data.objectForKey("monthToCreate") as! String
                        let week = data.objectForKey("weekToCreate") as! String
                        let dishDescribe = data.objectForKey("dishDescribe") as! String
                        let dataDic : [String : String] = ["numOfDish" : numOfDish , "titleOfDish" : titleOfDish, "dishAuthor" : dishAuthor, "day" : day, "month" : month, "week" : week, "dishDescribe" : dishDescribe]
                        self.dishArray.append(dataDic)
                        self.currentPage = self.dishArray.count - 1
                    }
                    self.mainCollectionView.reloadData()
                    let lastCollectionCell : Int = self.dishArray.count - 1
                    let lastCollectionCellX : CGFloat = CGFloat(lastCollectionCell) * CGFloat(screenWidth)
                    self.mainCollectionView.contentOffset = CGPointMake(lastCollectionCellX, 0)
                    if self.dishArray.count > 0 {
                        let count :Int = self.dishArray.count
                        self.userDefault.setObject(self.dishArray[count-1], forKey: XCF_Main_Userdefault)
                    }
                }
            })
        }else{
            let tmpDic = self.userDefault.objectForKey(XCF_Main_Userdefault) as! [String : String]
            self.dishArray.append(tmpDic)
        }
    }
    
    func getTimeInterval() -> Int{
        let nowDate : NSDate = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let D_DAY = 86400
        let firstDay : NSDate = dateFormatter.dateFromString(XCF_FirstDate)!
        let interval: NSTimeInterval = nowDate.timeIntervalSinceDate(firstDay)
        let days = (Int(interval)) / D_DAY + 1
        return days
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dishArray.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! XCFMainCollectionViewCell
        
        toWriteData(cell.numOfDish, prefixString: "No.", indexPath: indexPath, key: "numOfDish")
        toWriteData(cell.titleOfDish, indexPath: indexPath, key: "titleOfDish")
        toWriteData(cell.authorOfDish, prefixString: "by ", indexPath: indexPath, key: "dishAuthor")
        toWriteData(cell.day, indexPath: indexPath, key: "day")
        toWriteData(cell.month, indexPath: indexPath, key: "month")
        toWriteData(cell.week, indexPath: indexPath, key: "week")
        toWriteData(cell.descripetionOfDish, indexPath: indexPath, key: "dishDescribe")
        if let dishImage = cell.imageOfDish {
            let num = self.dishArray[indexPath.row]["numOfDish"]
            let urlString = "http://7xq6p8.com1.z0.glb.clouddn.com/dish"
+ num!
        cell.urlString = urlString
            let URL = NSURL(string: urlString)
            dishImage.kf_setImageWithURL(URL!)
        }
        cell.starBtn.addTarget(self, action: "toSaveDish:", forControlEvents: .TouchUpInside)
        let string = self.dishArray[indexPath.row]["numOfDish"]
        let num  = Int(string!)
        cell.starBtn.tag = 1000 + num!
        cell.tag = 2000 + num!
        
        if fetchCondition(cell.numOfDish.text!){
            cell.starBtn.selected = true
        }else{
            cell.starBtn.selected = false
        }
        return cell
    }
    
    func fetchCondition(checkMark : String) -> Bool{
        let context:NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let fetchReq = NSFetchRequest(entityName: "Dish")
        do {
            let fetchResult = try context.executeFetchRequest(fetchReq)
                for re in fetchResult{
                    let name = re.valueForKey("numOfDish") as! String
                    if name == checkMark{
                        return true
                    }
                }
        } catch{
            print("查询失败")
        }
        return false
    }
    
    func toSaveDish (sender : UIButton){
        let cell = self.view.viewWithTag(sender.tag+1000) as! XCFMainCollectionViewCell
        if sender.selected == true{
            sender.selected = false
            deleteDishFromSQL(cell)
        }else{
            sender.selected = true
            saveDishToSQL(cell)
        }
    }
    
    func deleteDishFromSQL(cell : XCFMainCollectionViewCell){
        print(cell.numOfDish.text!)
        let context:NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let fetchReq = NSFetchRequest(entityName: "Dish")
        do {
            let fetchResult = try context.executeFetchRequest(fetchReq)
            for re in fetchResult{
                let name = re.valueForKey("numOfDish") as! String
                if name == cell.numOfDish.text{
                    context.deleteObject(re as! NSManagedObject)
                    return
                }
            }
        } catch{
            print("查询失败")
        }
        
        //保存
        do {
            try context.save()
            print("保存成功！")
        } catch {
            fatalError("不能保存：\(error)")
        }
        
    }
    
    func saveDishToSQL(cell : XCFMainCollectionViewCell){
        let context:NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

        let dish : NSManagedObject = NSEntityDescription.insertNewObjectForEntityForName("Dish",
            inManagedObjectContext: context)
        //对象赋值
        dish.setValue(cell.numOfDish.text!, forKey: "numOfDish")
        dish.setValue(cell.titleOfDish.text!, forKey: "titleOfDish")
        dish.setValue(cell.authorOfDish.text!, forKey: "dishAuthor")
        dish.setValue(cell.day.text!, forKey: "day")
        dish.setValue(cell.month.text!, forKey: "month")
        dish.setValue(cell.week.text!, forKey: "week")
        dish.setValue(cell.descripetionOfDish.text!, forKey: "dishDescribe")
        dish.setValue(cell.urlString!, forKey: "urlString")
        
        //保存
        do {
            try context.save()
            print("保存成功！")
        } catch {
            fatalError("不能保存：\(error)")
        }
    }
    
    func toWriteData(cellLabel : UILabel,indexPath : NSIndexPath ,key : String) {
        if let label : UILabel = cellLabel {
            let dishDescribe = self.dishArray[indexPath.row][key]
            label.text = dishDescribe
        }
    }
    
    func toWriteData(cellLabel : UILabel, prefixString : String, indexPath : NSIndexPath ,key : String) {
        if let label : UILabel = cellLabel {
            let dishDescribe = prefixString + self.dishArray[indexPath.row][key]!
            label.text = dishDescribe
        }
    }
    
    //Mark: 代理
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        for cell in self.mainCollectionView.visibleCells(){
            let indexPath  = self.mainCollectionView.indexPathForCell(cell)! as NSIndexPath
            self.currentPage = indexPath.row
        }
    }
}

