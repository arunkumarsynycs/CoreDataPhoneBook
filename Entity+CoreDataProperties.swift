//
//  Entity+CoreDataProperties.swift
//  CoreDataPhoneBook
//
//  Created by Chintalapudi Vinod on 6/29/18.
//  Copyright © 2018 brn. All rights reserved.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var images: NSData?
    @NSManaged public var texts: String?
    @NSManaged public var descriptions: String?

}
