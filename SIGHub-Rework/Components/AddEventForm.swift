//
//  AddEventForm.swift
//  SIGHub-Rework
//
//  Created by Ilham Shahputra on 19/05/25.
//

import SwiftUI
import SwiftData

struct AddEventForm: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    // SIG Selection
    @Query private var sigList: [SIGModel]
    @State private var selectedSIG: SIGModel?
    
    // Form fields
    @State private var title: String = ""
    @State private var desc: String = ""
    @State private var date: Date = Date()
    @State private var image: String = "" // Default empty or you can set a placeholder
    @State private var location: String = ""
    
    // Form validation
    private var isFormValid: Bool {
        !title.isEmpty && selectedSIG != nil && !location.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            Form {
                // SIG Picker
                Section(header: Text("SIG")) {
                    Picker("Select SIG", selection: $selectedSIG) {
                        Text("Select a SIG").tag(nil as SIGModel?)
                        ForEach(sigList) { sig in
                            Text(sig.name).tag(sig as SIGModel?)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                // Event Details
                Section(header: Text("Event Details")) {
                    TextField("Title", text: $title)
                    
                    TextField("Location", text: $location)
                    
                    DatePicker("Date and Time", selection: $date, displayedComponents: [.date, .hourAndMinute])
                }
                
                // Description
                Section(header: Text("Description")) {
                    TextField("Description", text: $desc, axis: .vertical)
                        .lineLimit(5...10)
                }
            }
            .navigationTitle("Add New Event")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        addEvent()
                    }
                    .disabled(!isFormValid)
                }
            }
        }
    }
    
    private func addEvent() {
        guard let sig = selectedSIG else { return }
        
        let newEvent = EventModel(
            id: UUID().uuidString,
            title: title,
            desc: desc,
            date: date,
            image: image,
            location: location,
            sig: sig
        )
        
        modelContext.insert(newEvent)
        
        do {
            try modelContext.save()
        } catch {
            print("Error saving new event: \(error.localizedDescription)")
        }
        
        dismiss()
    }
}

#Preview {
    AddEventForm()
        .modelContainer(for:[SIGModel.self, EventModel.self])
}
