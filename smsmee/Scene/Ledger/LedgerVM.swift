//
//  LedgerVM.swift
//  smsmee
//
//  Created by KimRin on 2/1/25.
// 여기서 모든 로직이 완료 되어야함 Cell 에 데이터넣어주기 전처리를 여기서 해야하고

import RxSwift
import RxCocoa
import Foundation



class LedgerVM: BaseViewModel<LedgerIntent, LedgerState> {
    
    private let dateManager = DateManager.shared
    private let realmManger = RealmManager.shared
    
    var calendarItems = BehaviorRelay<[CalendarItem]>(value: [] )
    var currentDate = BehaviorRelay<Date>(value: Date())
    var dailyTransaction: [DailyTotalTransaction] = []
    
    
    private var calendar = Calendar.current
    
    override func transform() {
        currentDate
            .subscribe(onNext: { [weak self] date in
                guard let self = self else { return }
                let newItems = self.configureCalendarItems(currentMonth: date)
                self.calendarItems.accept(newItems)
            })
            .disposed(by: disposeBag)
        
        
        intentRelay
            .subscribe(onNext: { [weak self] intent in
                guard let self = self else { return }
                switch intent {
                case .movePreviousMonth:
                    let today = Date()
                    self.currentDate.accept(today)
                    self.updateState(.updateDate(today))
                case .moveNextMonth:
                    let newDate = calendar.date(byAdding: .month, value: 1, to: self.currentDate.value) ?? self.currentDate.value
                    self.currentDate.accept(newDate)
                    self.updateState(.updateDate(newDate))
                case .moveToday:
                    let today = Date()
                    self.currentDate.accept(today)
                    self.updateState(.updateDate(today))
                case .moveToDate(let date):
                    let today = Date()
                    self.currentDate.accept(today)
                    self.updateState(.updateDate(today))
                case .tapCell(let date):
                    let today = Date()
                    self.currentDate.accept(today)
                    self.updateState(.updateDate(today))
                case .createTransaction:
                    let today = Date()
                    self.currentDate.accept(today)
                    self.updateState(.updateDate(today))
                }

            })
            .disposed(by: disposeBag)
    }

    
    func configureCalendarItems(currentMonth: Date) -> [CalendarItem] {

        var calendarItems: [CalendarItem] = []
        
        
        
        let firstDayInMonth = dateManager.getFirstDayInMonth(date: currentMonth)
        let firstWeekday = dateManager.getFirstWeekday(for: currentMonth)
        let lastMonthOfStart = dateManager.moveToSomeday(when: firstDayInMonth, howLong: -firstWeekday + 1)
        let thisMonth: Int = calendar.component(.month, from: currentDate.value)
        
        for i in 0 ..< 42 {
            let date = dateManager.moveToSomeday(when: lastMonthOfStart, howLong: i)
            let dayBudget: Int = 0
            var isThisMonth = false // +
            var weekSection: Int = 0 // ++
            var totalIncome: Int = 0
            var totalExpense: Int = 0
            var totalAmount: Int = 0
            let dayType = dateManager.getDayOfWeek(date: date)
            
            
            
            // 지출내역에 대한 총합산을 불러오는 메서드
            let amount = getAmount(date: date)
            totalIncome = amount.totalIncome
            totalExpense = amount.totalExpense
            totalAmount = totalIncome - totalExpense
            
            //이번달이 맞는지, 각주별 섹션 설정
            if thisMonth == calendar.component(.month, from: date) {
                isThisMonth = true
                
                if dayType == .Sunday {
                    weekSection += 1
                }
            }
            // 월별예산안에 대한 데이터 호출
            
            
            //생성된 데이터 구조체
            var calendarItem = CalendarItem()
            calendarItem.date = date
            calendarItem.isThisMonth = isThisMonth
            calendarItem.weekSection = weekSection
            calendarItem.totalIncome = totalIncome
            calendarItem.totalExpense = totalExpense
            calendarItem.totalAmount = totalAmount
            calendarItem.dayType = dayType
            calendarItem.dayBudget = dayBudget
            
            calendarItems.append(calendarItem)
                
            
            

       }
        return calendarItems
        
        
    }
    
    func getAmount(date:Date) -> (totalIncome: Int, totalExpense: Int) {
        let startTime = dateManager.getDayOfStart(date: date)
        let endTime = dateManager.getDayOfEnd(date: date)
        var totalIncome = 0
        var totalExpense = 0
        for i in realmManger.fetchDiaryBetweenDates(startTime, endTime) {
            if i.isIncome {
                totalIncome += Int(i.amount)
            } else {
                totalExpense += Int(i.amount)
            }
        }
        return (totalIncome, totalExpense)
    }
    

    
}


extension LedgerVM {
    // 여기에서 Cell이 주말인지 아닌지 , 각 수입과,지출,합산금액은 얼마인지 계산을 한후 뿌려줘야함
    func getCellData(date: Date){
        
        
    }
}

struct DailyTotalTransaction {
    
    let totalIncome: Int
    let totalExpense: Int
    var total: Int {
        totalIncome - totalExpense
    }
}
