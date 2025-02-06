//
//  TabBarIntent+State.swift
//  smsmee
//
//  Created by KimRin on 2/5/25.
//

import Foundation

// 어떤 탭을 선택했는지 case를 4가지로 나눌수 있지만
enum TabBarIntent: BaseIntent {
    case selectTab(TabBarState)
}


enum TabBarState: Int, BaseState {
    case myPage
    case ledger
    case graph
    case plan
    case idle // 호출될일은 없을것으로 예상
}


