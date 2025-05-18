//
//  CardView.swift
//  SIGHub-Rework
//
//  Created by Ilham Shahputra on 18/05/25.
//

import SwiftUI


struct CardComp: View {
    var image: String = "Blank"
    var realName: String = "SIG Real Name"
    var name: String = "SIG Name"
    var category: String = "Category"
    var shift: String = "Shift"
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image("Blank")
                .resizable()
            Color(.lightGray)
                .aspectRatio(177/72, contentMode: .fit)
                .overlay(alignment: .topLeading) {
                    VStack(alignment: .leading) {
                        Text(realName)
                            .font(.system(size:8).bold())
                            .foregroundStyle(Color(.primary))
                            .lineLimit(1)
                        Text(name)
                            .font(.system(size: 14).bold())
                            .lineLimit(1)
                        HStack {
                            Text(category)
                                .font(.system(size: 8).bold())
                                .capsulize()
                            Text(shift)
                                .font(.system(size: 8).bold())
                                .capsulize()
                        }
                    }
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                }
        }
        .frame(width: 177, height: 144)
//        .aspectRatio(177/144, contentMode: .fit)
//        .scaledToFit()
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    init(sig: SIGModel) {
        self.image = sig.image
        self.realName = sig.realName
        self.name = sig.name
        self.category = sig.category.rawValue
        self.shift = sig.session.formattedAsString()
    }
    
    init() {}
    
}

#Preview {
    CardComp()
}
