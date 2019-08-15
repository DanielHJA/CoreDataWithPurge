//
//  NSManagedObjectExtensions.swift
//  CoreDataCRUD
//
//  Created by Daniel Hjärtström on 2019-08-14.
//  Copyright © 2019 Sog. All rights reserved.
//

import UIKit
import CoreData

extension NSManagedObject {
    
    static var entityDescription: NSEntityDescription? {
        guard let context = Core.shared.context else { return nil }
        return NSEntityDescription.entity(forEntityName: String(describing: self), in: context)
    }
    
    static var entityName: String? {
        return String(describing: self)
    }
    
}
