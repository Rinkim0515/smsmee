//
//  TransactionView.swift
//  smsmee
//
//  Created by KimRin on 2/11/25.
//

import UIKit
import SnapKit

final class TransactionListView: UIView {

    let dailyIncome: UILabel = UIFactory.makeLabel(title: "income",textColor: .blue ,textSize: 18)
    let dailyExpense: UILabel = UIFactory.makeLabel(title: "income",textColor: .red ,textSize: 18)
    lazy var listCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
        
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .white
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    //MARK: - UI Render
    private func setupUI() {
        [
         self.dailyIncome,
         self.dailyExpense,
         self.listCollectionView
        ].forEach { self.addSubview($0) }
        
        self.dailyIncome.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(20)
            make.trailing.equalTo(dailyExpense.snp.leading).offset(-20)
            make.height.equalTo(50)
        }
        self.dailyExpense.snp.makeConstraints { make in
            make.centerY.equalTo(dailyIncome.snp.centerY)
            make.trailing.equalTo(self.snp.trailing).offset(-20)
        }
        self.listCollectionView.snp.makeConstraints { make in
            make.top.equalTo(dailyIncome.snp.bottom).offset(20)
            make.leading.trailing.equalTo(self).inset(20)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
    }
}



