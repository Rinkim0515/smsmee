//
//  AbstractVC.swift
//  smsmee
//
//  Created by KimRin on 1/26/25.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController<VM: BaseViewModel<Intent, State>, Intent:BaseIntent, State: BaseState>: UIViewController {
    
    let disposeBag = DisposeBag()
    let viewModel: VM
    
    init(viewModel:VM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    
    func setupUI() {
        // 오버라이드해서 사용
    }
    
    func bindViewModel() {
        viewModel.state
            .drive(onNext: {[weak self] state in
                self?.render(state: state)
            })
            .disposed(by: disposeBag)
    }
    
    func render(state: State) {
        // 오버라이드해서 사용
    }
    
    

    
}



protocol ViewModelBindable {
    associatedtype Intent: BaseIntent
    associatedtype State: BaseState
    associatedtype VM: BaseViewModel<Intent, State>

    var viewModel: VM { get }
    var disposeBag: DisposeBag { get }
    
    func bindViewModel()
    func render(state: State)
}

extension ViewModelBindable where Self: UIViewController {
    func bindViewModel() {
        viewModel.state
            .drive(onNext: { [weak self] state in
                self?.render(state: state)
            })
            .disposed(by: disposeBag)
    }
}
