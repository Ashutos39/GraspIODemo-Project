//
//  indiImageDetails+CoreDataClass.swift
//  Ashutos Demo
//
//  Created by Ashutos on 28/02/19.
//  Copyright © 2019 Ashutos. All rights reserved.
//

import Foundation
import CoreData
import UIKit

@objc(ImageDetails)
class ImageDetails: NSManagedObject{
    public static func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    public static func insertEntity(imageDetails: [String:AnyObject]) -> ImageDetails {
        let moc = getContext()
        let entityDescription =
            NSEntityDescription.entity(forEntityName: "ImageDetails",in: moc)

        let ImageDetailObj = NSManagedObject(entity: entityDescription!,insertInto: moc)
        let imageId = imageDetails["id"] as! String
        let imageUrl = imageDetails["imageUrl"] as! String
        let desc = imageDetails["desc"] as! String

        ImageDetailObj.setValue(imageId, forKey: "id")
        ImageDetailObj.setValue(imageUrl, forKey: "imageUrl")
        ImageDetailObj.setValue(desc, forKey: "desc")
        return ImageDetailObj as! ImageDetails
    }

    public static func fetchReq() -> ImageDetails? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ImageDetails")
        let context = getContext()
        weak var moc = context
        var entity : ImageDetails? = nil

        moc?.performAndWait ({
            do{
                let objects = try (moc?.fetch(request)) as? [ImageDetails]

                if let objects = objects{
                    if objects.count  > 0 {
                        entity = objects.last
                    }
                    print("data is entering to data base")
                }
            }catch{

            }
        })
        return entity
    }
}
