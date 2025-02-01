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
    /*
     Driver는 메인쓰레드에서, 에러를 방출하지 않음 화면이 전환되는것은 결국 어떠한 값을 전달 하는것이기에 두개 이상의 값을 전달할 필요가 없다고 생각함
     Intent에 따라 State값이 변하고 동시에 두가지의 State가 변하지 않음 ,
     viewModel에서는 Intent를 구독하고 VC는 State 즉 Driver를 구독함으로써 데이터에 대한 구독이 아닌 상태에 초점을 맞추는것
     
     */
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
