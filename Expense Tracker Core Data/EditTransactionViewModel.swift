//
//  EditTransactionViewModel.swift
//  Expense Tracker Core Data
//
//  Created by Berkay on 8.04.2024.
//

import Foundation
import CoreData

final class EditTransactionViewModel: ObservableObject{
    @Published var transaction: Transaction
    
    private let context: NSManagedObjectContext
    
    init(provider: TransactionProvider, transaction: Transaction? = nil){
        self.context = provider.newContext
        self.transaction = Transaction(context: self.context)
    }
    
    func save() throws{
        if context.hasChanges {
            try context.save()
        }
    }
}
