//
//  LedgerView.swift
//  smsmee
//
//  Created by KimRin on 1/26/25.
//

import UIKit

class LedgerView: BaseView {
    
    override init() {
        
        super.init()
        self.backgroundColor = .red
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
