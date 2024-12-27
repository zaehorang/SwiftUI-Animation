//
//  NavigationContainer.swift
//  SwiftUI-Animation
//
//  Created by zaehorang on 12/27/24.
//

import SwiftUI

struct NavigationContainer: View {
    @State var path: [ViewItem] = []
    
    var body: some View {
        NavigationStack {
            List(ViewProvider.shared.viewItems.reversed()) { item in
                NavigationLink {
                    item.view
                } label: {
                    ViewItemRow(viewItem: item)
                }
            }
            .navigationTitle("Animations 🐯")
        }
    }
}

#Preview {
    NavigationContainer()
}
