//
//  AnniversaryClaims+CoreDataProperties.swift
//  ErinnerungsAPP
//
//  Created by fred on 09/07/2017.
//  Copyright © 2017 FH-Weingarten. All rights reserved.
//

import Foundation
import CoreData


extension AnniversaryClaims {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AnniversaryClaims> {
        return NSFetchRequest<AnniversaryClaims>(entityName: "AnniversaryClaims")
    }

    @NSManaged public var aClaims: String?
    @NSManaged public var kategoryRel: Kategory?

}
