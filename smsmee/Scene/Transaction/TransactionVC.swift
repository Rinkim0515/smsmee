//
//  TransactionEditVC.swift
//  smsmee
//
//  Created by KimRin on 2/11/25.
//
import UIKit
import SnapKit


final class TransactionVC: UIViewController, UITextFieldDelegate {
    private var transactionItem: TransactionItem?
    
    private let trasactionView = TransactionView()
    
    // MARK: - LifeCycle
    init(transactionItem: TransactionItem? = nil) {
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
    }
    



    private func setupUI() {
        view.addSubview(trasactionView)
        trasactionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        trasactionView.priceTextField.delegate = self
        trasactionView.categoryTextField.delegate = self
        trasactionView.priceTextField.tag = 0
        trasactionView.categoryTextField.tag = 1
    }
    
    //MARK: - Objc
    func addTarget() {
        trasactionView.saveButton.addTarget(self, action: #selector(saveData), for: .touchUpInside)
        trasactionView.cancelButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        
    }
    
    @objc func saveData() {
        let date = trasactionView.datePicker.date
        
        guard let amountText = trasactionView.priceTextField.text,
              let amount = KoreanCurrencyFormatter.shared.number(from: amountText) else {
            showAlert(message: "올바른 금액을 입력해주세요.")
            return
        }
        
        let isIncome = trasactionView.segmentControl.selectedSegmentIndex == 1
        let title = trasactionView.titleTextField.text ?? ""
        let category = trasactionView.categoryTextField.text
        let note = trasactionView.noteTextView.text
        let memo = note == "메모" ? nil : note
        
        
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

