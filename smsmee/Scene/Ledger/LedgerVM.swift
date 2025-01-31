//
//  LedgerVM.swift
//  smsmee
//
//  Created by KimRin on 2/1/25.
//

import Foundation
enum LedgerIntent: BaseIntent {
    case loadBudgetVC
    case loadSomeDayTransaction
    case loadMessageVC
    case createTransaction
    
}
enum LedgerState: BaseState {
    case idle
    
}


class LedgerVM: BaseViewModel<LedgerIntent, LedgerState> {
    
}


