//
//  ContentView.swift
//  Expense Tracker Core Data
//
//  Created by Berkay on 2.04.2024.
//

import SwiftUI

struct BottomBumpedShape: Shape {
    let offset: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: rect.height - offset))
        path.addQuadCurve(to: CGPoint(x: rect.width, y: rect.height - offset), control: CGPoint(x: rect.midX, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.closeSubpath()
        return path
    }
}

struct ContentView: View {
    var body: some View {
        ZStack {
            VStack {
                BottomBumpedShape(offset: 40)
                    .fill(Color.blue.opacity(0.7))
                    .frame(height: UIScreen.main.bounds.height * 0.33)
                Spacer()
            }.ignoresSafeArea()
            VStack{
                HStack{
                    VStack(alignment: .leading){
                        Text("Good Afternoon,").font(.title)
                        Text("Berkay Şimşek")
                    }.padding()
                        .foregroundColor(.white)
                    Spacer()
                    Button(action: {
                        print("Button tapped!")
                    }) {
                        Image(systemName: "bell")
                        .foregroundColor(.white)
                        .font(.title)
                    }.padding(.horizontal)
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 40, style: .continuous).fill(Color.blue).frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.24).overlay {
                        VStack(alignment: .leading){
                            Text("Total Balance:").bold().font(.title)
                            Text("$ 23421").bold().font(.largeTitle)
                            Spacer()
                            HStack{
                                VStack{
                                    Text("Income:").font(.title).opacity(0.7)
                                    Text("$ 3245").bold().font(.title2)
                                }
                                Spacer()
                                VStack{
                                    Text("Outcome:").font(.title).opacity(0.7)
                                    Text("$ 3245").bold().font(.title2)
                                }
                            }
                        }.padding(20).foregroundColor(.white)
                        
                    }
                }
                HStack{
                    Text("Transaction History").bold().font(.title2)
                    Spacer()
                    Button("See All") {
                        print("See all tapped")
                    }
                }.padding(.horizontal)
                Spacer()
            }
        }
    }
}


#Preview {
    ContentView()
}
