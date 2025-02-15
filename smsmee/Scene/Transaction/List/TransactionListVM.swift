//
//  TransactionVM.swift
//  smsmee
//
//  Created by KimRin on 2/15/25.
//

import Foundation
import RxSwift
import RxCocoa

enum TransactionListIntent: BaseIntent {
    case tapCell(Transaction)
}

enum TransactionListState: BaseState {
    case idle
    case navigateToDetail(Transaction)
}

class TransactionListVM: BaseViewModel<TransactionListIntent, TransactionListState> {
    private let dateManager = DateManager.shared
    let currrentDate = BehaviorRelay<Date>(value: Date())
    let transactions = BehaviorRelay<[Transaction]>(value: [])
    let expenseAmount = BehaviorRelay<Int>(value: 0)
    let incomeAmount = BehaviorRelay<Int>(value: 0)
    
    
    override func transform() {
        reloadTotalAmount()
        intentRelay
            .subscribe(onNext: { [weak self] intent in
                guard let self = self else { return }
                
                switch intent {
                case .tapCell(let item):
                    self.updateState(.navigateToDetail(item))
                
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func reloadTotalAmount() {
        
        let date = currrentDate.value
        let startTime = dateManager.getDayOfStart(date: date)
        let endTime = dateManager.getDayOfEnd(date: date)
        
        //load Data
        let transactionList = Array(RealmManager.shared.fetchDiaryBetweenDates(startTime,endTime))
        transactions.accept(transactionList)
        
            var income = 0
            var expesne = 0
            
            for item in transactionList {
                if item.isIncome { income += Int(item.amount) }
                else { expesne += Int(item.amount) }
            }
        expenseAmount.accept(expesne)
        incomeAmount.accept(income)
            
        

            
        
    }
}
