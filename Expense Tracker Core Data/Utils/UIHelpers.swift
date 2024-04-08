//
//  aaaa.swift
//  Expense Tracker Core Data
//
//  Created by Berkay on 24.07.2024.
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
