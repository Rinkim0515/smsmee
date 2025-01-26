//
//  AbstractView.swift
//  smsmee
//
//  Created by KimRin on 1/26/25.
//

import UIKit


class AbstractView: UIView {
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
