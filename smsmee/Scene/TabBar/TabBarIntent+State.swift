//
//  TabBarIntent+State.swift
//  smsmee
//
//  Created by KimRin on 2/5/25.
//

import Foundation

enum TabBarIntent {
    case selectTab(TabBarState.Tab)
}

struct TabBarState {
    enum Tab: Int, CaseIterable {
        case home, search, notifications, profile

        var iconName: String {
            switch self {
            case .home: return "house.fill"
            case .search: return "magnifyingglass"
            case .notifications: return "bell"
            case .profile: return "person"
            }
        }
    }

    let selectedTab: Tab
}
