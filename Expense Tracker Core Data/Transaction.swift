//
//  TransactionModel.swift
//  Expense Tracker Core Data
//
//  Created by Berkay on 8.04.2024.
//

import Foundation
import CoreData

final class Transaction: NSManagedObject, Identifiable{
    @NSManaged var amount: String
    @NSManaged var category: String
    @NSManaged var creatingDate: Date
    @NSManaged var isIncome: Bool
    @NSManaged var name: String
    @NSManaged var symbolName: String
    
    override func awakeFromInsert() {
        super.awakeFromInsert()
        setPrimitiveValue(Date.now, forKey: "creatingDate")
        setPrimitiveValue(true, forKey: "isIncome")
    }
}


extension Transaction {
    private static var transactionFetchRequest: NSFetchRequest<Transaction> {
        NSFetchRequest(entityName: "Transaction")
    }
    
    static func all() -> NSFetchRequest<Transaction> {
        let request: NSFetchRequest<Transaction> = transactionFetchRequest
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Transaction.creatingDate, ascending: true)
        ]
        return request
    }
}
