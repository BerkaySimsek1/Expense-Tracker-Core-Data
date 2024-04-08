import Foundation
import SwiftUI

class TotalMoney: ObservableObject {
    @Published var incomeTotal: Int {
        didSet {
            UserDefaults.standard.set(incomeTotal, forKey: "incomeTotal")
            objectWillChange.send()
        }
    }
    
    @Published var expenseTotal: Int {
        didSet {
            UserDefaults.standard.set(expenseTotal, forKey: "expenseTotal")
        }
    }
    
    var netTotal: Int {
        return incomeTotal - expenseTotal
    }

    init() {
        self.incomeTotal = UserDefaults.standard.integer(forKey: "incomeTotal")
        self.expenseTotal = UserDefaults.standard.integer(forKey: "expenseTotal")
    }
    
    func deleteIncome(_ amount: Int){
        incomeTotal -= amount
        objectWillChange.send()
    }
    
    func deleteExpense(_ amount: Int){
        expenseTotal -= amount
        objectWillChange.send()
    }
    
    func addIncome(_ amount: Int) {
        incomeTotal += amount
    }
    
    func addExpense(_ amount: Int) {
        expenseTotal += amount
    }
}

