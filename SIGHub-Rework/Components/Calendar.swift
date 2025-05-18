import SwiftUI
import SwiftData

struct CalendarComp: View {
    @Binding var currentDate: Date
    @Binding var selectedDate: Date?
    
//    var events: [Event] = []// Your array of Event objects
    @Query var events: [EventModel] = []
    
    // Calendar utilities
    private var calendar: Calendar {
        var calendar = Calendar.current
        calendar.firstWeekday = 1 // Sunday as first day
        return calendar
    }
    
    private var monthYear: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        return formatter.string(from: currentDate)
    }
    
    private var daysInMonth: Int {
        let range = calendar.range(of: .day, in: .month, for: currentDate)!
        return range.count
    }
    
    private var firstDayOfMonth: Date {
        let components = calendar.dateComponents([.year, .month], from: currentDate)
        return calendar.date(from: components)!
    }
    
    private var firstWeekdayOfMonth: Int {
        let components = calendar.dateComponents([.weekday], from: firstDayOfMonth)
        return components.weekday! - 1 // 0-based index
    }
    
    private var weekdaySymbols: [String] {
        return calendar.veryShortWeekdaySymbols // ["S", "M", "T", "W", "T", "F", "S"]
    }
    
    // Check if a date has an event
    private func hasEvent(for date: Date) -> Bool {
        return events.contains { event in
            calendar.isDate(event.date, inSameDayAs: date)
        }
    }
    
    // Navigate to previous or next month
    private func changeMonth(by value: Int) {
        if let newDate = calendar.date(byAdding: .month, value: value, to: currentDate) {
            currentDate = newDate
        }
    }
    
    // Get date for a specific day in the current month
    private func getDate(for day: Int) -> Date {
        return calendar.date(byAdding: .day, value: day - 1, to: firstDayOfMonth)!
    }
    
    private func changeToToday() {
        selectedDate = Date.now
        currentDate = Date.now
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Month navigation header
            HStack {
                Text(monthYear)
                    .frame(width: 100, alignment: .center)
                    .font(.title3)
                    .fontWeight(.bold)
                
                Spacer()
                Button(action: { changeMonth(by: -1) }) {
                    Image(systemName: "chevron.left")
                        .padding(10)
                        .foregroundColor(.primary)
                        .background(.darkerGray)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                Button("Today", action: changeToToday)
                    .padding(.horizontal, 20)
                    .buttonStyle(.bordered)
                
                Button(action: { changeMonth(by: 1) }) {
                    Image(systemName: "chevron.right")
                        .padding(10)
                        .foregroundColor(.primary)
                        .background(.darkerGray)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .padding(.horizontal, 30)
//            .background(Color.red)
            
            // Calendar grid
            VStack(spacing: 8) {

                
                Grid(alignment:.leading) {
                    GridRow {
                        ForEach(weekdaySymbols, id: \.self) { symbol in
                            Text(symbol)
                                .frame(width: 45, height: 34)
                                .foregroundColor(.black)
                                .font(.headline.bold())
                        }
                    }
                }
                
                // Date grid
                // FIXME: Fix the selected date background color
                LazyVGrid(columns: Array(repeating: GridItem(.fixed(45)), count: 7), spacing: 10) {
                    // Empty cells for days before the first day of month
                    ForEach(0..<firstWeekdayOfMonth, id: \.self) { _ in
                        Text("")
                            .frame(width: 45, height: 34)
                    }
                    
                    // Days of the month
                    ForEach(1...daysInMonth, id: \.self) { day in
                        let date = getDate(for: day)
                        let hasEventForDay = hasEvent(for: date)
                        
                        Button(action: {
                            if selectedDate != nil && calendar.isDate(date, inSameDayAs: selectedDate!) {
                                    selectedDate = nil // Deselect
                                } else {
                                    selectedDate = date // Select
                                }
                        }) {
                            VStack {
                                Text("\(day)")
                                    .font(.subheadline)
                                    .foregroundStyle(.black)
                                
                                // Show a dot if there's an event
                                if hasEventForDay {
                                    Circle()
                                        .fill(Color.accentColor)
                                        .frame(width: 6, height: 6)
                                        .offset(y: -5)
                                } else {
                                    Circle()
                                        .fill(Color.clear)
                                        .frame(width: 6, height: 6)
                                }
                            }
                            .frame(width: 45, height: 34)
                            .background(
                                calendar.isDateInToday(date) ? Color.accentColor.opacity(0.2) :
                                    selectedDate != nil && calendar.isDate(date, inSameDayAs: selectedDate!) ? Color.accentColor.opacity(0.3) : Color.clear
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                }
            }
            .frame(alignment: .topLeading)
//            .background(Color.red)
            .padding(.horizontal)
        }
        .padding(.top)
//        .frame(height: 400)
//        .background(Color.red)
    }
    
//    init(events: [EventModel]) {
//        self.events = events
//    }
}

// Example implementation of Event class for reference
struct Event {
    let id = UUID()
    let title: String
    let date: Date
    // Add other properties as needed
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        @State var selectedDate: Date? = nil
        @State var currentMonthDate: Date = Date()
        
        return CalendarComp(currentDate: $currentMonthDate, selectedDate: $selectedDate)
    }
}
