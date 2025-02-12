//
//  CustomTextField.swift
//  smsmee
//
//  Created by KimRin on 2/12/25.
//

import UIKit

class CustomTextField: UITextField {
    private let bottomBorder = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBottomBorder()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupBottomBorder()
    }
    
    private func setupBottomBorder() {
        layer.addSublayer(bottomBorder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateBottomBorder()
    }
    
    private func updateBottomBorder() {
        bottomBorder.frame = CGRect(x: 0.0, y: self.frame.height - 1, width: self.frame.width, height: 1.0)
        bottomBorder.backgroundColor = UIColor.black.cgColor
    }
    
    @objc func dismissKeyboard() {
        resignFirstResponder()
    }
}
