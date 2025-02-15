//
//  TransactionVM.swift
//  smsmee
//
//  Created by KimRin on 2/12/25.
//

import Foundation
enum TransactionIntent: BaseIntent {
    case tapSave
    case tapCancel
    case tapDelete
}

enum TransactionState: BaseState {
    case save(String)
    case idle
}

class TransactionVM: BaseViewModel<TransactionIntent, TransactionState> {
    // 입력 완료 된것을 받자 endediting에서 invalid 를 하고 save가 눌리면 success or fail
    
    
    
    override func transform() {
        <#code#>
    }
    
    @objc func saveData() {
        let date = transactionView.datePicker.date
        
        guard let amountText = transactionView.priceTextField.text,
              let amount = KoreanCurrencyFormatter.shared.number(from: amountText) else {
            showAlert(message: "올바른 금액을 입력해주세요.")
            return
        }
        
        let isIncome = transactionView.segmentControl.selectedSegmentIndex == 1
        let title = transactionView.titleTextField.text ?? ""
        let category = transactionView.categoryTextField.text
        let note = transactionView.noteTextView.text
        let memo = note == "메모" ? nil : note
        
        
        let entity = Transaction()
        entity.title = title
        entity.date = date
        entity.amount = amount
        entity.isIncome = isIncome
        entity.category = category
        entity.memo = memo
        
        RealmManager.shared.create(entity)
        
    
        
        showAlert(message: "데이터가 성공적으로 저장되었습니다.") { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
}
