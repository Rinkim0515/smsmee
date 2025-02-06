//
//  TabBar.swift
//  smsmee
//
//  Created by KimRin on 2/5/25.
//



import UIKit
import RxSwift
import SnapKit

class CustomTabBarController: UIViewController {
    private let tabBarView = CustomTabBar()
    private let viewModel = TabBarViewModel()
    private let disposeBag = DisposeBag()
    
    private let homeVC = MessageReaderVC(viewModel: MessageReaderVM())
    
    private let searchVC = TestViewController1()
    private let notificationsVC = UIViewController()
    private let profileVC = UIViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChildViewControllers()
        setupCustomTabBar()
        bindViewModel()

        // 🚀 최초 실행 시 `home` 화면으로 이동
        switchViewController(to: .home)
    }
    
    private func setupChildViewControllers() {
        homeVC.view.backgroundColor = .white
        searchVC.view.backgroundColor = .white
        notificationsVC.view.backgroundColor = .white
        profileVC.view.backgroundColor = .white
    }
    
    private func setupCustomTabBar() {
        view.addSubview(tabBarView)
        let tabBarHeight = max(60, min(view.frame.height * 0.1, 100))
        
        tabBarView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(tabBarHeight)
        }
        
        // 🚀 `ViewController`에서 버튼을 가져와 직접 이벤트 감지
        let buttons = tabBarView.getButtons()
        
        for (index, button) in buttons.enumerated() {
            button.tag = index // 🚀 각 버튼에 태그를 부여
            
            // ✅ `UIAction`을 사용하여 이벤트 처리 (가독성 향상)
            button.addAction(UIAction { [weak self] _ in
                guard let tab = TabBarState.Tab(rawValue: index) else { return }
                self?.viewModel.process(intent: .selectTab(tab))
            }, for: .touchUpInside)
        }
    }
    
    private func switchViewController(to tab: TabBarState.Tab) {
        print("🔄 switchViewController 호출됨: \(tab)") // 🚀 디버깅용 로그 추가

        children.forEach { $0.view.removeFromSuperview(); $0.removeFromParent() }

        let selectedVC: UIViewController
        switch tab {
        case .home:
            selectedVC = homeVC
        case .search:
            selectedVC = searchVC
        case .notifications:
            selectedVC = notificationsVC
        case .profile:
            selectedVC = profileVC
        }

        addChild(selectedVC)
        view.insertSubview(selectedVC.view, belowSubview: tabBarView)
        selectedVC.view.frame = view.bounds
        selectedVC.didMove(toParent: self)

        print("✅ 화면 전환 완료: \(tab)") // 🚀 디버깅용 로그 추가
    }

    private func bindViewModel() {
        viewModel.state
            .map { $0.selectedTab.rawValue }
            .distinctUntilChanged()
            .drive(onNext: { [weak self] index in
                self?.tabBarView.updateUI(selectedIndex: index)
            })
            .disposed(by: disposeBag)
    }
}
