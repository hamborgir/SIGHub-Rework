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
    @State private var image: String = ""
    @State private var location: String = ""
    
    // Authentication
    @State private var isShowingPasswordSheet: Bool = false
    @State private var password: String = ""
    @State private var passwordError: Bool = false
    @State private var passwordAttempts: Int = 0
    @State private var errorMessage: String = ""
    
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
                        // Only proceed if a SIG is selected
                        if let _ = selectedSIG {
                            // Show password prompt
                            passwordError = false
                            errorMessage = ""
                            isShowingPasswordSheet = true
                        }
                    }
                    .disabled(!isFormValid)
                }
            }
            .sheet(isPresented: $isShowingPasswordSheet) {
                // Custom password authentication sheet
                PasswordAuthenticationView(
                    isPresented: $isShowingPasswordSheet,
                    sig: selectedSIG,
                    password: $password,
                    passwordError: $passwordError,
                    errorMessage: $errorMessage,
                    passwordAttempts: $passwordAttempts,
                    onSuccess: {
                        addEvent()
                    }
                )
            }
        }
    }
    
    // Verify the entered password against the selected SIG's password
    private func verifyPassword() -> Bool {
        guard let sig = selectedSIG else { return false }
        return password == sig.password
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

// Custom password authentication view
struct PasswordAuthenticationView: View {
    @Binding var isPresented: Bool
    var sig: SIGModel?
    @Binding var password: String
    @Binding var passwordError: Bool
    @Binding var errorMessage: String
    @Binding var passwordAttempts: Int
    var onSuccess: () -> Void
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                Spacer()
                Text("Authentication Required")
                    .font(.headline)
                
                if let sig = sig {
                    Text("Enter password for \(sig.name)")
                        .foregroundColor(.secondary)
                }
                Spacer()
                

                Text(passwordError ? errorMessage : "")
                        .foregroundColor(.red)
                        .padding(.vertical, 5)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                
                HStack(spacing: 20) {
                    Button("Cancel") {
                        password = ""
                        isPresented = false
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Submit") {
                        checkPassword()
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding(.top)
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
        }
        .presentationDetents([.height(250)])
    }
    
    private func checkPassword() {
        guard let sig = sig else { return }
        
        if password == sig.password {
            // Correct password
            passwordError = false
            password = ""
            passwordAttempts = 0
            isPresented = false
            onSuccess()
        } else {
            // Incorrect password
            passwordError = true
            
            // Simple error message without attempt counting
            errorMessage = "Incorrect password. Please try again."
            
            // Clear the password field for another attempt
            password = ""
        }
    }
}

#Preview {
    AddEventForm()
        .modelContainer(for:[SIGModel.self, EventModel.self])
}
