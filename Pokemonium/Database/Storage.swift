//
//  Storage.swift
//  Pokemonium
//
//  Created by Ivailo Kanev on 20/12/21.
//

import Foundation
import CoreData
struct Storage {
    
    static var shared = Storage()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores { (storeDescription, error) in
            guard error == nil else {
                fatalError()
            }
        }
        return container
    }()
    
    enum SaveStatus {
        case saved, rolledBack, hasNoChanges
    }
    
    var context: NSManagedObjectContext {
        mutating get {
            return persistentContainer.viewContext
        }
    }
    
    mutating func save() -> SaveStatus {
        if context.hasChanges {
            do {
                try context.save()
                return .saved
            } catch {
                context.rollback()
                return .rolledBack
            }
        }
        return .hasNoChanges
    }
    var objectModel: NSManagedObjectModel? {
        mutating get {
            return persistentContainer.managedObjectModel
        }
    }
}
