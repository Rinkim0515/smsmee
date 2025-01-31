//
//  AbstractView.swift
//  smsmee
//
//  Created by KimRin on 1/26/25.
//

import UIKit


class BaseView: UIView {
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
    }
    
    func configureUI() {
        
    }
    
}
