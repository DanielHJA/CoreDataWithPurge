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
        
        if self == Animal.self {
            return NSEntityDescription.entity(forEntityName: "Animal", in: context)
        }
        
        return nil
    }
    
    static var entityName: String? {
        if self == Animal.self { return "Animal" }
        return nil
    }
    
}
