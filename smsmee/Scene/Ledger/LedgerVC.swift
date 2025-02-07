//
//  ViewController.swift
//  smsmee
//
//  Created by KimRin on 1/26/25.
//

import UIKit

import SnapKit
import RxSwift

final class LedgerVC: UIViewController, ViewModelBindable {
    typealias Intent = <#type#>
    
    typealias State = <#type#>
    
    typealias VM = <#type#>
    
    var disposeBag: RxSwift.DisposeBag
    

    private let ledgerView = LedgerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupUI()
    }
    
    override func setupUI() {
        view.addSubview(ledgerView)
        ledgerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    override func render(state: LedgerState) {
        
    }




}



