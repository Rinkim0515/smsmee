//
//  BudgetVM.swift
//  smsmee
//
//  Created by KimRin on 2/12/25.
//

import UIKit
import SnapKit

final class BudgetCell: UITableViewCell, CellReusable {
    //MARK: - UIComponent
    let categoryTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "내역"
        return textField
    }()
    let amountTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.placeholder = "금액"
        return textField
    }()
    let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("삭제", for: .normal)
        return button
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [
            categoryTextField,
            amountTextField,
            deleteButton
        ].forEach { contentView.addSubview($0) }
        
        categoryTextField.snp.makeConstraints {
            $0.leading.equalTo(contentView.snp.leading).offset(16)
            $0.centerY.equalTo(contentView.snp.centerY)
            $0.trailing.equalTo(amountTextField.snp.leading).offset(-16)
            $0.width.equalTo(contentView.snp.width).multipliedBy(0.3)
        }
        
        amountTextField.snp.makeConstraints {
            $0.trailing.equalTo(deleteButton.snp.leading).offset(-8)
            $0.centerY.equalTo(contentView.snp.centerY)
            $0.width.equalTo(100)
        }
        
        deleteButton.snp.makeConstraints {
            $0.trailing.equalTo(contentView.snp.trailing).offset(-16)
            $0.centerY.equalTo(contentView.snp.centerY)
            $0.width.equalTo(50)
            $0.height.equalTo(30)
        }
    }
}
