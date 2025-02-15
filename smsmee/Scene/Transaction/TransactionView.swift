//
//  TransactionView.swift
//  smsmee
//
//  Created by KimRin on 2/11/25.
//

import SnapKit
import UIKit

class TransactionView: UIView {
    //MARK: - UIComponent
    private let dateLabel = UIFactory.label(title: "수입일", textSize: 14)
    private let priceLabel = UIFactory.label(title: "수입금액", textSize: 14)
    private let titleLabel = UIFactory.label(title: "수입명", textSize: 14)
    private let categoryLabel = UIFactory.label(title: "카테고리", textSize: 14)
    private let noteLabel = UIFactory.label(title: "메모", textSize: 14)
    let priceTextField = UIFactory.textField(keyboard: .numberPad)
    let titleTextField = UIFactory.textField(keyboard: .default)
    lazy var categoryTextField = UIFactory.textField(keyboard: .default)
    let cancelButton = UIFactory.button(title: "취소", bgColor: .lightGray)
    let saveButton = UIFactory.button(title: "저장", bgColor: .systemBlue)
    
    lazy var segmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["지출", "수입"])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentChange(segment:)), for: .valueChanged)
        return segmentControl
    }()
    
    let noteTextView: UITextView = {
        let textView = UITextView()
        textView.text = "메모"
        textView.textColor = .systemGray4
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.layer.borderColor = UIColor.systemGray5.cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 6.0
        return textView
    }()
    
    let datePicker: UIDatePicker = UIFactory.datePicker()
    
    let deleteButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.image = UIImage(systemName: "trash")
        return barButton
    }()
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(touch))
        self.addGestureRecognizer(recognizer)
        noteTextView.delegate = self
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Render
    func viewChange(index: Int) {
        if index == 0 {
            dateLabel.text = "지출일"
            priceLabel.text = "지출금액"
            titleLabel.text = "지출명"
            titleTextField.placeholder = "지출명"
        } else {
            dateLabel.text = "수입일"
            priceLabel.text = "수입금액"
            titleLabel.text = "수입명"
            titleTextField.placeholder = "수입명"
        }
        segmentControl.selectedSegmentIndex = index
    }
    
    private func setupUI() {
        [
         segmentControl,
         dateLabel,
         datePicker,
         priceLabel,
         priceTextField,
         titleLabel,
         titleTextField,
         categoryLabel,
         categoryTextField,
         noteLabel,
         noteTextView,
         cancelButton,
         saveButton
        ].forEach {
            self.addSubview($0)
        }
        segmentControl.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.left.right.equalToSuperview().inset(30)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(50)
            make.width.equalTo(70)
            make.height.equalTo(34)
        }
        datePicker.snp.makeConstraints { make in
            make.centerY.equalTo(dateLabel)
            make.left.equalTo(dateLabel.snp.right).offset(10)
            make.right.equalToSuperview().inset(50)
            make.height.equalTo(40)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(50)
            make.width.equalTo(70)
            make.height.equalTo(34)
        }
        priceTextField.snp.makeConstraints { make in
            make.centerY.equalTo(priceLabel)
            make.left.equalTo(priceLabel.snp.right).offset(10)
            make.right.equalToSuperview().inset(50)
            make.height.equalTo(40)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(50)
            make.width.equalTo(70)
            make.height.equalTo(34)
        }
        titleTextField.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.left.equalTo(titleLabel.snp.right).offset(10)
            make.right.equalToSuperview().inset(50)
            make.height.equalTo(40)
        }
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(50)
            make.width.equalTo(70)
            make.height.equalTo(34)
        }
        categoryTextField.snp.makeConstraints { make in
            make.centerY.equalTo(categoryLabel)
            make.left.equalTo(categoryLabel.snp.right).offset(10)
            make.right.equalToSuperview().inset(50)
            make.height.equalTo(40)
        }
        noteLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(50)
            make.width.equalTo(70)
            make.height.equalTo(34)
        }
        noteTextView.snp.makeConstraints { make in
            make.top.equalTo(noteLabel)
            make.left.equalTo(noteLabel.snp.right).offset(10)
            make.right.equalToSuperview().inset(50)
            make.height.equalTo(300)
        }
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(noteTextView.snp.bottom).offset(30)
            make.left.equalToSuperview().inset(30)
            make.right.equalTo(self.snp.centerX).offset(-10)
            make.height.equalTo(40)
        }
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(noteTextView.snp.bottom).offset(30)
            make.left.equalTo(self.snp.centerX).offset(10)
            make.right.equalToSuperview().inset(30)
            make.height.equalTo(40)
        }
        dateLabel.text = "지출일"
        priceLabel.text = "지출금액"
        titleLabel.text = "지출명"
        titleTextField.placeholder = "지출명"
    }
    
    //MARK: - Objc
    //FIXME: View가 바뀌는 이벤트라 View에 넣는게 맞지 않을까
    @objc func segmentChange(segment: UISegmentedControl) {
        viewChange(index: segment.selectedSegmentIndex)
    }
    
    @objc func touch() {
        self.endEditing(true)
    }
}

extension TransactionView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.systemGray4 {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "메모"
            textView.textColor = .systemGray4
        }
    }
}




