//
//  HButtonStyle.swift
//  SwiftUI-Animation
//
//  Created by zaehorang on 12/27/24.
//

import SwiftUI

struct HButtonModifier: ViewModifier {
    enum ButtonSize {
        case small, medium, large
    }
    
    var size: ButtonSize
    
    private var buttonWidth: CGFloat {
        switch size {
        case .small: return 100
        case .medium: return 200
        case .large: return 300
        }
    }
    
    func body(content: Content) -> some View {
        content
            .padding()
            .bold()
            .foregroundStyle(.white)
            .frame(width: buttonWidth)
            .background(.yellow)
            .clipShape(
                RoundedRectangle(cornerRadius: 15)
            )
    }
}

extension View {
    func hButton(size: HButtonModifier.ButtonSize = .medium) -> some View {
        self.modifier(HButtonModifier(size: size))
    }
}


struct HButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .hButton()
            .opacity(configuration.isPressed ? 0.1 : 1)
            .animation(.easeOut, value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == HButtonStyle {
    static var hButtonSyle: HButtonStyle { .init() }
}
