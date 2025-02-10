//
//  Struct.swift
//  smsmee
//
//  Created by KimRin on 2/8/25.
//

import UIKit
// Cell에 전달해줘야 할 내용들
struct CalendarItem {
    var date: Date
    var dayBudget: Int
    var isThisMonth: Bool
    var weekSection: Int
    var backgroundColor: UIColor
    var totalIncome: Int
    var totalExpense: Int
    var totalAmount: Int
        
    
    var dayType: dayType
    //일요일이면 +1 section 값이 동일한 애들끼리 백그라운드 컬러 처리
    init(date: Date = Date(),
         dayBudget: Int = 0,
         isThisMonth: Bool = true,
         weekSection: Int = 0,
         backgroundColor: UIColor = .white,
         totalIncome: Int = 0,
         totalExpense: Int = 0
    ) {
        self.date = date
        self.dayBudget = dayBudget
        self.isThisMonth = isThisMonth
        self.weekSection = weekSection
        self.backgroundColor = backgroundColor
        self.totalIncome = totalIncome
        self.totalExpense = totalExpense
        self.totalAmount = totalIncome - totalExpense
        self.dayType = .Friday
    }
}

enum dayType {
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
    case Sunday
}
