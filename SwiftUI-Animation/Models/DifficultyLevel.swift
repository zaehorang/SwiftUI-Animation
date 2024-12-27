//
//  DifficultyLevel.swift
//  SwiftUI-Animation
//
//  Created by zaehorang on 12/27/24.
//

enum DifficultyLevel: Int, CaseIterable {
    case veryEasy = 1
    case easy
    case medium
    case hard
    case veryHard

    var description: String {
        String(repeating: "🐯", count: self.rawValue)
    }
    
}
