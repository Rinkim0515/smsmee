//
//  UIColor +.swift
//  smsmee
//
//  Created by KimRin on 2/7/25.
//

import UIKit
//MARK: - generate HexColor
extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0x0000FF) / 255.0
        let a = CGFloat(1.0)
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}


//MARK: - BaseColor
extension UIColor {
    static let labelBlack = UIColor(hex: "#060b11")
    static let bodyGray = UIColor(hex: "#5d6285")
    static let disableGray = UIColor(hex: "#80828f")
    static let primaryBlue = UIColor(hex: "#3756f4")
    
    static let pastelGreen = UIColor(hex: "D0E8C5")
    static let pastelBlue = UIColor(hex: "295F98")
    static let pastelRed = UIColor(hex: "C96868")
    
    static let tabBarRed = UIColor(hex: "7C444F")
    
}







