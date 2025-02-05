//
//  TabbarController.swift
//  smsmee
//
//  Created by KimRin on 1/26/25.
//


import UIKit
import RxSwift
import RxCocoa
import SnapKit

class CustomTabBar: UIView {
    
    private let disposeBag = DisposeBag()
    
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
    
    private let selectedTabRelay = BehaviorRelay<Tab>(value: .home) // 🔥 현재 선택된 탭 (Driver)
    var selectedTab: Driver<Tab> { return selectedTabRelay.asDriver() }

    private let tabSelectedRelay = PublishRelay<Tab>() // 🔥 버튼 클릭 이벤트 (Signal)
    var tabSelected: Signal<Tab> { return tabSelectedRelay.asSignal() }

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

            button.rx.tap
                .map { tab }
                .bind(to: tabSelectedRelay) // 🔥 버튼이 클릭되면 이벤트 발생
                .disposed(by: disposeBag)

            buttons.append(button)
            stackView.addArrangedSubview(button)
        }
    }

    /// 🚀 선택된 탭을 변경하는 메서드
    func selectTab(_ tab: Tab) {
        selectedTabRelay.accept(tab) // 🔥 현재 탭 상태 변경
    }
}
