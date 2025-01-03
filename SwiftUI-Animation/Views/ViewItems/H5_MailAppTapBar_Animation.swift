//
//  H5_MailAppTapBar_Animation.swift
//  SwiftUI-Animation
//
//  Created by zaehorang on 1/3/25.
//

import SwiftUI

struct H5_MailAppTapBar_Animation: View {
    @State private var searchText: String = ""
    @State private var isSearchActive: Bool = false
    @State private var activeTab: TabModel = .primary
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    CustomTabBar(activeTab: $activeTab)
                }
            }
            .navigationTitle("All Inboxes")
            .searchable(text: $searchText, isPresented: $isSearchActive, placement: .navigationBarDrawer(displayMode: .automatic))
            .background(.gray.opacity(0.1))
        }
    }
}

extension H5_MailAppTapBar_Animation {
    struct CustomTabBar: View {
        @Binding var activeTab: TabModel
        @Environment(\.colorScheme) private var scheme
        
        var body: some View {
            GeometryReader { _ in
                HStack(spacing: 8) {
                    HStack(spacing: activeTab == .allMails ? -15 : 8) {
                        ForEach(TabModel.allCases.filter { $0 != .allMails }, id: \.rawValue) { tab in
                            resizableTabButton(tab)
                        }
                    }
                    
                    if activeTab == .allMails {
                        resizableTabButton(.allMails)
                            .transition(.offset(x: 300))
                    }
                }
                .padding(.horizontal)
            }
            .frame(height: 50)
        }
        
        @ViewBuilder
        func resizableTabButton(_ tab: TabModel) -> some View {
            HStack {
                Image(systemName: tab.symbolImage)
                
                if activeTab == tab {
                    Text("\(tab.rawValue)")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                }
            }
            .foregroundStyle(tab == .allMails ? schemeColor : activeTab == tab ? .white : .gray)
            .frame(maxHeight: .infinity)
            .frame(maxWidth: activeTab == tab ? .infinity : nil)
            .padding(.horizontal, activeTab == tab ? 10 : 15)
            .background {
                Rectangle()
                    .fill(activeTab == tab ? tab.color : .graySakiya)
            }
            .clipShape(.rect(cornerRadius: 20, style: .continuous))
            .background {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(.background)
                    .padding(activeTab == .allMails && tab != .allMails ? -3 : 3)
            }
            .contentShape(.rect)
            .onTapGesture {
                withAnimation(.bouncy) {
                    guard tab != .allMails else { return }
                    
                    if activeTab == tab {
                        activeTab = .allMails
                    } else {
                        activeTab = tab
                    }
                }
            }
        }
        
        var schemeColor: Color {
            scheme == .dark ? .black : .white
        }
    }
}

extension H5_MailAppTapBar_Animation {
    enum TabModel: String, CaseIterable {
        case primary = "Primary"
        case transactions = "Transactions"
        case update = "Updates"
        case promotions = "Promotions"
        case allMails = "All Mails"
        
        var color: Color {
            switch self {
            case .primary: .blue
            case .transactions: .green
            case .update: .indigo
            case .promotions: .pink
            case .allMails: .primary
            }
        }
        
        var symbolImage: String {
            switch self {
            case .primary: "person"
            case .transactions: "cart"
            case .update: "text.bubble"
            case .promotions: "megaphone"
            case .allMails: "tray"
            }
        }
    }
}

#Preview {
    H5_MailAppTapBar_Animation()
}
