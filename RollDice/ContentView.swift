//
//  ContentView.swift
//  RollDice
//
//  Created by Adam Elfsborg on 2024-08-30.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        TabView {
            HistoryTab()
                .tabItem {
                    Label("History", systemImage: "book")
                }
            
            PlayTab()
                .tabItem {
                    Label("Play", systemImage: "dice")
                }
            
            
            SettingsTab()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .accentColor(Color.black)
    }
}

#Preview {
    ContentView()
}
