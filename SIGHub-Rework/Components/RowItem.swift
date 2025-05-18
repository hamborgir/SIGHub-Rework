//
//  RowItem.swift
//  SIGHub-Rework
//
//  Created by Ilham Shahputra on 19/05/25.
//

import SwiftUI

struct RowItem: View {
    
    var date: Date = Date()
    var title: String = ""
    var sigName: String = ""
    var location: String = ""
    
    
    func dateMonthFormat(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd"
        
        return dateFormatter.string(from: date)
    }
    
    func dayFormat(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddd"
        
        return dateFormatter.string(from: date)
    }
    
    func timeFormat(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: date)
    }
    
    var body: some View {
        HStack {
            ZStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.blue)
                
                VStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.white)
                        .frame(width: 80, height: 30)
                        .padding(.top, 10)
                        .overlay {
                            Spacer()
                            Text(dateMonthFormat(date))
                                .font(.headline.bold())
                                .padding(.top, 5)
                            Spacer()
                        }
                    Spacer()
                    Text(date,
                         format: .dateTime.weekday(.abbreviated))
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
//                    .padding(.bottom)
                    Spacer()
                }
                    
            }
            .frame(width: 100)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title3.bold())
                Text(sigName)
                    .font(.headline)
                    .foregroundStyle(.gray)
                HStack {
                    Label(timeFormat(date), systemImage: "clock")
                        .font(.subheadline)
                        .capsulize()
                    Label(location, systemImage: "mappin.circle")
                        .font(.subheadline)
                        .capsulize()
                        
                }
            }
            .padding(.leading, 10)
            Spacer()
        }
        .frame(width: 360,height: 100)
//        .background(Color.red)
    }
    
    init(event: EventModel) {
        self.date = event.date
        self.title = event.title
        self.sigName = event.sig.name
        self.location = event.location
    }
    
    init() {}
}

#Preview {
    RowItem()
}
