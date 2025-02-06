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
    
    private let intentRelay = PublishRelay<TabBarIntent>()
    private let stateRelay: BehaviorRelay<TabBarState>
    
    var state: Driver<TabBarState> { stateRelay.asDriver() }
    
    private let disposeBag = DisposeBag()
    
    init() {
        stateRelay = BehaviorRelay(value: TabBarState(selectedTab: .home))
        
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
    
    func process(intent: TabBarIntent) {
        intentRelay.accept(intent)
    }
}
