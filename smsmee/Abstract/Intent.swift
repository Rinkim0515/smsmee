//
//  Intent.swift
//  smsmee
//
//  Created by KimRin on 2/1/25.
// 의도전달

import Foundation

protocol BaseIntent {}
protocol BaseState {
    static var idle: Self { get } // 초기 상태를 의미하는
}




enum BudgetIntent {
    
}

enum TransactionIntent {
    
}



// 모델은 CRUD 만 나머지는 구조체로 
