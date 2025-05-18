//
//  EventTabView.swift
//  SIGHub UXRework
//
//  Created by Ilham Shahputra on 14/05/25.
//

import SwiftUI
import SwiftData

struct EventTabView: View {
    @Query private var events: [EventModel] = []
    
    @State private var selectedDate: Date? = nil
    @State private var currentMonthDate: Date = Date()
    
    private var calendar: Calendar {
        var calendar = Calendar.current
        calendar.firstWeekday = 1 // Sunday as first day
        return calendar
    }
    
    private var filteredEvents: [EventModel] {
        if let selectedDate = selectedDate {
            // If a date is selected, show only events for that date
            return events.filter { event in
                calendar.isDate(event.date, inSameDayAs: selectedDate)
            }
        } else {
            // Otherwise, show all events in the current month
            return events.filter { event in
                let components1 = calendar.dateComponents([.year, .month], from: event.date)
                let components2 = calendar.dateComponents([.year, .month], from: currentMonthDate)
                return components1.year == components2.year && components1.month == components2.month
            }
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        return formatter.string(from: date)
    }
    
    // Helper to format just month and year
    private func formatMonth(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }
    
    var body: some View {
        VStack {
            CalendarComp(currentDate: $currentMonthDate, selectedDate: $selectedDate)
                .padding(.bottom, 10)
            //                .frame(height: 430)
            
            Divider()
            
            VStack(spacing: 10) {
                if filteredEvents.isEmpty {
                    Spacer()
                    Image(systemName: "calendar.badge.exclamationmark")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                    
                    Text(selectedDate != nil ? "No events for this date" : "No events this month")
                        .foregroundColor(.gray)
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack {
                            ForEach(events) { item in
                                Text(item.title)
                            }
                        }
                    }
                }
            }
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "plus.circle")
                }
                
            }
        }
    }
}

#Preview {
    EventTabView()
}
