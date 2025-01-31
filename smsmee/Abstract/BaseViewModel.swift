//
//  AbstractVM.swift
//  smsmee
//
//  Created by KimRin on 1/26/25.
//

import Foundation
import RxSwift
import RxCocoa

class BaseViewModel<Intent: BaseIntent, State: BaseState> {
    let disposeBag = DisposeBag()
    
    // Intent를 처리하는 Subject
    let intentSubject = PublishSubject<Intent>()
    // State를 관리 하는 Relay
    private let stateRelay = BehaviorRelay<State>(value: State.idle)
    // Driver는 메인쓰레드에서, 에러를 방출하지 않음
    var state: Driver<State> { stateRelay.asDriver() }
    
    init() {
        transform()
    }
    
    func transform () {
        
    }
    
    func updateState(_ newState: State) {
        stateRelay.accept(newState)
    }
}
