//
//  TabBarVM.swift
//  smsmee
//
//  Created by KimRin on 2/5/25.
//



import Foundation
import RxSwift
import RxCocoa
/*
 Intent를 수신하고, State를 변경
 
 */

class TabBarViewModel: BaseViewModel<TabBarIntent, TabBarState> {
    
    override func transform() {
        self.stateRelay.accept(.myPage)
        
        //intent 발생시
        intentRelay
            .compactMap { intent -> TabBarState? in
                switch intent {
                    // intent에 state를 포함해서 전달
                case .selectTab(let tab):
                    print("📢 Intent 수신됨: \(tab)") // 디버깅 로그
                    return tab
                }
            }
        //stateRelay에 전달
            .bind(to: stateRelay)
            .disposed(by: self.disposeBag)
    }
    
    func process(intent: TabBarIntent) {
        print("📢 process(intent:) 실행됨: \(intent)") // 디버깅 로그
        intentRelay.accept(intent)
    }
}
