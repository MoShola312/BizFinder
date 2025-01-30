//
//  ContentView.swift
//  BizFinder
//
//  Created by mohammed sholaja on 1/30/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            LocalBusinessView()
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem {
                    Label("Near Me", systemImage: "location.app")
                }
            WeeklyEventsView()
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem {
                    Label("Weekly Events", systemImage: "calendar.circle")
                }
            Text("Directory")
                .toolbarVisibility(.visible, for: .tabBar)
                .tabItem {
                    Label("Web Directory", systemImage: "globe")
                }
            
        }
    }
}
#Preview {
    ContentView()
}
