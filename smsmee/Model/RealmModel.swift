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
    @Persisted(primaryKey: true) var id: String // Primary key 생성
    @Persisted var name: String? // 사용자 이름
    @Persisted var assetAmount: Int64 = 0 // 거래내역을 통한 총합산 자산
    @Persisted var createdAt: Date = Date() // 첫 계정 생성일
    @Persisted var updatedAt: Date? // 마지막 수정일
    
    // 1:N 관계
    @Persisted var plans: List<Plan> = List<Plan>()
    @Persisted var transactions: List<Transaction> = List<Transaction>()
    @Persisted var budgets: List<Budget> = List<Budget>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
    //추후에 서버와의 연결을 고려했을때 uid 로 대체가능하게 설계
    convenience init(id: String = UUID().uuidString, name: String) {
        self.init()
        self.id = id
        self.name = name
    }
}


class BaseEntity: Object {
    @Persisted(primaryKey: true)  var id: String = UUID().uuidString // Primary key 생성
    @Persisted var amount: Int64 = 0 // 금액
    @Persisted var category: String? // 카테고리
    @Persisted var memo: String? // 메모
    @Persisted var title: String? // 제목
    @Persisted var createdAt: Date = Date()
    @Persisted var updatedAt: Date?
    
    // 이 필드를 Primary Key로 사용하겠다고 Realm에게 알림.
    override class func primaryKey() -> String? {
        return "id"
    }
}


class Plan: BaseEntity {
    @Persisted var startDate: Date? // 시작 날짜
    @Persisted var endDate: Date? // 종료 날짜
    @Persisted var currentAmount: Int64 = 0 // 데이터 무결성, 호환성을 위해서 Int64를 쓴다고 함
    @Persisted var goalAmount: Int64 = 0
    @Persisted var isCompleted: Bool = false // 완료 여부
    @Persisted var userId: String
    

    // Relationships
    @Persisted(originProperty: "plans") var user: LinkingObjects<User> // 역참조 관계
    
    convenience init(user: User, amount: Int64, category: String, memo: String) {
        self.init()
        self.userId = user.id  // 🔹 User와 연결
        self.amount = amount
        self.category = category
        self.memo = memo
    }
}

class Transaction: BaseEntity {
    @Persisted var date: Date? // 날짜
    @Persisted var isIncome: Bool = false // 상태 (수입/지출 등)
    @Persisted var userId: String // 사용자 ID

    // Relationships
    @Persisted(originProperty: "transactions") var user: LinkingObjects<User> // 역참조
    
    convenience init(user: User, amount: Int64, category: String, memo: String) {
        self.init()
        self.userId = user.id  // 🔹 User와 연결
        self.amount = amount
        self.category = category
        self.memo = memo
        self.date = Date()
    }
}

class Budget: BaseEntity {
    @Persisted var date: Date? // 날짜
    @Persisted var isIncome: Bool = false // 상태 (수입/지출 여부)
    @Persisted var userId: String // 사용자 ID

    // Relationships
    @Persisted(originProperty: "budgets") var user: LinkingObjects<User> // 역참조
    
    convenience init(user: User, amount: Int64, category: String, memo: String) {
        self.init()
        self.userId = user.id  // 🔹 User와 연결
        self.amount = amount
        self.category = category
        self.memo = memo
        self.date = Date()
    }
}
