//
//  AllImageDetails+CoreDataProperties.swift
//  Ashutos Demo
//
//  Created by Ashutos on 28/02/19.
//  Copyright © 2019 Ashutos. All rights reserved.
//

import Foundation
import CoreData

extension AllImageDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AllImageDetails> {
        return NSFetchRequest<AllImageDetails>(entityName: "AllImageDetails")
    }

    @NSManaged public var imageList: NSOrderedSet?
    
}

// MARK: Generated accessors for surveyList
extension AllImageDetails {

    @objc(insertObject:inSurveyListAtIndex:)
    @NSManaged func insertIntoSurveyList(_ value: AllImageDetails, at idx: Int)

    @objc(removeObjectFromSurveyListAtIndex:)
    @NSManaged func removeFromSurveyList(at idx: Int)

    @objc(insertSurveyList:atIndexes:)
    @NSManaged func insertIntoSurveyList(_ values: [AllImageDetails], at indexes: NSIndexSet)

    @objc(removeSurveyListAtIndexes:)
    @NSManaged func removeFromSurveyList(at indexes: NSIndexSet)

    @objc(replaceObjectInSurveyListAtIndex:withObject:)
    @NSManaged func replaceSurveyList(at idx: Int, with value: AllImageDetails)

    @objc(replaceSurveyListAtIndexes:withPackageList:)
    @NSManaged func replaceSurveyList(at indexes: NSIndexSet, with values: [AllImageDetails])

    @objc(addSurveyListObject:)
    @NSManaged func addToSurveyList(_ value: AllImageDetails)

    @objc(removeSurveyListObject:)
    @NSManaged func removeFromSurveyList(_ value: AllImageDetails)

    @objc(addSurveyList:)
    @NSManaged public func addToSurveyList(_ values: NSOrderedSet)

    @objc(removeSurveyList:)
    @NSManaged public func removeFromSurveyList(_ values: NSOrderedSet)
}
