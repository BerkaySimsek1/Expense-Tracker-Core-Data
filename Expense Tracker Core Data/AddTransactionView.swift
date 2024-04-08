//
//  AddTransactionView.swift
//  Expense Tracker Core Data
//
//  Created by Berkay on 7.04.2024.
//

import SwiftUI

struct AddTransactionView: View {
    @State private var isIncome = true
    @State private var name = ""
    let categories = ["Yiyecek", "Eğlence", "Kıyafet", "Araç", "Ev", "Diğer"]
    @State private var selectedCategoryIndex = 0
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var vm: EditTransactionViewModel
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.cyan,.gray]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            VStack{
                Text(isIncome ? "Income" : "Outcome").font(.largeTitle).padding(.top)
                HStack{
                    Button(action: {
                        isIncome = true
                        vm.transaction.isIncome = true
                    }) {
                        Text("Income")
                            .padding()
                            .foregroundColor(.white)
                            .background(isIncome ? Color.red : Color.blue)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.blue, lineWidth: 2)
                                    .shadow(radius: 0.1)
                            )
                    }.disabled(isIncome)
                    Button(action: {
                        isIncome = false
                        vm.transaction.isIncome = false
                    }) {
                        Text("Outcome")
                            .padding()
                            .foregroundColor(.white)
                            .background(isIncome ? Color.blue : Color.red)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.blue, lineWidth: 2)
                                    .shadow(radius: 0.1)
                            )
                    }.disabled(!isIncome)
                }
                Spacer()
                VStack(alignment: .leading){
                    Text("Choose Category").padding(.leading)
                    Picker(selection: $selectedCategoryIndex,label: Text("Choose Category")) {
                        ForEach(categories.indices, id: \.self) {
                            Text(self.categories[$0])
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal)
                    
                    Text("Name").padding(.leading,18)
                    TextField("Placeholder", text: $vm.transaction.name)
                        .padding()
                        .background()
                        .cornerRadius(15)
                        .padding(.horizontal)
                    
                    Text("Amount").padding(.leading,18)
                    TextField("Placeholder", text: isIncome ? $vm.transaction.amount : $vm.transaction.amount)
                        .padding()
                        .background()
                        .cornerRadius(15)
                        .padding(.horizontal)
                }.padding(.bottom)
                Button(action: {
                    do{
                        vm.transaction.category = categories[selectedCategoryIndex]
                        vm.transaction.symbolName = "creditcard"
                        try vm.save()
                        dismiss()
                    }catch{
                        print(error)
                    }
                }){
                    Text("Add Transaction")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blue, lineWidth: 2)
                                .shadow(radius: 0.1)
                        )
                }

                Spacer()
            }
        }
    }
}

#Preview {
    AddTransactionView(vm: .init(provider: .shared))
}
