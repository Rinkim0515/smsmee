//
//  LedgerIntent+State.swift
//  smsmee
//
//  Created by KimRin on 2/7/25.
//

import Foundation
import UIKit

enum LedgerIntent: BaseIntent {
    case movePreviousMonth
    case moveNextMonth
    case moveToday
    case moveToDate(Date)
    
    case tapCell(Date)
    case createTransaction
}

enum LedgerState: BaseState {
    case idle
    case updateDate(Date)
    case naviagateToDetail(Date)
    case navigateToTransaction
    
}
