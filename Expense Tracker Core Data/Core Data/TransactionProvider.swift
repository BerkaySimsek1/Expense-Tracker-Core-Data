//
//  TransactionProvider.swift
//  Expense Tracker Core Data
//
//  Created by Berkay on 8.04.2024.
//

import Foundation
import CoreData

final class TransactionProvider{
    static let shared = TransactionProvider()
    
    private let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    var newContext: NSManagedObjectContext {
            let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            context.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
            return context
        }
    
    private init(){
        persistentContainer = NSPersistentContainer(name: "TransactionDataModel")
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        persistentContainer.loadPersistentStores { _, error in
            if let error {
                fatalError("Unable to load store with error: \(error)")
            }
        }
    }
}
