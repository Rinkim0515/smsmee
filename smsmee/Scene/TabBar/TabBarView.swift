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

        let tabIcons = [ "calendar", "pencil.and.scribble", "figure.step.training","person.fill"]
        
        for icon in tabIcons {
            let button = UIButton(type: .system)
            button.setImage(UIImage(systemName: icon), for: .normal)
            button.tintColor = .black
            
            buttons.append(button)
            stackView.addArrangedSubview(button)
        }
    }

    func getButtons() -> [UIButton] {
        return buttons
    }

    func updateUI(selectedIndex: Int) {
        for (index, button) in buttons.enumerated() {
            button.tintColor = index == selectedIndex ? .red : .black
        }
    }
    
    // 여기에 애니메이션 효과를 넣어서 updateUI에 넣으면 될듯
}
