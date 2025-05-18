//
//  CardView.swift
//  SIGHub-Rework
//
//  Created by Ilham Shahputra on 18/05/25.
//

import SwiftUI


struct CardComp: View {
    var body: some View {
        VStack(spacing: 0) {
            Color.red
            Color.blue
                .overlay(alignment: .topLeading) {
                    VStack(alignment: .leading) {
                        Text("SIG Real Name")
                        Text("SIG Name")
                        HStack {
                            Text("Category")
                                .capsulize()
                            Text("Shift")
                                .capsulize()
                        }
                    }
                }
        }
//        .frame(width: 177, height: 144)
        .aspectRatio(177/144, contentMode: .fit)
        .scaledToFit()
    }
}

#Preview {
    CardComp()
}
