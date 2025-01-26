//
//  DataModel.swift
//  smsmee
//
//  Created by KimRin on 1/26/25.
//

import Foundation
import RealmSwift

class User: Object {
    // 1:1 관계
    @Persisted(primaryKey: true) var id: String = UUID().uuidString // Primary key
    @Persisted var name: String? // 사용자 이름
    @Persisted var assetAmount: Int64 = 0 // 거래내역을 통한 총합산 자산
    // 1:N 관계
    @Persisted var plans: List<Plan> = List<Plan>()
    @Persisted var transactions: List<Transaction> = List<Transaction>()
    @Persisted var budgets: List<Budget> = List<Budget>()
}


class BaseEntity: Object {
    @Persisted(primaryKey: true) var key: UUID = UUID() // Primary key
    @Persisted var id: String = UUID().uuidString // 고유 식별자
    @Persisted var amount: Int64 = 0 // 금액
    @Persisted var category: String? // 카테고리
    @Persisted var memo: String? // 메모
    @Persisted var title: String? // 제목
}


class Plan: BaseEntity {
    @Persisted var startDate: Date? // 시작 날짜
    @Persisted var endDate: Date? // 종료 날짜
    @Persisted var currentAmount: Int64 = 0 // 데이터 무결성, 호환성을 위해서 Int64를 쓴다고 함
    @Persisted var goalAmount: Int64 = 0
    @Persisted var isCompleted: Bool = false // 완료 여부
    

    // Relationships
    @Persisted(originProperty: "plans") var user: LinkingObjects<User> // 역참조 관계
}

class Transaction: BaseEntity {
    @Persisted var date: Date? // 날짜
    @Persisted var isIncome: Bool = false // 상태 (수입/지출 등)
    @Persisted var userId: String? // 사용자 ID

    // Relationships
    @Persisted(originProperty: "transactions") var user: LinkingObjects<User> // 역참조
}

class Budget: BaseEntity {
    @Persisted var date: Date? // 날짜
    @Persisted var isIncome: Bool = false // 상태 (수입/지출 여부)

    // Relationships
    @Persisted(originProperty: "budgets") var user: LinkingObjects<User> // 역참조
}
