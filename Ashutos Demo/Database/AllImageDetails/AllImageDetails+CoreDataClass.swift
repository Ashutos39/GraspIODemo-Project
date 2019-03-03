//
//  AllImageDetails+CoreDataClass.swift
//  Ashutos Demo
//
//  Created by Ashutos on 28/02/19.
//  Copyright © 2019 Ashutos. All rights reserved.
//

import Foundation
import CoreData
import UIKit

@objc(AllImageDetails)
public class AllImageDetails: NSManagedObject{
    public static func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

    public static func insertToDbWithImageDatails(indiImageArray: [[String:AnyObject]]) {
        let moc = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "AllImageDetails", in: moc)
        let managedObj = NSManagedObject(entity: entity!, insertInto: moc)
        var imageArray = [ImageDetails]()
        for indiImage in indiImageArray{
            let image = ImageDetails.insertEntity(imageDetails: indiImage)
            imageArray.append(image)
        }

        managedObj.setValue(NSOrderedSet(array: imageArray), forKey: "imageList")
        do{
            try moc.save() // to save in our table
            print("saved!")
        }catch{
            print(error.localizedDescription)
        }
        print(self.fetchImageList()?.imageList?.array.count ?? "")
    }

    public static func fetchImageList() -> AllImageDetails?{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "AllImageDetails")
        let context = getContext()
        weak var moc = context
        var entity : AllImageDetails? = nil
        moc?.performAndWait ({
            do{
                let objects = try (moc?.fetch(request))! as? [AllImageDetails]
                if let objects = objects{
                    if objects.count  > 0 {
                        entity = objects.last
                    }
                }
            }catch{
            }
        })
        return entity
    }
}
