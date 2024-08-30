//
//  SettingsTab.swift
//  RollDice
//
//  Created by Adam Elfsborg on 2024-08-30.
//

import SwiftUI

struct SettingsTab: View {
    @AppStorage("dices") private var dices = 6
    @AppStorage("sides") private var sides = 6
    @AppStorage("color") private var color: Color = .white
    @AppStorage("background") private var background: Color = .black
    @AppStorage("stroke") private var stroke = 1.0
    
    let maxDices = 12
    let maxSides = 100

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section("Game") {
                        Picker("Number of dices", selection: $dices) {
                            ForEach(0...maxDices, id: \.self) { index in
                                Text(String(index)).tag(index)
                            }
                        }
                        
                        Picker("Number of sides", selection: $sides) {
                            ForEach(0...maxSides, id: \.self) { index in
                                Text(String(index)).tag(index)
                            }
                        }
                        .pickerStyle(.navigationLink)
                    }
                    
                    Section("Dice") {
                        ColorPicker("Color", selection: $color, supportsOpacity: true)
                        ColorPicker("Background", selection: $background, supportsOpacity: true)
                        Slider(value: $stroke, in: 0...10, step: 0.5)
                        Text("Border size is \(stroke.formatted())")
                            .foregroundStyle(.secondary)
                    }
                }
                .frame(height: 400)
                
                DiceView(dice: 6, size: 125, fontSize: 75)
                
                Spacer()
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsTab()
}
