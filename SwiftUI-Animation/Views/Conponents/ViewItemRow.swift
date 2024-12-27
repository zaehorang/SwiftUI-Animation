//
//  ViewItemRow.swift
//  SwiftUI-Animation
//
//  Created by zaehorang on 12/27/24.
//

import SwiftUI

struct ViewItemRow: View {
    let viewItem: ViewItem

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Title
            Text("\(viewItem.title) (\(viewItem.id))")
                .font(.headline)
                .lineLimit(1)

            // Description
            Text(viewItem.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.bottom, 10)

            HStack {
                // Difficulty Level
                Text("난이도: \(viewItem.difficulty.description)")
                
                Spacer()
                
                // Created Date
                Text("Created: \(viewItem.createdDate)")
            }
            .foregroundColor(.secondary)
            .font(.footnote)
        }
    }
}

#Preview {
    let viewItem = ViewItem(
        id: 1,
        title: "Spring Animation",
        description: "Learn about Spring animations in SwiftUI\nLearn about Spring animations in SwiftUI",
        createdDate: "2024-12-27",
        difficulty: .hard,
        viewType: .animation,
        view: HAnyView(H1_Transition())
    )
    
    ViewItemRow(viewItem: viewItem)
}
