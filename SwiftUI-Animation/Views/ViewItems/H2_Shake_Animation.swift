//
//  H2_Shake_Animation.swift
//  SwiftUI-Animation
//
//  Created by zaehorang on 12/29/24.
//

import SwiftUI

struct H2_Shake_Animation: View {
    @State private var userName: String = ""
    @State private var numberOfShakes = 0.0
    
    @State private var isAnswered: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(isAnswered ? "Correct! 🐯🐯🐯" :"Enter developer's name. 🐯")
                .font(.headline)
            
            TextField("Hint: Horang", text: $userName)
                .textFieldStyle(.roundedBorder)
                .onChange(of: userName) {
                    if userName != "호랑" {
                        numberOfShakes = 0
                        isAnswered = false
                    }
                }
                .shake(with: numberOfShakes)
            
            Button("Check") {
                withAnimation {
                    if userName != "호랑" {
                        numberOfShakes = 10
                        isAnswered = false
                    } else {
                        isAnswered = true
                    }
                }
            }.buttonStyle(.hButtonSyle)
        }
        .padding()
    }
}



fileprivate
struct Shake: Animatable, ViewModifier {
    var shakes: CGFloat = 0 // 흔들림 횟수
    var shakeRange: CGFloat = 5   // 흔들림의 범위 (x축 오프셋 크기)
    
    var animatableData: CGFloat {
        get {
            shakes
        } set {
            shakes = newValue
        }
    }
    
    func body(content: Content) -> some View {
        content
            .offset(x: sin(shakes * .pi * 2) * shakeRange)
    }
}

fileprivate
extension View {
    func shake(with shakes: CGFloat) -> some View {
        modifier(Shake(shakes: shakes))
    }
}


#Preview {
    H2_Shake_Animation()
}
