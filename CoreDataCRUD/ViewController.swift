//
//  ViewController.swift
//  CoreDataCRUD
//
//  Created by Daniel Hjärtström on 2019-08-14.
//  Copyright © 2019 Sog. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Core.shared.makeObject(for: Animal.self) { (animal) in
            animal.isPredator = true
            animal.type = "Lion"
            animal.weight = 80.0
            Core.shared.add(animal)
            Core.shared.read(Animal.self, completion: { (results) in
                self.changeObjects(results)
            })
        }
        
    }
    
    func changeObjects(_ objects: [Animal]) {
        guard let first = objects.first else { return }
        first.weight = 100
        first.type = "Tiger"
        Core.shared.saveChanges()
        Core.shared.read(Animal.self, completion: { (results) in
            print(results)
        })
    }


}

