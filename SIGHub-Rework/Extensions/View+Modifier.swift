//
//  Modifiers.swift
//  SIGHub-Rework
//
//  Created by Ilham Shahputra on 18/05/25.
//

import Foundation
import SwiftUI

struct CapsuleText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .overlay {
                Capsule().stroke(Color.black, lineWidth: 1)
            }
    }
}

extension View {
    func capsulize() -> some View {
        modifier(CapsuleText())
    }
}

