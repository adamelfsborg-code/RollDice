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
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        NavigationStack {
            ZStack {
                Color.brown
                    .ignoresSafeArea()
                
                VStack {
                    DiceGridView(roll: $roll)
                   
                    Spacer()
                    
                    Button("Roll dice") {
                        flickDice()
                    }
                    .sensoryFeedback(.increase, trigger: roll)
                    .buttonStyle(.borderedProminent)
                }
                .navigationTitle("Play")
            }
        }
    }
    
    func flickDice() {
        var flickCount = 0
        withAnimation(.easeIn(duration: 0.5)) {
            roll = Roll(numberOfDices: dices, numberOfSides: sides)
        }
        roll = Roll(numberOfDices: dices, numberOfSides: sides)
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            flickCount += 1
            withAnimation(.easeInOut(duration: 0.5)) {
                roll = Roll(numberOfDices: dices, numberOfSides: sides)
            }
            if flickCount >= 3 {
                timer.invalidate()
                diceVM.add(roll: roll!)
            }
        }
        
        
    }
}

struct DiceGridView: View {
    @Binding var roll: Roll?
    
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        if let roll = roll {
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(roll.dices, id: \.id) { dice in
                    DiceView(dice: dice.value, size: 125, fontSize: 75)
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    PlayTab()
}
