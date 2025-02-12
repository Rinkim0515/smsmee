//
//  PlanListVM.swift
//  smsmee
//
//  Created by KimRin on 2/12/25.
//

import Foundation
enum PlanListIntent: BaseIntent {
    case tapCreate
    case tapCell
}

enum PlanListState: BaseState {
    case idle
}


final class PlanListVM: BaseViewModel<PlanListIntent, PlanListState> {
    
}
