//
//  Dice.swift
//  RollDice
//
//  Created by Adam Elfsborg on 2024-08-30.
//

import Foundation
import SwiftUI


struct Dice: Identifiable, Codable, Equatable {
    var id = UUID()
    var value: Int
}

struct Roll: Identifiable, Codable, Equatable {
    var id = UUID()
    var timestamp = Date.now
    
    var dices: [Dice]
    
    init(numberOfDices: Int, numberOfSides: Int) {
        self.dices = []
        
        for _ in 0..<numberOfDices {
            let dice = Dice(value: Int.random(in: 0...numberOfSides))
            dices.append(dice)
        }
    }
}


@Observable
class DiceVM {
    var rolls: [Roll]
    
    var numberOfDices: Int = 4
    var numberOfSides: Int = 6
    
    let savePath = URL.documentsDirectory.appending(path: "DiceRolls")
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            rolls = try JSONDecoder().decode([Roll].self, from: data)
        } catch {
            print("Error fetching rolls \(error.localizedDescription)")
            rolls = []
        }
    }
    
    
    func add(roll: Roll) {
        rolls.insert(roll, at: 0)
        save()
    }
    
    private func save() {
        do {
            let data = try JSONEncoder().encode(rolls)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Error saving rolls: \(error.localizedDescription)")
        }
    }
}

struct DiceVMKey: EnvironmentKey {
    static var defaultValue = DiceVM()
}

extension EnvironmentValues {
    var diceVM: DiceVM {
        get { self[DiceVMKey.self] }
        set { self[DiceVMKey.self] = newValue }
    }
}
