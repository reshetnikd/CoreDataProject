//
//  Movie+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Dmitry Reshetnik on 24.02.2020.
//  Copyright © 2020 Dmitry Reshetnik. All rights reserved.
//
//

import Foundation
import CoreData


extension Movie {
    public var wrappedTitle: String {
        title ?? "Unknown Title"
    }

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var director: String?
    @NSManaged public var year: Int16

}
