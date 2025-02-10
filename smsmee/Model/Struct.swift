//
//  Struct.swift
//  smsmee
//
//  Created by KimRin on 2/8/25.
//

import UIKit

struct CalendarItem {
    var date: Date
    var dayBudget: Int
    let isThisMonth: Bool
    var weekSection: Int
    var backgroundColor: UIColor
    //일요일이면 +1 section 값이 동일한 애들끼리 백그라운드 컬러 처리
    init(date: Date = Date(),
         dayBudget: Int = 0,
         isThisMonth: Bool = true,
         weekSection: Int = 0,
         backgroundColor: UIColor = .white
    ) {
        self.date = date
        self.dayBudget = dayBudget
        self.isThisMonth = isThisMonth
        self.weekSection = weekSection
        self.backgroundColor = backgroundColor
    }
}
