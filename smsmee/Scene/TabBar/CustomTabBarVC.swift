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
    private let homeVC = MesaageReaderVC(viewModel: MessageReaderVM())
    private let searchVC = UIViewController()
    private let notificationsVC = UIViewController()
    private let profileVC = UIViewController()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChildViewControllers()
        setupCustomTabBar()
        bindViewModel()
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
        
        switchViewController(to: .home) // 초기 화면을 홈으로 설정
    }
    
    private func bindViewModel() {
        tabBarView.viewModel.state
            .map { $0.selectedTab }
            .distinctUntilChanged()
            .drive(onNext: { [weak self] tab in
                self?.switchViewController(to: tab)
            })
            .disposed(by: disposeBag)
    }
    
    private func switchViewController(to tab: TabBarState.Tab) {
        children.forEach { $0.view.removeFromSuperview(); $0.removeFromParent() }
        
        let selectedVC: UIViewController = {
            switch tab {
            case .home: return homeVC
            case .search: return searchVC
            case .notifications: return notificationsVC
            case .profile: return profileVC
            }
        }()

        addChild(selectedVC)
        view.insertSubview(selectedVC.view, belowSubview: tabBarView)
        selectedVC.view.frame = view.bounds
        selectedVC.didMove(toParent: self)
    }
}
