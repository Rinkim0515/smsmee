//
//  LedgerVM.swift
//  smsmee
//
//  Created by KimRin on 2/1/25.
//

import Foundation
enum LedgerIntent: BaseIntent {
    case loadBudgetVC
    case loadMovingdateVC
    case loadprevMonthView
    case loadnextMonthView
    case loadchartView
    case createTransaction
    
}
enum LedgerState: BaseState {
    case idle
    
    
}


class LedgerVM: BaseViewModel<LedgerIntent, LedgerState> {
    
    override func transform() {
        <#code#>
    }
    
    
}


