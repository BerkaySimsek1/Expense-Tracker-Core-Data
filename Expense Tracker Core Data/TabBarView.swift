//
//  TabBarView.swift
//  Expense Tracker Core Data
//
//  Created by Berkay on 7.04.2024.
//

import SwiftUI

enum tabBarItems: Int, CaseIterable{
    case home = 0
    case chart
    case profile
    
    var title: String{
        switch self {
        case .home:
            return "Home"
        case .chart:
            return "Chart"
        case .profile:
            return "Profile"
        }
    }
    
    var iconName: String{
        switch self {
        case .home:
            return "house"
        case .chart:
            return "chart.bar"
        case .profile:
            return "person"
        }
    }
}

struct TabBarView: View {
    @State var selectedTab = 0
    
    var body: some View {
        ZStack(alignment: .bottom){
            TabView(selection: $selectedTab) {
                HomeView().tag(0)
                ChartView().tag(1)
                ProfileView().tag(2)
            }
            
            ZStack{
                HStack{
                    ForEach((tabBarItems.allCases), id: \.self){ item in
                        Button{
                            selectedTab = item.rawValue
                        } label: {
                            CustomTabItem(imageName: item.iconName, title: item.title, isActive: (selectedTab == item.rawValue))
                        }
                    }
                }
                .padding(.trailing, 6)
            }
            .frame(height: 60) // Tab barın yüksekliği
            .background(Color.blue.opacity(0.2))
            .cornerRadius(35)
            .padding(.horizontal, 26)
        }
        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height) // TabBarView'ın boyutu, Tab barın yüksekliği kadar
        .background(Color.blue.opacity(0.2))
    }
}


extension TabBarView{
    func CustomTabItem(imageName: String, title: String, isActive: Bool) -> some View{
        HStack(spacing: 10){
            Spacer()
            Image(systemName: imageName)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(isActive ? .black : .gray)
                .frame(width: 20, height: 20)
            if isActive{
                Text(title)
                    .font(.system(size: 14))
                    .foregroundColor(isActive ? .black : .gray)
            }
            Spacer()
        }
        .frame(width: isActive ? nil : 60, height: 60)
        .background(isActive ? .blue.opacity(0.4) : .clear)
        .cornerRadius(30)
    }
}
