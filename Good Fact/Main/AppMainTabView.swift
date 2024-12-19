//
//  AppNavigationView.swift
//  Good Fact
//
//  Created by androiddev on 12/16/24.
//

import SwiftUI

enum AppTab: Hashable, CaseIterable, Identifiable {
    case random
    case daily
    case saved
    
    var id: Self { self }
}

struct AppMainTabView: View {
    @State private var selectedTab: AppTab = .random
    
    var body: some View {
        TabView {
            Group {
                ForEach(AppTab.allCases) { item in
                    let tabInfo = switch item {
                    case .random: ("list.bullet", "Random")
                    case .daily: ("calendar.badge.clock", "Daily")
                    case .saved: ("heart.fill", "Saved")
                    }
                    
                    Tab(tabInfo.1, systemImage: tabInfo.0) {
                        Group {
                            switch item {
                            case .random: RandomScreenView()
                            case .daily: DailyScreenView()
                            case .saved: FavoriteScreenView()
                            }
                        }.background(AppColor.ghostWhite)
                    }
                }
            }
        }
        .onAppear {
            /*let tabAppearance = UITabBarAppearance()
            tabAppearance.backgroundColor = .white
            UITabBar.appearance().scrollEdgeAppearance = tabAppearance*/
            
            UITabBar.appearance().isTranslucent = false
        }
        .tint(AppColor.blue)
    }
}

#Preview {
    AppMainTabView()
}
