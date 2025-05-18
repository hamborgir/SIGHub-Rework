//
//  SIGTabView.swift
//  SIGHub UXRework
//
//  Created by Ilham Shahputra on 14/05/25.
//

import SwiftUI
import SwiftData

struct SIGTabView: View {
    @Environment(\.modelContext) private var context
    
    @Query private var sigs: [SIGModel] = []
    
    @State private var searchText: String = ""
    
    private let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]

    private var filteredSigs: [SIGModel] {
        if searchText.isEmpty {
            return sigs
        } else {
            return sigs.filter { sig in
                sig.name.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(filteredSigs) { sig in
                    CardComp(sig: sig)
                }
            }
        }
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Search SIG"
        )
            
    }
}


#Preview {
    SIGTabView()
        .modelContainer(for:[SIGModel.self, EventModel.self])
}
