//
//  LedgerIntent+State.swift
//  smsmee
//
//  Created by KimRin on 2/7/25.
//

import Foundation

enum LedgerIntent: BaseIntent {
    case tapBudget
    case tapCellDetail
    case tap
}

enum LedgerState: BaseState {
    case idle
    
    
}
