//
//  H0_CustomButton_Interactions.swift
//  SwiftUI-Animation
//
//  Created by zaehorang on 12/27/24.
//

import SwiftUI

struct H0_CustomButton_Interactions: View {
    @State private var statusText: String = "No Tapped"
    
    var body: some View {
        VStack(spacing: 10) {
            Button("Default Button") {
                changeStatusText("Default Button Tapped")
            }.buttonStyle(.hButtonSyle)
            
            Button("Bigger Button") {
                changeStatusText("Bigger Button Tapped")
            }.buttonStyle(.hBiggerButtonSyle)
            
            Button("Smaller Button") {
                changeStatusText("Smaller Button Tapped")
            }.buttonStyle(.hSmallerButtonStyle)
            
            Button("Double Tapped Button") {
                changeStatusText("First Double Tapped Button Tapped")
            }.buttonStyle(.hDoubleTapButtonStyle {
                changeStatusText("Second Double Tapped Button Tapped")
            })
            
            // 버전 차이인지 애니메이션이 동작하지 않음 🥲
            // https://swiftui-lab.com/custom-styling/
//            Button("Long Pressed Button") {
//                changeStatusText("Long Pressed Button Tapped")
//            }.buttonStyle(.hLongPressedButtonStyle)
            
            Divider()
            
            Text("Result: \(statusText)")
                .font(.headline)
                .bold()
        }
    }
    
    private func changeStatusText(_ text: String) {
            statusText = text
    }
}

extension H0_CustomButton_Interactions {
    
    struct HBiggerButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .hButton()
                .opacity(configuration.isPressed ? 1 : 1.25)
                .scaleEffect(configuration.isPressed ? 1.12 : 1)
                .animation(.easeOut, value: configuration.isPressed)
        }
    }
    
    struct HSmallerButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .hButton()
                .opacity(configuration.isPressed ? 0.75 : 1)
                .scaleEffect(configuration.isPressed ? 0.88 : 1)
                .animation(.easeOut, value: configuration.isPressed)
        }
    }
    
    struct HDoubleTapButtonStyle: PrimitiveButtonStyle {
        let doubleTapTrigger: () -> Void
        @GestureState private var isPressed = false
        
        /// A drag gesture that is solely used to keep tracked of the pressed state of the button.
        private var pressedStateGesture: some Gesture {
            DragGesture(minimumDistance: 0)
                .updating($isPressed) { _, isPressed, _ in
                    guard !isPressed else { return }
                    isPressed = true
                }
        }
    
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .hButton()
                .opacity(isPressed ? 0.75 : 1)
                .scaleEffect(isPressed ? 1.2 : 1)
                .animation(.easeOut, value: isPressed)
            /// Adding the gesture simultaneously to ensure we don't break the tap gestures.
                .simultaneousGesture(pressedStateGesture)

            /// Adding both tap gestures.
                .onTapGesture(count: 1, perform: configuration.trigger)
                .onTapGesture(count: 2, perform: doubleTapTrigger)
        }
    }
    
//    struct HLongPressedButtonStyle: PrimitiveButtonStyle {
//        func makeBody(configuration: Configuration) -> some View {
//            MyButton(configuration: configuration)
//        }
//        
//        struct MyButton: View {
//            @GestureState private var pressed = false
//
//            let configuration: PrimitiveButtonStyle.Configuration
//
//            var body: some View {
//                let longPress = LongPressGesture(minimumDuration: 1.0, maximumDistance: 0.0)
//                    .updating($pressed) { value, state, _ in state = value }
//                    .onEnded { _ in
//                       self.configuration.trigger()
//                     }
//
//                return configuration.label
//                    .hButton()
//                    .opacity(pressed ? 0.75 : 1)
//                    .scaleEffect(pressed ? 1.2 : 1)
//                    .gesture(longPress)
//            }
//        }
//    }
}

extension ButtonStyle where Self == H0_CustomButton_Interactions.HBiggerButtonStyle {
    static var hBiggerButtonSyle: H0_CustomButton_Interactions.HBiggerButtonStyle { .init() }
}

extension ButtonStyle where Self == H0_CustomButton_Interactions.HSmallerButtonStyle {
    static var hSmallerButtonStyle: H0_CustomButton_Interactions.HSmallerButtonStyle { .init() }
}

/// Using Static Member Lookup in combination with a method to configure the double tap.
extension PrimitiveButtonStyle where Self == H0_CustomButton_Interactions.HDoubleTapButtonStyle {
    static func hDoubleTapButtonStyle(action: @escaping () -> Void) -> H0_CustomButton_Interactions.HDoubleTapButtonStyle {
        H0_CustomButton_Interactions.HDoubleTapButtonStyle(doubleTapTrigger: action)
    }
}

//extension PrimitiveButtonStyle where Self == H0_ButtonStyle.HLongPressedButtonStyle {
//    static var hLongPressedButtonStyle: H0_ButtonStyle.HLongPressedButtonStyle { .init() }
//}

#Preview {
    H0_CustomButton_Interactions()
}
