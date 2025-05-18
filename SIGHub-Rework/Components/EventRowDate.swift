//
//  EventListItem.swift
//  SIGHub UXRework
//
//  Created by Ilham Shahputra on 15/05/25.
//

import SwiftUI

struct EventRowItem: View {
    let title: String = "Event Title"
    let sigName: String = "SIG Name"
//    let event: EventModel
    
    var body: some View {
        HStack(alignment: .center) {
//            EventRowDate()
            Group {
                RoundedRectangle(cornerRadius: 30)
                    .fill(.blue)
            }
            .frame(width:100, height: 100)
            .padding(.trailing, 20)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title2.bold())
                Text(sigName)
                    .font(.headline)
                    .foregroundStyle(.gray)
                HStack {
                    Label("18.00--21.00", systemImage: "clock")
                        .font(.caption)
                        .lineLimit(1)
                    Label("Apple Academy", systemImage: "mappin")
                        .font(.caption)
                        .lineLimit(1)
                }
                .padding(.top, 10)
            }
            .frame(width: 200, height: 100, alignment: .leading)
        }
    }
}

struct EventRowDate: View {
    let date: Date
    
    init(date: Date = Date()) {
        self.date = date
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 100)
                .fill(.blue)
            
            VStack {
                RoundedRectangle(cornerRadius: 300)
                    .fill(.white)
                    .aspectRatio(5/2, contentMode: .fit)
                    .padding([.horizontal], 50)
                    .padding(.top, 40)
                    .overlay {
                        VStack {
                            Text("13 May")
                                .font(.system(size: 50, weight: .bold))
                        }
                    }
                Spacer()
            }
            
            VStack {
                Spacer()
                Text("Thu")
                    .font(.system(size: 120, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.bottom, 60)
            }
            
        }
//        .aspectRatio(1, contentMode: .fit)
        .frame(width: 64, height: 58)
    }
}

#Preview {
    EventRowItem()
}
