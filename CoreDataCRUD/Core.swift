//
//  Core.swift
//  CoreDataCRUD
//
//  Created by Daniel Hjärtström on 2019-08-14.
//  Copyright © 2019 Sog. All rights reserved.
//

import UIKit
import CoreData

class Core {
    static var shared = Core()
    private init() {}
    
    private(set) var appDelegate: AppDelegate? = {
        return UIApplication.shared.delegate as? AppDelegate
    }()

    private lazy var persistentContainer: NSPersistentContainer? = {
        return appDelegate?.persistentContainer
    }()
    
    private(set) lazy var context: NSManagedObjectContext? = {
        guard let appdDelegate = appDelegate else { return nil }
        return appdDelegate.persistentContainer.viewContext
    }()
    
    func makeObject<T: NSManagedObject>(for type: T.Type, completion: @escaping (T) -> Void) {
        guard let context = context else { return }
        guard let entityDescription = type.entityDescription else { return }
        let object = T(entity: entityDescription, insertInto: context)
        completion(object)
    }
    
    func add<T: NSManagedObject>(_ object: T) {
        guard let context = context else { return }
        context.insert(object)
        saveChanges()
    }
    
    func read<T: NSManagedObject>(_ entity: T.Type, completion: @escaping ([T]) -> Void) {
        guard let context = context else { return }
        guard let entityName = entity.entityName else { return }
        let request = NSFetchRequest<T>(entityName: entityName)
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            completion(result)
        } catch let error {
            print(error)
        }
    }
    
    func remove(_ object: NSManagedObject) {
        context?.delete(object)
        saveChanges()
    }
    
    func saveChanges() {
        do {
            try context?.save()
        } catch let error {
            print(error)
        }
    }
    
    func purgeAllData(_ purge: Bool, key: String) {
        if purge && key == "PURGE_ALL" {
            guard let uniqueNames = persistentContainer?.managedObjectModel.entities.compactMap({ $0.name }) else { return }
            uniqueNames.forEach { (name) in
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: name)
                let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                do {
                    try persistentContainer?.viewContext.execute(batchDeleteRequest)
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}
