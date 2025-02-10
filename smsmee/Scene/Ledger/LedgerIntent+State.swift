//
//  LedgerIntent+State.swift
//  smsmee
//
//  Created by KimRin on 2/7/25.
//

import Foundation

enum LedgerIntent: BaseIntent {
    case tapDate
    case tapCell(Date)
    case tapBudget
    
}

enum LedgerState: BaseState {
    case idle
    
    
    
    
}
