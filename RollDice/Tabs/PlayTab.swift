//
//  PlayTab.swift
//  RollDice
//
//  Created by Adam Elfsborg on 2024-08-30.
//

import SwiftUI


struct PlayTab: View {
    @Environment(\.diceVM) var diceVM
    @State private var roll: Roll?
    
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    @AppStorage("dices") private var dices = 6
    @AppStorage("sides") private var sides = 6

    var body: some View {
        NavigationStack {
            VStack {
                if roll != nil {
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(roll!.dices, id: \.id) { dice in
                            DiceView(dice: dice.value, size: 125, fontSize: 75)
                        }
                    }
                    .padding(.horizontal)
                }
               
                Spacer()
                
                Button("Roll dice") {
                    withAnimation {
                        roll = Roll(numberOfDices: dices, numberOfSides: sides)
                        diceVM.add(roll: roll!)
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Play")
        }
    }
}

#Preview {
    PlayTab()
}
