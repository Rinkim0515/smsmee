//
//  MyPageView.swift
//  smsmee
//
//  Created by KimRin on 2/5/25.
//

import UIKit

class TestView1: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
