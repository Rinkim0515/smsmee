//
//  PlanListCell.swift
//  smsmee
//
//  Created by KimRin on 2/6/25.
//

import UIKit

import SnapKit

class PlanListCell: UICollectionViewCell, CellReusable {
    private let titleLabel: UILabel = UIFactory.label(title: "타이틀", textSize: 16, isBold: true)
    private let dDayLabel: UILabel = UIFactory.label(title: "디데이", textSize: 14, align: .center)
    private let amountLabel: UILabel = UIFactory.label(title: "1000000원", textSize: 14,align: .right)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

//MARK: - Rendering
extension PlanListCell {
    private func setupUI() {
        // 왜 ContentView에 올려야 하는지?
        contentView.addSubview(titleLabel)
        contentView.addSubview(dDayLabel)
        contentView.addSubview(amountLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        dDayLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
            make.width.equalTo(60)
        }
        amountLabel.snp.makeConstraints { make in
            make.leading.equalTo(dDayLabel.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.centerY.equalToSuperview()
        }
    }
}

//MARK: - Data Fetching
extension PlanListCell {
    
    func configure(with item: Item) {
        titleLabel.text = item.title
        dDayLabel.text = item.dDay
        amountLabel.text = item.amount
    }
}





struct Item {
    let title: String   // 제목
    let dDay: String    // 디데이
    let amount: String  // 금액
}
