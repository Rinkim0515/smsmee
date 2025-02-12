//
//  UIFactory.swift
//  smsmee
//
//  Created by KimRin on 1/26/25.
//

import UIKit

class UIFactory {
    //MARK: - UIButton
    static func button(title: String, bgColor: UIColor) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = bgColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }
    //MARK: - UILabel
    static func label(title: String,textSize: CGFloat,textColor: UIColor = .black,align: NSTextAlignment = .left,isBold: Bool = false) -> UILabel {
        let label = UILabel()
        label.textAlignment = align
        label.text = title
        label.textColor = textColor
        label.font = isBold ?
        UIFont.boldSystemFont(ofSize: textSize) : UIFont.systemFont(ofSize: textSize)
        label.numberOfLines = 0
        return label
    }
    //MARK: - UITextField
    static func textField(keyboard: UIKeyboardType, rightViewString: String = "") -> CustomTextField {
        let textField = CustomTextField()
        textField.textColor = UIColor.black
        textField.borderStyle = .none
        textField.keyboardType = keyboard
        textField.clipsToBounds = false
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "입력완료", style: .done, target: textField, action: #selector(textField.dismissKeyboard))
        toolbar.setItems([doneButton], animated: true)
        textField.inputAccessoryView = toolbar
        
        guard rightViewString == "" else {
            let currencyLabel = UILabel()
            currencyLabel.text = rightViewString
            currencyLabel.font = textField.font
            currencyLabel.textColor = .black
            currencyLabel.sizeToFit()
            
            textField.rightView = currencyLabel
            textField.rightViewMode = .always
            return textField }
        
        
        return textField
    }
    //MARK: - UIDatePicker
    static func datePicker() -> UIDatePicker {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.locale = Locale(identifier: "ko_KR")
        picker.timeZone = TimeZone(identifier: "Asia/Seoul")
        return picker
    }
    
    
}
