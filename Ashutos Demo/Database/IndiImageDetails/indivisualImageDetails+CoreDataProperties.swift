//
//  indivisualImageDetails+CoreDataProperties.swift
//  Ashutos Demo
//
//  Created by Ashutos on 28/02/19.
//  Copyright © 2019 Ashutos. All rights reserved.
//

import Foundation
import CoreData

extension ImageDetails {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageDetails> {
        return NSFetchRequest<ImageDetails>(entityName: "ImageDetails")
}

    @NSManaged public var id: String?
    @NSManaged public var desc: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var indiImage: AllImageDetails?
}
