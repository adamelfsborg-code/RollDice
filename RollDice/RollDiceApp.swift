//
//  RollDiceApp.swift
//  RollDice
//
//  Created by Adam Elfsborg on 2024-08-30.
//

import SwiftUI

@main
struct RollDiceApp: App {
    @State var diceVM = DiceVM()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(diceVM)
        }
    }
}
