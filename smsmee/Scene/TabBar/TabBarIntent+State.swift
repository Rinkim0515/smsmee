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
    
    case ledger
    case budget
    case plan
    case myPage
    
    case idle
}


