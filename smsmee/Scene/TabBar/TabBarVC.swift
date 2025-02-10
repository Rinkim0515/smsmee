//
//  TabBar.swift
//  smsmee
//
//  Created by KimRin on 2/5/25.
//



import UIKit
import RxSwift
import SnapKit

class CustomTabBarController: UIViewController, ViewModelBindable {

    
    typealias VM = TabBarViewModel
    typealias Intent = TabBarIntent
    typealias State = TabBarState
    
    let viewModel: TabBarViewModel
    let disposeBag = DisposeBag()
    
    private let tabBarView = CustomTabBar()
    

    
    private let myPageVC = MessageReaderVC(viewModel: MessageReaderVM())
    private let ledgerVC = LedgerVC(viewModel: LedgerVM())
    private let graphVC = PlanListVC()
    private let planVC = UIViewController()
    
    init(viewModel: TabBarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChildViewControllers()
        setupCustomTabBar()
        bindViewModel()
        switchViewController(to: .myPage)
    }
    


    

    

}

//MARK: - Rendering
extension CustomTabBarController {
    
    
    private func setupChildViewControllers() {
        [
            myPageVC,
            ledgerVC,
            graphVC,
            planVC
        ].forEach { $0.view.backgroundColor = .white}
        
        view.addSubview(tabBarView)
        let tabBarHeight = max(60, min(view.frame.height * 0.1, 100))
        
        tabBarView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(tabBarHeight)
        }
    }
    
    private func setupCustomTabBar() {
        
        let buttons = tabBarView.getButtons()
        
        for (index, button) in buttons.enumerated() {
            button.tag = index
            
            button.addAction( UIAction { [weak self] _ in
                guard let self = self, let tab = TabBarState(rawValue: index) else { return }
                
                self.viewModel.process(intent: .selectTab(tab))
            }, for: .touchUpInside)
        }
    }
}

extension CustomTabBarController {
    // Tab to Change
    private func switchViewController(to tab: TabBarState) {
        children.forEach { $0.view.removeFromSuperview(); $0.removeFromParent() }
        let selectedVC: UIViewController
        switch tab {
        case .myPage:
            selectedVC = myPageVC
        case .ledger:
            selectedVC = ledgerVC
        case .graph:
            selectedVC = graphVC
        case .plan:
            selectedVC = planVC
        case .idle:
            selectedVC = myPageVC
        }

        addChild(selectedVC)
        view.insertSubview(selectedVC.view, belowSubview: tabBarView)
        selectedVC.view.frame = view.bounds
        selectedVC.didMove(toParent: self)
        
    }
    
    func render(state: TabBarState) {
        print("🔄 ViewModel 상태 변경 감지: \(state)") // 디버깅 로그 추가
        tabBarView.updateUI(selectedIndex: state.rawValue) // ✅ UI 업데이트
        switchViewController(to: state)
    }
}
