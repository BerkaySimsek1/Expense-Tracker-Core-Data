//
//  HomeViewLogic.swift
//  Expense Tracker Core Data
//
//  Created by Berkay on 24.07.2024.
//

extension HomeView {
    func delete(_ transaction: Transaction) throws {
        let context = provider.viewContext
        
        let existingContact = try context.existingObject(with: transaction.objectID)
        context.delete(existingContact)
        Task(priority: .background) {
            try await context.perform{
                
                transaction.isIncome ? userData.deleteIncome(Int(transaction.amount)!) : userData.deleteExpense(Int(transaction.amount)!)
                try context.save()
            }
        }
        
        Task {
                    await updateUserData()
        }

    }
    
    func updateUserData() async {
            var totalMoney = TotalMoney()
            await Task.sleep(1) // Bir saniye bekleyerek verilerin güncellenmesini sağlayabilirsiniz.
            totalMoney = TotalMoney() // Verileri yeniden yükleyin
            userData = totalMoney
        }
}
