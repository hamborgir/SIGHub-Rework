//
//  ContentView.swift
//  SIGHub UXRework
//
//  Created by Ilham Shahputra on 05/05/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var context
    
    @State private var path: NavigationPath = .init()
    @State private var selection: Int = 1
    @State private var searchText: String = ""
    
    /// <#Description#>
    var body: some View {
        
            TabView(selection: $selection) {
                //FIXME: ganti icon tab SIG menjadi lebih representatif
                Tab("SIG", systemImage: "person.2", value: 1) {
                    NavigationStack(path: $path) {
                        SIGTabView()
                            .searchable(
                                text: $searchText,
                                placement: .navigationBarDrawer(displayMode: .always),
                                prompt: "Search SIG"
                            )
                            .navigationTitle("SIG")
                            .navigationBarTitleDisplayMode(.automatic)
                    }
                }
                
                Tab("Event", systemImage: "calendar", value: 2) {
                    NavigationStack(path: $path) {
                        EventTabView()
                            .navigationTitle("Event")
                    }
                }
            }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [SIGModel.self, EventModel.self])
}
