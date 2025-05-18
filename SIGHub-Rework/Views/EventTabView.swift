//
//  EventTabView.swift
//  SIGHub UXRework
//
//  Created by Ilham Shahputra on 14/05/25.
//

import SwiftUI

struct EventTabView: View {
    var body: some View {
        Color.red
            .frame(height: 350)
            .overlay(Text("calendar"))
        Spacer()
        ScrollView {
            Color.blue
        }
    }
}

#Preview {
    EventTabView()
}
