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
    private var buttons: [UIButton] = []
    
    // 🚀 ViewModel 연결
    let viewModel = TabBarViewModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        bindViewModel()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        bindViewModel()
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

        for tab in TabBarState.Tab.allCases {
            let button = UIButton(type: .system)
            button.tag = tab.rawValue
            button.setImage(UIImage(systemName: tab.iconName), for: .normal)
            button.tintColor = .black
            
            // 🚀 버튼 클릭 → Intent 전달
            button.rx.tap
                .map { TabBarIntent.selectTab(tab) }
                .bind(to: viewModel.intentRelay)
                .disposed(by: disposeBag)

            buttons.append(button)
            stackView.addArrangedSubview(button)
        }
    }
    
    private func bindViewModel() {
        viewModel.state
            .map { $0.selectedTab }
            .drive(onNext: { [weak self] selectedTab in
                self?.updateUI(selectedTab)
            })
            .disposed(by: disposeBag)
    }

    private func updateUI(_ selectedTab: TabBarState.Tab) {
        for (index, button) in buttons.enumerated() {
            button.tintColor = index == selectedTab.rawValue ? .red : .black
        }
    }
}
