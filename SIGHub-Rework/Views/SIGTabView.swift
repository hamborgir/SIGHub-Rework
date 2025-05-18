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
    
    @Query private var sigList: [SIGModel] = []
    @State private var searchText: String = ""
    
    private let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        
        ScrollableCards(sigList: sigList, columns: columns)
            
    }
    
    func reloadData() {
        do {
            try context.delete(model: SIGModel.self)
        } catch {
            fatalError(error.localizedDescription)
        }
        
        for sig in SIGModel.getData() {
            context.insert(sig)
        }
    }
}

struct ScrollableCards: View {
    var sigList: [SIGModel]
    var columns: [GridItem]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(sigList) { sig in
                    CardComp(sig: sig)
                }
            }
        }
    }
}


#Preview {
    SIGTabView()
        .modelContainer(for:[SIGModel.self, EventModel.self])
}
