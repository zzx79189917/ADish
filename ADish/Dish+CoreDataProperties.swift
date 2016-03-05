//
//  Dish+CoreDataProperties.swift
//  ADish
//
//  Created by 邹圳巡 on 16/1/23.
//  Copyright © 2016年 zouzhenxun. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Dish {

    @NSManaged var day: String?
    @NSManaged var dishAuthor: String?
    @NSManaged var dishDescribe: String?
    @NSManaged var month: String?
    @NSManaged var numOfDish: String?
    @NSManaged var titleOfDish: String?
    @NSManaged var urlString: String?
    @NSManaged var week: String?

}
