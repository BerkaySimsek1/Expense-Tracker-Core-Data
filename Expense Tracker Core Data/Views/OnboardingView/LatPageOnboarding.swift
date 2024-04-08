//
//  LatPageOnboarding.swift
//  Expense Tracker Core Data
//
//  Created by Berkay on 24.07.2024.
//

import SwiftUI

struct lastPageOnboarding: View {
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
        VStack {
            Image("currency")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text("Before Start, Please Select Your Currency and Enter Your Name.")
                .font(.title2)
                .padding()
            
            Picker("Currency", selection: $selectedCurrency) {
                Text("USD").tag("USD")
                Text("EUR").tag("EUR")
                Text("TRY").tag("TRY")
                Text("GBP").tag("GBP")
                Text("JPY").tag("JPY")
            }
            .frame(width: 100, height: 50).accentColor(.white)
            .pickerStyle(.menu)
            .background(.mint.opacity(0.4))
            .border(.black.opacity(0.2), width: 5)
            .cornerRadius(10)
            
            .padding()
            
            TextField("Enter Your Name", text: $name)
                .padding()
                .border(.black.opacity(0.2),width: 5)
                .background(.mint.opacity(0.4) )
            
            Spacer()
            Button(action: {
                UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
                UserDefaults.standard.set(name, forKey: "name")
                UserDefaults.standard.set(currencySymbols[selectedCurrency], forKey: "currency")
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Get Started")
                    .foregroundColor(.white)
                    .padding(.vertical, 20)
                    .padding(.horizontal, 40)
                    .background(Color.indigo)
                    .border(.black.opacity(0.2), width: 5)
                    .cornerRadius(10)
            }
            Spacer()
        }
    }
}
