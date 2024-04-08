//
//  TimeCategory.swift
//  Expense Tracker Core Data
//
//  Created by Berkay on 24.07.2024.
//
import SwiftUI
import Charts

struct CategoryView: View {
    let category: String
    var transactions: FetchedResults<Transaction>
    
    @State private var selectedData: ChartData?
    @State private var showDetails = false
    
    var filteredTransactions: [Transaction] {
        let calendar = Calendar.current
        let now = Date()
        let startOfPeriod: Date
        
        switch category {
        case "Day":
            startOfPeriod = calendar.startOfDay(for: now)
        case "Week":
            startOfPeriod = calendar.dateInterval(of: .weekOfYear, for: now)!.start
        case "Month":
            startOfPeriod = calendar.dateInterval(of: .month, for: now)!.start
        case "Year":
            startOfPeriod = calendar.dateInterval(of: .year, for: now)!.start
        default:
            startOfPeriod = calendar.startOfDay(for: now)
        }
        
        return transactions.filter { $0.creatingDate >= startOfPeriod }
    }
    
    var netData: [ChartData] {
        switch category {
        case "Day": return groupTransactions(by: .hour)
        case "Week": return groupTransactions(by: .day)
        case "Month": return groupTransactions(by: .weekOfYear)
        case "Year": return groupTransactions(by: .month)
        default: return []
        }
    }
    
    var body: some View {
        VStack {
            Text("\(category == "Day" ? "Dai" : category)ly Net Income")
            Chart(netData) { data in
                BarMark(
                    x: .value("Date", data.formattedDate(for: category)),
                    y: .value("Net Amount", data.amount),
                    width: 20
                )
                .foregroundStyle(data.amount >= 0 ? Color.green : Color.red)
            }
            .frame(height: 200)
        }
        .sheet(isPresented: $showDetails) {
            if let selectedData = selectedData {
                VStack {
                    Text("Date: \(selectedData.formattedDate(for: category))")
                    Text("Amount: \(selectedData.amount, specifier: "%.2f")")
                }
                .padding()
            }
        }
    }
    
    func groupTransactions(by period: Calendar.Component) -> [ChartData] {
        let calendar = Calendar.current
        var groupedData: [Date: Double] = [:]
        
        for transaction in filteredTransactions {
            guard let amount = Double(transaction.amount) else { continue }
            
            let date = calendar.dateInterval(of: period, for: transaction.creatingDate)!.start
            groupedData[date, default: 0.0] += transaction.isIncome ? amount : -amount
        }
        
        return groupedData
            .sorted { $0.key < $1.key }
            .map { ChartData(date: $0.key, amount: $0.value) }
    }
}
