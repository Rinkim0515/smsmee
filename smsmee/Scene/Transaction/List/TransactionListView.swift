//
//  TransactionView.swift
//  smsmee
//
//  Created by KimRin on 2/11/25.
//

import UIKit
import SnapKit

final class TransactionListView: UIView {


    let incometitle: UILabel = UIFactory.label(title: "수입", textSize: 18, textColor: .blue)
    let expensetitle: UILabel = UIFactory.label(title: "지출", textSize: 18, textColor: .red)
    let totaltitle: UILabel = UIFactory.label(title: "합산금액", textSize: 18, textColor: .black)
    
    let incomeLabel: UILabel = UIFactory.label(title: "10", textSize: 18, textColor: .blue)
    let expenseLabel: UILabel = UIFactory.label(title: "10", textSize: 18, textColor: .red)
    let amountLabel: UILabel = UIFactory.label(title: "10", textSize: 18, textColor: .black)
    
    let titleLable: UILabel = UIFactory.label(title: "거래내역", textSize: 24, textColor: .black, isBold: true)
    
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
         listCollectionView,
         incometitle,
         totaltitle,
         expensetitle,
         incomeLabel,
         expenseLabel,
         titleLable,
         amountLabel
         
        ].forEach { self.addSubview($0) }

        
        titleLable.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(15)
            make.leading.equalTo(self.snp.leading).offset(20)
        }
        totaltitle.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(20)
            make.leading.equalToSuperview().inset(20)
        }

        expensetitle.snp.makeConstraints { make in
            make.bottom.equalTo(totaltitle).offset(-30)
            make.leading.equalTo(totaltitle)
        }
        
        incometitle.snp.makeConstraints { make in
            make.bottom.equalTo(expensetitle).offset(-30)
            make.leading.equalTo(totaltitle)
        }
        
        amountLabel.snp.makeConstraints { make in
            make.bottom.equalTo(totaltitle)
            make.trailing.equalToSuperview().inset(20)
            
        }
        incomeLabel.snp.makeConstraints { make in
            make.bottom.equalTo(incometitle)
            make.trailing.equalTo(amountLabel)
        }
        expenseLabel.snp.makeConstraints { make in
            make.bottom.equalTo(expensetitle)
            make.trailing.equalTo(amountLabel)
        }
        
        self.listCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(20)
            make.leading.trailing.equalTo(self).inset(20)
            make.height.equalTo(400)
        }

    
    }
}





