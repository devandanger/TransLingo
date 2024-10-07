//
//  ContentView.swift
//  TransLingo
//
//  Created by Evan Anger on 10/6/24.
//

import SwiftUI


struct ContentView: View {
    
    var body: some View {
        TabView {
            Exercise1Page()
                .tabItem {
                    Label("Exercise 1", systemImage: "1.circle.fill")
                }
            Exercise2Page()
                .tabItem {
                    Label("Exercise 2", systemImage: "2.circle.fill")
                }
        }

    }
}

#Preview {
    ContentView()
}
