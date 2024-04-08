//
//  HomeViewUIs.swift
//  Expense Tracker Core Data
//
//  Created by Berkay on 24.07.2024.
//
import SwiftUI

struct TransactionRowView : View {
    
    @Environment(\.managedObjectContext) private var moc
    
    @ObservedObject var transaction: Transaction
    let currency: String
    
    var body: some View{
        HStack() {
            // Show logo
            Image(systemName: transaction.symbolName)
                .padding(.horizontal,10)
            // Show name of the product
            VStack(alignment: .leading){
                Text(transaction.name)
                    .font(.headline)
                Text(transaction.category).foregroundColor(.gray)
            }
            Spacer()
            // Show price
            Text("\(currency) \(transaction.isIncome ? "+" : "-")\(transaction.amount)")
                .padding(.horizontal)
                .font(.title2)
                .bold()
                .foregroundColor(transaction.isIncome ? .green : .red)
        }
    }
}
