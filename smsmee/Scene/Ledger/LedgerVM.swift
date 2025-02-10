//
//  LedgerVM.swift
//  smsmee
//
//  Created by KimRin on 2/1/25.
//

import RxSwift
import RxCocoa
import Foundation



class LedgerVM: BaseViewModel<LedgerIntent, LedgerState> {
    
    var calendarItems = BehaviorRelay<[CalendarItem]>(value: [] )
    var currentDate = BehaviorRelay<Date>(value: Date())
    
    private let dateManager = DateManager.shared
    
    
    private var calendar = Calendar.current
    
    override func transform() {
        
        calendarItems.accept(initCalendar())
        intentRelay
            .subscribe(onNext: { [weak self] intent in
//                switch intent {
//                case .selectDate(let date):
//                    self.
//                }
            })
            .disposed(by: self.disposeBag)
    }
    
    
    
    private func updateCalendar() {
//        let date = DateFormatter.yearToMonthKR.string(from: self.calendarDate)
//
//        let temp = DateManager.shared.configureDays(currentMonth: calendarDate)
//        let thisMonth = calendar.component(.month, from: calendarDate)
//        var sectionCount = 0
//        calendarItems.bind(onNext: { _ in
//            <#code#>
//        })
//        
//        = temp.map { i in
//            let weekDay = DateManager.shared.getWeekday(month: i)
//            //주차 할당
//            let calendar = CalendarItem(date: i,
//                                        isThisMonth: calendar.component(.month, from: i) == thisMonth, weekSection: sectionCount )
//
//            if weekDay == 7 {
//                sectionCount += 1
//            }
//
//            return calendar
        }
        
        func initCalendar() -> [CalendarItem] {
            let temp = dateManager.configureDays(currentMonth: currentDate.value)
            var calendar = CalendarItem()
            var calendars = [CalendarItem]()
            
            for i in temp {
                calendar.date = i
                calendars.append(calendar)
            }

            return calendars
    }
    
    func configureDays (currentMonth: Date) -> [Date] {
        
        var totalDays: [Date] = []
        
        let firstDayInMonth = dateManager.getFirstDayInMonth(date: currentMonth)
        let firstWeekday = dateManager.getFirstWeekday(for: currentMonth)
        let lastMonthOfStart = dateManager.moveToSomeday(when: firstDayInMonth, howLong: -firstWeekday + 1)
        //42개의 셀을 위함
        for i in 0 ..< 42 {
            totalDays.append(dateManager.moveToSomeday(when: lastMonthOfStart, howLong: i))
            }
        return totalDays
    }
    
    
    
}


