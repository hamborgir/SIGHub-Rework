//
//  SIGHub_ReworkApp.swift
//  SIGHub-Rework
//
//  Created by Ilham Shahputra on 18/05/25.
//

import SwiftUI
import SwiftData

@main
struct SIGHub_ReworkApp: App {
    var container: ModelContainer = {
        let schema: Schema = Schema([EventModel.self, SIGModel.self])
        let config: ModelConfiguration = ModelConfiguration(isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Could not create model container: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(container)
                .onAppear {
                    
//                    do {
//                        try container.mainContext.delete(model: SIGModel.self)
//                        try container.mainContext.delete(model: EventModel.self)
//                    } catch {
//                        fatalError("failed to delete: \(error.localizedDescription)")
//                    }
                    preloadSampleData(context: container.mainContext)

                }
        }
    }
    
    func preloadSampleData(context: ModelContext) {
        let descriptor = FetchDescriptor<SIGModel>(
            predicate: #Predicate<SIGModel> {sig in
                true
            }
        )
        
        let existingItems = try? context.fetch(descriptor)
        
        if existingItems?.isEmpty ?? true {
            for sig in SIGModel.getData() {
                context.insert(sig)
            }
            
            try? context.save()
            print("SIG data is loaded.")
        }
        
    }
}
