//
//  TabBarVM.swift
//  smsmee
//
//  Created by KimRin on 2/5/25.
//

import Foundation
import RxSwift
import RxCocoa

class TabBarViewModel {
    
    // ✅ Intent를 받는 Relay
    private let intentRelay = PublishRelay<TabBarIntent>()
    
    // ✅ State를 관리하는 Driver
    private let stateRelay: BehaviorRelay<TabBarState>
    var state: Driver<TabBarState> { stateRelay.asDriver() }
    
    private let disposeBag = DisposeBag()
    
    init() {
        // 🚀 초기 상태: Home 탭 선택됨
        stateRelay = BehaviorRelay(value: TabBarState(selectedTab: .home))
        
        // 🚀 Intent를 구독하여 State를 업데이트
        intentRelay
            .compactMap { intent -> TabBarState.Tab? in
                switch intent {
                case .selectTab(let tab): return tab
                }
            }
            .map { TabBarState(selectedTab: $0) }
            .bind(to: stateRelay)
            .disposed(by: disposeBag)
    }
    
    // 🚀 Intent를 전달하는 함수
    func process(intent: TabBarIntent) {
        intentRelay.accept(intent)
    }
}
