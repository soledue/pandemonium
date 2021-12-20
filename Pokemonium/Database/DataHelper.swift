//
//  DataHelper.swift
//  Pokemonium
//
//  Created by Ivailo Kanev on 20/12/21.
//

import Foundation
import CoreData

fileprivate var context: NSManagedObjectContext! {
    let context: NSManagedObjectContext! = Storage.shared.context
    assert(context != nil, "Fatal error: context must be set.")
    return context
}

enum ErrorCoreData: Error, LocalizedError {
    case failed

    var localizedDescription: String {
        switch self {
        case .failed:
            return "Model entity failed"
        }
    }
}

protocol DataHelper {
    associatedtype ModelType: NSManagedObject
    func save() throws
    static func first() -> FindFirst<ModelType>
    static func append() throws -> ModelType
    static func save() throws
}

class FindFirst<ModelType: NSManagedObject>: Fetch<ModelType> {
    public func execute() throws -> ModelType? {
        let request: NSFetchRequest<ModelType> = buildFetchRequest()
        request.fetchLimit = 1
        let result = try context.fetch(request)
        return result.first
    }
}

extension DataHelper where Self: NSManagedObject {
    static func first() -> FindFirst<Self> {
        return FindFirst()
    }
    
    func save() throws {
        try context.save()
    }
    
    static func save() throws {
        if #available(iOS 15.0, *) {
            try? context.performAndWait {
                try context.save()
            }
        } else {
            try context.save()
        }
    }
    
    static func append() throws -> ModelType {
        if let entity = NSEntityDescription.entity(forEntityName: ModelType.entityName, in: context) {
            let ls = ModelType(entity: entity, insertInto: context)
            return ls
        }
        throw ErrorCoreData.failed
    }
}

class Fetch<ModelType: NSManagedObject> {
    public let entityName: String
    var filterPredicate: NSPredicate?

    init(entityName: String = ModelType.entityName) {
        self.entityName = entityName
        self.filterPredicate = nil
    }

    func filtered(by predicate: NSPredicate) -> Self {
        var newPredicate = predicate
        
        if let currentPredicate = filterPredicate {
            newPredicate = NSCompoundPredicate(type: .and, subpredicates: [currentPredicate, predicate])
        }
        
        filterPredicate = newPredicate
        return self
    }

    func `where`<ValueType>(_ keyPath: KeyPath<ModelType, ValueType>, equals value: ValueType) -> Self {
        let predicate = NSPredicate(format: "%K == %@", argumentArray: [keyPath._kvcKeyPathString!, value])
        return filtered(by: predicate)
    }

    public func buildFetchRequest<ResultType>() -> NSFetchRequest<ResultType> {
        let request = NSFetchRequest<ResultType>(entityName: entityName)
        request.predicate = filterPredicate
        return request
    }
    
}

extension NSManagedObject {
    static var entityName: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
