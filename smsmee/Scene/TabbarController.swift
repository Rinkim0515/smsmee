//
//  TabbarController.swift
//  smsmee
//
//  Created by KimRin on 1/26/25.
//


import UIKit
import SnapKit

class CustomTabBarController: UIViewController {
    //탭바선택시 보여줄 VC
    private let tabBarView = CustomTabBar()
    private let homeVC = MesaageReaderVC(viewModel: MessageReaderVM())
    private let searchVC = UIViewController()
    private let notificationsVC = UIViewController()
    private let profileVC = UIViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChildViewControllers()
        setupCustomTabBar()
    }
    
    private func setupChildViewControllers() {
        //초기 배경색 설정
        homeVC.view.backgroundColor = .white
        searchVC.view.backgroundColor = .white
        notificationsVC.view.backgroundColor = .white
        profileVC.view.backgroundColor = .white
    }
    
    private func setupCustomTabBar() {
        view.addSubview(tabBarView)
        // 화면 바율의 10%로 설정하되 최대 CGFloat 100  최소 CGFloat 60 (동적 사이즈)
        let tabBarHeight = max(60, min(view.frame.height * 0.1, 100))
        
        tabBarView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(tabBarHeight)
        }
        //View의 delegate는 protocol 
        tabBarView.delegate = self
        //초기 Tabbar가 머무르는 위치
        switchViewController(to: .home)
    }
}

// MARK: - CustomTabBarDelegate
extension CustomTabBarController: CustomTabBarDelegate {
    func didSelectTab(_ tab: CustomTabBar.Tab) {
        switchViewController(to: tab)
    }
    
    private func switchViewController(to tab: CustomTabBar.Tab) {
        children.forEach { $0.view.removeFromSuperview(); $0.removeFromParent() }
        
        let selectedVC: UIViewController
        switch tab {
        case .home: selectedVC = homeVC
        case .search: selectedVC = searchVC
        case .notifications: selectedVC = notificationsVC
        case .profile: selectedVC = profileVC
        }
        
        addChild(selectedVC)
        view.insertSubview(selectedVC.view, belowSubview: tabBarView)
        selectedVC.view.frame = view.bounds
        selectedVC.didMove(toParent: self)
    }
}


protocol CustomTabBarDelegate: AnyObject {
    func didSelectTab(_ tab: CustomTabBar.Tab)
}

class CustomTabBar: UIView {
    
    weak var delegate: CustomTabBarDelegate?
    
    enum Tab: Int, CaseIterable {
        case home, search, notifications, profile
        
        var iconName: String {
            switch self {
            case .home: return "house.fill"
            case .search: return "magnifyingglass"
            case .notifications: return "bell"
            case .profile: return "person"
            }
        }
    }
    
    private var buttons: [UIButton] = []
    private var selectedTab: Tab = .home {
        didSet {
            updateUI()
        }
    }
    
    private let floatingButton = UIButton(type: .system) // 선택된 탭이 원형으로 돌출될 버튼
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .white
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        layer.shadowOpacity = 0.3
        layer.cornerRadius = 10
        layer.shadowRadius = 5
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
        
        for tab in Tab.allCases {
            let button = UIButton(type: .system)
            button.tag = tab.rawValue
            button.setImage(UIImage(systemName: tab.iconName), for: .normal)
            button.tintColor = .black
            button.addTarget(self, action: #selector(tabTapped(_:)), for: .touchUpInside)
            buttons.append(button)
            stackView.addArrangedSubview(button)
        }
        
        setupFloatingButton()
        updateUI()
    }
    
    private func setupFloatingButton() {
        let baseSize = max(50, min(superview?.frame.height ?? 800 * 0.07, 70)) // 기존 크기 설정
        let floatingSize = baseSize * 0.85 // 🔥 기존 크기의 70% 적용

        floatingButton.backgroundColor = .red
        floatingButton.tintColor = .white
        floatingButton.layer.cornerRadius = floatingSize / 2
        floatingButton.layer.shadowOpacity = 0.3
        floatingButton.layer.shadowRadius = 5
        floatingButton.isUserInteractionEnabled = false
        floatingButton.alpha = 1.0 // 기본적으로 보이도록 설정

        addSubview(floatingButton)
        floatingButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-5) // 🔥 탭바 내부 유지
            make.width.height.equalTo(floatingSize) // 🔥 크기 조정 적용
        }
    }
    
    @objc private func tabTapped(_ sender: UIButton) {
        guard let selected = Tab(rawValue: sender.tag) else { return }
        selectedTab = selected
        delegate?.didSelectTab(selected)
    }
    
    private func updateUI() {
        let baseSize = max(50, min(superview?.frame.height ?? 800 * 0.07, 70)) // 기존 크기 설정
        let floatingSize = baseSize * 0.85 // 🔥 70% 적용

        for (index, button) in buttons.enumerated() {
            if index == selectedTab.rawValue {
                button.tintColor = .white
                
                UIView.animate(withDuration: 0.2, animations: {
                    self.floatingButton.alpha = 0.0 // 🔥 Fade Out
                }) { _ in
                    // 아이콘 변경
                    self.floatingButton.setImage(button.imageView?.image, for: .normal)
                    
                    // 위치 및 크기 조정
                    self.floatingButton.snp.remakeConstraints { make in
                        make.centerX.equalTo(button)
                        make.centerY.equalToSuperview().offset(-5)
                        make.width.height.equalTo(floatingSize) // 🔥 크기 적용
                    }
                    
                    UIView.animate(withDuration: 0.2) {
                        self.floatingButton.alpha = 1.0 // 🔥 Fade In
                    }
                }
                
            } else {
                button.tintColor = UIColor.black.withAlphaComponent(0.5)
            }
        }
    }
}
