//
//  protocol.swift
//  smsmee
//
//  Created by KimRin on 2/6/25.
//

import Foundation

//MARK: - CEll id generator
protocol CellReusable {
    static var reuseId: String { get }
    
}

extension CellReusable {
    static var reuseId: String {
        String(describing: self)
    }
}


