//
//  TabbarController.swift
//  smsmee
//
//  Created by KimRin on 1/26/25.
//

import UIKit
import SnapKit

class CustomTabBar: UIView {
    
    private var buttons: [UIButton] = []
    
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

        let tabIcons = ["house.fill", "magnifyingglass", "bell", "person"]
        
        for icon in tabIcons {
            let button = UIButton(type: .system)
            button.setImage(UIImage(systemName: icon), for: .normal)
            button.tintColor = .black
            
            buttons.append(button)
            stackView.addArrangedSubview(button)
        }
    }

    // 🚀 `ViewController`가 버튼을 직접 제어할 수 있도록 버튼 배열을 반환
    func getButtons() -> [UIButton] {
        return buttons
    }

    // 🚀 UI 업데이트 (선택된 버튼만 강조)
    func updateUI(selectedIndex: Int) {
        for (index, button) in buttons.enumerated() {
            button.tintColor = index == selectedIndex ? .red : .black
        }
    }
}
