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
    
    var body: some View {
        ScrollView {
            ScrollView {
                ForEach(sigList) { sig in
                    SIGCard(sig)
                }
            }
        }
        
                Button("Add SIG", systemImage: "person") {
                    context.insert(SIGModel(name: "Hungers Games", realName: "Archery Club", desc: "...", session: .both, category: .sport, image: "blank", whatsappLink: "null", pp: "null"))
                    try? context.save()
                }
                Button("Delete", role: .destructive) {
                    do {
                        try context.delete(model: SIGModel.self)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
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


#Preview {
    SIGTabView()
        .modelContainer(for:[SIGModel.self, EventModel.self])
}
