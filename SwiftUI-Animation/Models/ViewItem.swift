//
//  ViewItem.swift
//  SwiftUI-Animation
//
//  Created by zaehorang on 12/27/24.
//

struct ViewItem: Identifiable {
    private(set) var id: Int
    private(set) var title: String
    private(set) var description: String
    private(set) var createdDate: String
    private(set) var difficulty: DifficultyLevel
    
    private(set) var viewType: ViewItemType
    private(set) var view: HAnyView
}
