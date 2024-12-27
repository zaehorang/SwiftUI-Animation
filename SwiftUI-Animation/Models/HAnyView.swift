//
//  HAnyView.swift
//  SwiftUI-Animation
//
//  Created by zaehorang on 12/27/24.
//

import SwiftUI

struct HAnyView: View {
    private let internalView: AnyView
    let originalView: Any
    
    init<V: View>(_ view: V) {
        internalView = AnyView(view)
        originalView = view
    }
    
    var body: some View {
        internalView
    }
}
