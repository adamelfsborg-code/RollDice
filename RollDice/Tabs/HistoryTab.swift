//
//  HistoryTab.swift
//  RollDice
//
//  Created by Adam Elfsborg on 2024-08-30.
//

import SwiftUI

struct HistoryTab: View {
    @Environment(\.diceVM) var diceVM
    
    var body: some View {
        NavigationStack {
            List {
                if diceVM.rolls.isEmpty {
                    ContentUnavailableView("No history", systemImage: "swift", description: Text("Go play!"))
                }
                
                ForEach(diceVM.rolls) { roll in
                    VStack(alignment: .leading) {
                        ScrollView(.horizontal) {
                            HStack(spacing: 15) {
                                ForEach(roll.dices) { dice in
                                    DiceView(dice: dice.value, size: 50, fontSize: 10)
                                }
                            }
                            .padding(.vertical)
                        }
                        .scrollIndicators(.hidden)
                       
                        HStack {
                            Text(roll.timestamp, format: .dateTime)
                                .foregroundStyle(.secondary)
                            Spacer()
                            Text(roll.dices.map { $0.value }.reduce(0, +).formatted())
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(.black)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
            }
            .navigationTitle("History")
        }
    }

}

#Preview {
    HistoryTab()
}
