//
//  CoreDataManager.swift
//  EmailConfirmation
//
//  Created by Roberto I. Merizalde on 8/29/20.
//  Copyright © 2020 Roberto I. Merizalde. All rights reserved.
//

import CoreData
import UIKit

struct CoreDataManager {
    
    static var shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "EmailConfirmation")
        container.loadPersistentStores { (storeDescription, err) in
            if let err = err {
                fatalError("Loading of store failed: \(err)")
            }
        }
        return container
    }()
    
    mutating func fetchCartItem() -> [CartItem] {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<CartItem>(entityName: "CartItem")
        do {
            let companies = try context.fetch(fetchRequest)
            return companies
        } catch let fetchErr {
            print("Failed to fetch companies:", fetchErr)
            return []
        }
    }
    
}
    





