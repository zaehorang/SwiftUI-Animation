//
//  H1_Basic_Transition.swift
//  SwiftUI-Animation
//
//  Created by zaehorang on 12/28/24.
//

import SwiftUI

struct H1_Basic_Transition: View {
    var body: some View {
        VStack(spacing: 15) {
            TransitionView {
                Text("Slide")
                    .font(.title)
                    .bold()
                    .transition(.slide)
            }
            
            TransitionView {
                Text("Combine")
                    .font(.title)
                    .bold()
                    .transition(AnyTransition.slide.combined(with: .scale))
            }
            
            TransitionView {
                Text("Scale")
                    .font(.title)
                    .bold()
                    .transition(.scale)
            }
            TransitionView {
                Text("Opacity")
                    .font(.title)
                    .bold()
                    .transition(.opacity)
            }
            
            TransitionView {
                Text("Asymmetric")
                    .font(.title)
                    .bold()
                    .transition(.asymmetric(
                        insertion: AnyTransition.move(edge: .bottom),
                        removal: AnyTransition.move(edge: .leading))
                    )
            }
        }
    }
}

extension H1_Basic_Transition {
    
    struct TransitionView: View {
        
        @State private var showTransition: Bool = false
        
        let content: () -> any View
        
        var body: some View {
            VStack(spacing: 5) {
                if showTransition {
                    AnyView(content())
                }
                
                Button("Transition On / Off") {
                    withAnimation(.easeIn) {
                        showTransition.toggle()
                    }
                }.buttonStyle(.hButtonSyle)
            }
        }
    }
}

#Preview {
    H1_Basic_Transition()
}
