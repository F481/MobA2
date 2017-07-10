//
//  BirthdayClaims+CoreDataProperties.swift
//  ErinnerungsAPP
//
//  Created by fred on 09/07/2017.
//  Copyright © 2017 FH-Weingarten. All rights reserved.
//

import Foundation
import CoreData


extension BirthdayClaims {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BirthdayClaims> {
        return NSFetchRequest<BirthdayClaims>(entityName: "BirthdayClaims")
    }

    @NSManaged public var bClaims: String?
    @NSManaged public var kategoryRel: Kategory?

}
