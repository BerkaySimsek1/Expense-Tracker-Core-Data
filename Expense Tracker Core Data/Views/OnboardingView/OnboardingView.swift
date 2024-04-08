//
//  OnboardingView.swift
//  Expense Tracker Core Data
//
//  Created by Berkay on 19.07.2024.
//

import SwiftUI

import SwiftUI

struct OnboardingView: View {
    @State private var selection = 0
    @State private var selectedCurrency = "USD"
    @State private var name: String = ""
    let currencies = ["USD", "EUR", "TRY", "GBP", "JPY"]
        
        let currencySymbols: [String: String] = [
            "USD": "$",
            "EUR": "€",
            "TRY": "₺",
            "GBP": "£",
            "JPY": "¥"
        ]
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                basicOnboarding(imageName: "onboard1", title: "Welcome to Trackerly!", text: "Track your expenses and manage your finances effectively.", tag: 0, action: {
                    withAnimation {
                        selection = 1 // Burada selection'u 1 yapıyoruz
                    }
                })
                .tag(0)
                .padding()
                
                basicOnboarding(imageName: "onboard2", title: "Visualize Your Data", text: "See your spending and income trends over time with beautiful charts.",tag: 1, action: {
                    withAnimation {
                        selection = 2
                    }
                })
                .tag(1)
                .padding()
                
                
                lastPageOnboarding()
                .tag(2)
                .padding()
            }.background(Gradient(colors: [.mint, .cyan, .blue, .accentColor, .indigo]))
            .tabViewStyle(PageTabViewStyle())
            .animation(Animation.easeInOut, value: true)
            .transition(.slide)
        }
    }
}


#Preview {
    OnboardingView()
}
