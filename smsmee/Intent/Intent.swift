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


enum LedgerAction {
    case showBudger(Date) // 예산안 페이지로
    case scrollNextMonth // 다음달 스크롤 기능
    case scrollPrevMonth // 이전달 스크롤 기능
    case changeMonth(Date) // 특정일자로 이동원하는 버튼
    case conformMonth(Date) // 특정날짜 선택후 이동
    case touchCell
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
