//
//  ChartData.swift
//  Expense Tracker Core Data
//
//  Created by Berkay on 24.07.2024.
//

import SwiftUI

struct ChartData: Identifiable {
    let id = UUID()
    let date: Date
    let amount: Double
    
    func formattedDate(for category: String) -> String {
        let formatter = DateFormatter()
        
        switch category {
        case "Day":
            formatter.dateFormat = "HH:mm"
        case "Week":
            formatter.dateFormat = "EEEE"
        case "Month":
            formatter.dateFormat = "dd MMM"
        case "Year":
            formatter.dateFormat = "MMM yyyy"
        default:
            formatter.dateFormat = "dd MMM yyyy"
        }
        
        return formatter.string(from: date)
    }
}
