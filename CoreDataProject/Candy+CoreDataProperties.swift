//
//  Candy+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Dmitry Reshetnik on 25.02.2020.
//  Copyright © 2020 Dmitry Reshetnik. All rights reserved.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: Country?
    
    public var wrappedName: String {
        name ?? "Unknown Candy"
    }

}
