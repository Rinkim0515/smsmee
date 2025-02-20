//
//  TransactionEditVC.swift
//  smsmee
//
//  Created by KimRin on 2/11/25.
//
import UIKit
import SnapKit


final class TransactionVC: UIViewController, UITextFieldDelegate {
    private var transactionItem: Transaction?
    private let transactionView = TransactionView()
    
    // MARK: - LifeCycle
    init(transactionItem: Transaction? = nil) {
        self.transactionItem = transactionItem
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addTarget()
        setupUI()
        loadTransactionData()
    }
    



    private func setupUI() {
        view.addSubview(transactionView)
        transactionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
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

        if let existingItem = transactionItem {
            // ✅ 기존 데이터 업데이트
            RealmManager.shared.update {
                existingItem.title = title
                existingItem.date = date
                existingItem.amount = amount
                existingItem.isIncome = isIncome
                existingItem.category = category
                existingItem.memo = memo
            }
            showAlert(message: "데이터가 성공적으로 업데이트되었습니다.") { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
        } else {
            // ✅ 새 데이터 생성
            let entity = Transaction()
            entity.title = title
            entity.date = date
            entity.amount = amount
            entity.isIncome = isIncome
            entity.category = category
            entity.memo = memo
            entity.userId = entity.userId

            RealmManager.shared.create(entity)

            showAlert(message: "데이터가 성공적으로 저장되었습니다.") { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
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
    
    private func loadTransactionData() {
        guard let item = transactionItem else { return }

        transactionView.titleTextField.text = item.title
        transactionView.datePicker.date = item.date ?? Date()
        transactionView.priceTextField.text = KoreanCurrencyFormatter.shared.string(from: item.amount)
        transactionView.segmentControl.selectedSegmentIndex = item.isIncome ? 1 : 0
        transactionView.categoryTextField.text = item.category
        transactionView.noteTextView.text = item.memo ?? "메모"
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

