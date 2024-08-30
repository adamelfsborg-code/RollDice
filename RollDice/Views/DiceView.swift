//
//  DiceView.swift
//  RollDice
//
//  Created by Adam Elfsborg on 2024-08-30.
//

import SwiftUI

struct DiceView: View {
    let dice: Int
    var size: CGFloat
    var fontSize: CGFloat
    
    @AppStorage("color") private var color: Color = .white
    @AppStorage("background") private var background: Color = .black
    @AppStorage("stroke") private var stroke = 1.0

    var body: some View {
        Text(String(dice))
            .font(.system(size: fontSize))
            .fontWeight(.bold)
            .frame(width: size, height: size)
            .background(background)
            .cornerRadius(10)
            .foregroundStyle(color)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(color, lineWidth: stroke)
            )
    }
}

#Preview {
    DiceView(dice: 2, size: 125, fontSize: 75)
}
