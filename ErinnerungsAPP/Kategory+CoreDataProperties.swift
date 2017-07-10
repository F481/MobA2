//
//  Kategory+CoreDataProperties.swift
//  ErinnerungsAPP
//
//  Created by fred on 09/07/2017.
//  Copyright © 2017 FH-Weingarten. All rights reserved.
//

import Foundation
import CoreData


extension Kategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Kategory> {
        return NSFetchRequest<Kategory>(entityName: "Kategory")
    }

    @NSManaged public var kategories: String?
    @NSManaged public var anniversary: String?
    @NSManaged public var birthday: String?
    @NSManaged public var birthdayRel: NSSet?
    @NSManaged public var anniversaryRel: NSSet?

}

// MARK: Generated accessors for birthdayRel
extension Kategory {

    @objc(addBirthdayRelObject:)
    @NSManaged public func addToBirthdayRel(_ value: BirthdayClaims)

    @objc(removeBirthdayRelObject:)
    @NSManaged public func removeFromBirthdayRel(_ value: BirthdayClaims)

    @objc(addBirthdayRel:)
    @NSManaged public func addToBirthdayRel(_ values: NSSet)

    @objc(removeBirthdayRel:)
    @NSManaged public func removeFromBirthdayRel(_ values: NSSet)

}

// MARK: Generated accessors for anniversaryRel
extension Kategory {

    @objc(addAnniversaryRelObject:)
    @NSManaged public func addToAnniversaryRel(_ value: AnniversaryClaims)

    @objc(removeAnniversaryRelObject:)
    @NSManaged public func removeFromAnniversaryRel(_ value: AnniversaryClaims)

    @objc(addAnniversaryRel:)
    @NSManaged public func addToAnniversaryRel(_ values: NSSet)

    @objc(removeAnniversaryRel:)
    @NSManaged public func removeFromAnniversaryRel(_ values: NSSet)

}
