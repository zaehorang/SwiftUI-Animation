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
        ViewItem(id: 1, title: "흔들기 애니메이션1", description: "Spring 111", createdDate: "2024-12-27", difficulty: .hard, viewType: .animation, view: HAnyView(H1_Transition())),
        ViewItem(id: 2, title: "흔들기 애니메이션2", description: "Spring 222", createdDate: "2024-12-27", difficulty: .hard, viewType: .animation, view: HAnyView(H2_Transition())),
        ViewItem(id: 3, title: "흔들기 애니메이션3", description: "Spring 222", createdDate: "2024-12-27", difficulty: .hard, viewType: .animation, view: HAnyView(H3_Transition())),
    ]
}
