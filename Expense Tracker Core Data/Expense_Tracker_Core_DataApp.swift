//
//  Expense_Tracker_Core_DataApp.swift
//  Expense Tracker Core Data
//
//  Created by Berkay on 5.04.2024.
//

import SwiftUI

@main
struct Expense_Tracker_Core_DataApp: App {
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if hasSeenOnboarding {
                TabBarView().environment(\.managedObjectContext, TransactionProvider.shared.viewContext)
            } else {
                OnboardingView()
            }
        }
    }
}
