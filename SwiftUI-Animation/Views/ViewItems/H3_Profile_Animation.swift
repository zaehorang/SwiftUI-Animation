//
//  H3_Profil_Animation.swift
//  SwiftUI-Animation
//
//  Created by zaehorang on 12/30/24.
//

import SwiftUI

struct H3_Profile_Animation: View {
    // Profile 모델
    struct Profile: Identifiable {
        let id = UUID()
        let color: Color
        let title: String
        let description: String
    }
    
    @State private var selectedProfile: Profile? = nil // 현재 선택된 프로필
    @Namespace private var animation
    
    // 샘플 프로필 데이터
    private let profiles: [Profile] = [
        Profile(color: .orange, title: "Horang", description: "Studying SwiftUI animation 🐯"),
        Profile(color: .red, title: "Red", description: "I'm red 🍎"),
        Profile(color: .blue, title: "Blue", description: "I'm blue 🌊"),
        Profile(color: .green, title: "Green", description: "I'm green 🌱"),
    ]
    
    var body: some View {
        

        
        if let selectedProfile = selectedProfile {
            // 상세 프로필 뷰
            ProfileDetailView(profile: selectedProfile, animation: animation) {
                withAnimation(.easeOut) {
                    self.selectedProfile = nil
                }
            }
        } else {
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(profiles) { profile in
                        ProfileRowView(profile: profile, animation: animation)
                            .contentShape(Rectangle())  // expand touch area
                            .onTapGesture {
                                withAnimation(.easeOut) {
                                    selectedProfile = profile
                                }
                            }
                        Divider()
                    }
                }
                .padding()
            }
        }
    }
}

fileprivate
struct ProfileRowView: View {
    let profile: H3_Profile_Animation.Profile
    let animation: Namespace.ID
    
    var body: some View {
        HStack(spacing: 10) {
            RoundedRectangle(cornerRadius: 25)
                .matchedGeometryEffect(id: "\(profile.id)-profileImage", in: animation)
                .frame(width: 60, height: 60)
                .foregroundStyle(profile.color)
            
            HStack {
                VStack(alignment: .leading) {
                    Text(profile.title)
                        .font(.title).bold()
                        .minimumScaleFactor(0.1)
                        .matchedGeometryEffect(id: "\(profile.id)-title", in: animation)
                    
                    Text(profile.description)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .minimumScaleFactor(0.1)
                        .matchedGeometryEffect(id: "\(profile.id)-description", in: animation)
                }
                Spacer()
            }
        }
        .background(.clear)
        .padding()
    }
}

fileprivate
struct ProfileDetailView: View {
    let profile: H3_Profile_Animation.Profile
    let animation: Namespace.ID
    let onClose: () -> Void
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 25)
                .matchedGeometryEffect(id: "\(profile.id)-profileImage", in: animation)
                .frame(width: 200, height: 200)
                .foregroundStyle(profile.color)
            
            Text(profile.title)
                .font(.largeTitle).bold()
                .minimumScaleFactor(0.1)
                .matchedGeometryEffect(id: "\(profile.id)-title", in: animation)
            
            Text(profile.description)
                .font(.title)
                .foregroundStyle(.secondary)
                .minimumScaleFactor(0.1)
                .matchedGeometryEffect(id: "\(profile.id)-description", in: animation)
        }
        .padding()
        .onTapGesture {
            onClose()
        }
    }
}

#Preview {
    H3_Profile_Animation()
}
