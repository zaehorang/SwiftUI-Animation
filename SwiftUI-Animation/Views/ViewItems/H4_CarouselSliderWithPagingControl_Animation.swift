//
//  H4_CarouselSliderWithPagingControl_Animation.swift
//  SwiftUI-Animation
//
//  Created by zaehorang on 1/2/25.
//

import SwiftUI

struct H4_CarouselSliderWithPagingControl_Animation: View {
    /// View Provider
    @State private var items: [Item] = [
        .init(color: .red, title: "Red Red", subtitle: "Subtitle Subtitle Subtitle"),
        .init(color: .blue, title: "Blue Blue", subtitle: "Subtitle Subtitle"),
        .init(color: .green, title: "Green Green", subtitle: "Subtitle Subtitle Subtitle Subtitle Subtitle"),
        .init(color: .yellow, title: "Yellow Yellow", subtitle: "Subtitle"),
    ]
    
    @State private var showPagingControl: Bool = false
    @State private var disablePagingInteraction: Bool = false
    @State private var pagingSpacing: CGFloat = 20
    @State private var titleScrollSpeed: CGFloat = 0.6
    @State private var strechContent: Bool = false
    
    var body: some View {
        VStack {
            CustomPagingSlider(
                showPagingControl: showPagingControl,
                disablePagingInteraction: disablePagingInteraction,
                titleScrollSpeed: titleScrollSpeed,
                pagingControlSpacing: pagingSpacing,
                data: $items
            ) { $item in
                /// Content View
                RoundedRectangle(cornerRadius: 15)
                    .fill(item.color)
                    .frame(
                        width: strechContent ? nil : 150,
                        height: strechContent ? 220 : 120
                    )
            } titleContent: { $item in
                /// Title View
                VStack(spacing: 5) {
                    Text(item.title)
                        .font(.largeTitle.bold())
                    
                    Text(item.subtitle)
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.center)
                        .frame(height: 45)
                }
                .padding(.bottom, 35)
            }
            /// Use Safe Area Padding to avoid Cliiping of ScrollView
            .safeAreaPadding([.horizontal, .top], 40)
            
            /// Customization View
            List {
                Toggle("Stretch Content", isOn: $strechContent)
                
                Section("Title Scroll Speed") {
                    Slider(value: $titleScrollSpeed)
                }
                
                Section("Paging Control") {
                    Toggle("Show Paging Control", isOn: $showPagingControl)
                    
                    if showPagingControl {
                        Toggle("Disable Page Interaction", isOn: $disablePagingInteraction)
                    }
                }
                
                if showPagingControl {
                    Section("Paging Spacing") {
                        Slider(value: $pagingSpacing, in: 20...40)
                    }
                }
            }
            .clipShape(.rect(cornerRadius: 15))
            .padding(15)
        }
        .animation(.easeOut, value: strechContent)
        .animation(.easeOut, value: showPagingControl)
    }
}


extension H4_CarouselSliderWithPagingControl_Animation {
    struct Item: Identifiable {
        private(set) var id: UUID = UUID()
        var color: Color
        var title: String
        var subtitle: String
    }
    
    struct CustomPagingSlider<Contnt: View, TitleContent: View, Item: RandomAccessCollection>: View where Item: MutableCollection, Item.Element: Identifiable {
        /// Customization Properties
        var showPagingControl: Bool = true
        var disablePagingInteraction: Bool = true
        var titleScrollSpeed: CGFloat = 1
        var pagingControlSpacing: CGFloat = 20
        
        var showIndicator: ScrollIndicatorVisibility = .hidden
        var spacing: CGFloat = 10  // 옆 셀과의 간격
        
        @Binding var data: Item
        
        @ViewBuilder var contnet: (Binding<Item.Element>) -> Contnt
        @ViewBuilder var titleContent: (Binding<Item.Element>) -> TitleContent
        
        @State private var activeID: UUID?
        
        var body: some View {
            VStack(spacing: pagingControlSpacing) {
                ScrollView(.horizontal) {
                    HStack(spacing: spacing) {
                        ForEach($data) { item in
                            VStack(spacing: 0) {
                                titleContent(item)
                                    .frame(maxWidth: .infinity)
                                    .visualEffect { content, geometryProxy in
                                        content
                                            .offset(x: scrollOffset(geometryProxy))
                                    }
                                
                                contnet(item)
                            }
                            .containerRelativeFrame(.horizontal)
                        }
                    }
                    /// Adding Paging
                    .scrollTargetLayout()
                }
                .scrollIndicators(showIndicator)
                .scrollTargetBehavior(.viewAligned)
                .scrollPosition(id: $activeID)
                
                if showPagingControl {
                    PagingControl(numberOfPages: data.count, activePage: activePage) { value in
                        if let index = value as? Item.Index, data.indices.contains(index) {
                            if let id = data[index].id as? UUID {
                                withAnimation(.snappy(duration: 0.35)) {
                                    activeID = id
                                }
                            }
                        }
                    }
                    .disabled(disablePagingInteraction)
                }
            }
        }
        
        var activePage: Int {
            if let index = data.firstIndex(where: { $0.id as? UUID == activeID }) as? Int {
                return index
            }
            return 0
        }
        
        nonisolated
        func scrollOffset(_ proxy: GeometryProxy) -> CGFloat {
            let minX = proxy.bounds(of: .scrollView)?.minX ?? 0
            
            return -minX * min(titleScrollSpeed, 1.0)
        }
    }
    
    /// Add Paging Control
    struct PagingControl: UIViewRepresentable {
        var numberOfPages: Int
        var activePage: Int
        var onPageChange: (Int) -> Void
        
        func makeCoordinator() -> Coordinator {
            Coordinator(onPageChange: onPageChange)
        }
        
        func makeUIView(context: Context) -> UIPageControl {
            let view = UIPageControl()
            view.currentPage = activePage
            view.numberOfPages = numberOfPages
            view.backgroundStyle = .prominent
            view.currentPageIndicatorTintColor = UIColor(Color.primary)
            view.pageIndicatorTintColor = UIColor.placeholderText
            view.addTarget(context.coordinator, action: #selector(Coordinator.onPageUpdate(control:)), for: .valueChanged)
            
            return view
        }
        
        func updateUIView(_ uiView: UIPageControl, context: Context) {
            /// Updating Outside Event Changes
            uiView.numberOfPages = numberOfPages
            uiView.currentPage = activePage
        }
        
        class Coordinator: NSObject {
            var onPageChange: (Int) -> ()
            
            init(onPageChange: @escaping (Int) -> Void) {
                self.onPageChange = onPageChange
            }
            
            @objc func onPageUpdate(control: UIPageControl) {
                onPageChange(control.currentPage)
            }
        }
    }
}

#Preview {
    H4_CarouselSliderWithPagingControl_Animation()
}
