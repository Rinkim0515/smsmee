//
//  UIFactory.swift
//  smsmee
//
//  Created by KimRin on 1/26/25.
//

import UIKit

class UIFactory {
    static func makeButton(title: String, bgColor: UIColor) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = bgColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }
    
    // 버튼 타이틀은 볼드 처리로하고 일반텍스트는 그냥쓰자
    static func makeLabel(title: String,
                          textColor: UIColor = .black,
                          textSize: CGFloat,
                          align: NSTextAlignment = .left,
                          isBold: Bool = false) -> UILabel {
        
        let label = UILabel()
        label.textAlignment = align
        label.text = title
        label.textColor = textColor
        
        label.font = isBold ?
        UIFont.boldSystemFont(ofSize: textSize) : UIFont.systemFont(ofSize: textSize)
        
        label.numberOfLines = 0
        return label
    }
    
    
}
