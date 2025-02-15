//
//  TransactionEditVC.swift
//  smsmee
//
//  Created by KimRin on 2/11/25.
//

import Foundation
import UIKit
import RxSwift

final class TransactionVC: UIViewController, ViewModelBindable  {
    typealias Intent = TransactionIntent
    typealias State = TransactionState
    typealias VM = TransactionVM
    
    private let transactionView: TransactionView = TransactionView()
    var viewModel: TransactionVM
    
    private var transactionItem: TransactionItem?
    let disposeBag = DisposeBag()
    
    
    
    //MARK: - Life Cycle
    init(transactionItem: TransactionItem? = nil, viewModel: TransactionVM) {
        
        self.transactionItem = transactionItem
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    // 초기화때 값이 없으면 생성, 있으면 편집
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        addTarget()
        setupTextFields()
    }
    
    override func loadView() {
        super.loadView()
        self.view = transactionView
    }
    

    
    func render(state: TransactionState) {
        
    }
    
    private func setupTextFields() {
        transactionView.priceTextField.delegate = self
        transactionView.categoryTextField.delegate = self
        transactionView.priceTextField.tag = 0
        transactionView.categoryTextField.tag = 1
    }
    
    //MARK: - Objc
    func addTarget() {
        transactionView.saveButton.addTarget(self, action: #selector(saveData), for: .touchUpInside)
        transactionView.cancelButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        
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

    private func showAlert(message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in
            completion?()
        })
        present(alert, animated: true)
    }
    
    
    @objc func didTapCancelButton() {
        self.navigationController?.popViewController(animated: false)
    }
}


// MARK: - 텍스트필드 한국화폐 표기
extension TransactionVC {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.tag == 0 {
            if let currentText = textField.text,
               let textRange = Range(range, in: currentText) {
                let updatedText = currentText.replacingCharacters(in: textRange, with: string)
                let formattedText = KoreanCurrencyFormatter.shared.formatForEditing(updatedText)
                textField.text = formattedText
            }
            return false
        }
        return true

    }
    


    

}

extension TransactionVC: UITextFieldDelegate {
    
}

