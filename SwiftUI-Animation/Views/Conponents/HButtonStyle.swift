//
//  HButtonStyle.swift
//  SwiftUI-Animation
//
//  Created by zaehorang on 12/27/24.
//

import SwiftUI

struct HButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .bold()
            .foregroundStyle(.yellow)
            .background(
                RoundedRectangle(
                    cornerRadius: 15,
                    style: .continuous
                )
                .stroke(.yellow, lineWidth: 2)
            )
    }
}

extension View {
    func hButton() -> some View {
        self.modifier(HButtonModifier())
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
