//
//  ContentView.swift
//  SIGHub UXRework
//
//  Created by Ilham Shahputra on 05/05/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var context
    
    var body: some View {
        TabView {
            Tab("SIG", systemImage: "person.2") {
                SIGTabView()
            }
            
            Tab("Event", systemImage: "calendar") {
                EventTabView()
            }
        }
    }
}

#Preview {
    ContentView()
}
