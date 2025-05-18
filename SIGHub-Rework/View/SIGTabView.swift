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
    private var sigList: [SIGModel] = []
    
    var body: some View {
        ScrollView {
            List {
                ForEach(sigList) { sig in
                    SIGCard(sig)
                }
            }
        }
        
                Button("Add SIG", systemImage: "person") {
                    context.insert(SIGModel(name: "Hungers Games", realName: "Archery Club", desc: "...", session: .both, category: .sport, image: "blank", whatsappLink: "null", pp: "null"))
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



//extension UserDefaults {
//    var hasSeededData: Bool {
//        get {bool(forKey: "hasSeededData")}
//        set {set(newValue, forKey: "hasSeededData")}
//    }
//}

#Preview {
    SIGTabView()
}
