//
//  Intent.swift
//  smsmee
//
//  Created by KimRin on 2/1/25.
// 의도전달

import Foundation

protocol BaseIntent {}
protocol BaseState {
    static var idle: Self { get }
}




enum BudgetIntent {
    
}

enum TransactionIntent {
    
}

enum MessageReaderIntent: BaseIntent {
    case saveText(String)
}

enum MessageReaderState: BaseState {
    case idle
    case success(String)
    case failure(String)
}

// 모델은 CRUD 만 나머지는 구조체로 
