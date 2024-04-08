//
//  OnboardingUIs.swift
//  Expense Tracker Core Data
//
//  Created by Berkay on 24.07.2024.
//
import SwiftUI

struct basicOnboarding: View {
    @State var imageName: String
    @State  var title: String
    @State  var text: String
    @State var tag: Int
    var action: () -> Void
    
   var body: some View {
        VStack {
            Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            Text(title)
                    .font(.largeTitle)
                    .padding()
            Text(text)
                    .padding()
            Spacer(minLength: 170)
            
                Button(action: {
                    action()
                }) {
                    
                    Text("Next")
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
