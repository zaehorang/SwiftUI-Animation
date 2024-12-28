//
//  ViewProvider.swift
//  SwiftUI-Animation
//
//  Created by zaehorang on 12/27/24.
//

final class ViewProvider {
    static let shared = ViewProvider()
    private init() {}
    
    // MARK: - View Item 추가
    let viewItems: [ViewItem] = [
        ViewItem(
            id: 1,
            title: "Basic Transition",
            description: "Applies a simple and smooth transition effect when the view appears or disappears.",
            createdDate: "2024-12-28",
            difficulty: .easy,
            viewType: .transition,
            view: HAnyView(H1_Basic_Transition())
        ),
        ViewItem(
            id: 0, // 고유 ID
            title: "Custom Button Interaction", // 뷰의 제목
            description: "A custom button style that changes opacity and scale when pressed, or double tapped.",
            createdDate: "2024-12-27",
            difficulty: .medium,
            viewType: .interaction,
            view: HAnyView(H0_CustomButton_Interactions())
        )
    ]
}
