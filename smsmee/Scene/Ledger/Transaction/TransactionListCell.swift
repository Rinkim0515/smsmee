//
//  TransactionCell.swift
//  smsmee
//
//  Created by KimRin on 2/11/25.
//

import UIKit

final class DailyTransactionCell: UICollectionViewCell, CellReusable {
    private let categoryImage = UIImageView()
    private let nameLabel: UILabel = UIFactory.makeLabel(title: "내용",textColor: .black ,textSize: 18, align: .left)
    private let amountLabel: UILabel = UIFactory.makeLabel(title: "금액",textColor: .lightGray ,textSize: 15, align: .left)
    private let timeLabel: UILabel = UIFactory.makeLabel(title: "시간",textColor: .lightGray ,textSize: 13, align: .right)
    

    
    private lazy var contentsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, amountLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupCellUI()
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func updateData(transaction: Transaction){
        let time = DateFormatter.hourToMinuteKr.string(from: transaction.date ?? Date())
        print(transaction)
        amountLabel.text =  "\(transaction.amount)"
        
        
        if transaction.isIncome {
            amountLabel.textColor = .primaryBlue
            categoryImage.image = UIImage(systemName: "plus.circle")
            categoryImage.tintColor = .primaryBlue
        } else {
            amountLabel.textColor = .red
            categoryImage.image = UIImage(systemName: "minus.circle")
            categoryImage.tintColor = .systemRed
        }
        
        nameLabel.text = transaction.title
        timeLabel.text = time
        
    }
    
    private func setupCellUI() {
        [categoryImage, contentsStackView, timeLabel].forEach { self.addSubview($0) }
        
    }
    private func setupLayout() {
        self.categoryImage.snp.makeConstraints {
            $0.leading.equalTo(self.snp.leading).offset(10)
            $0.centerY.equalTo(self)
            $0.width.height.equalTo(40)
        }
        
        self.contentsStackView.snp.makeConstraints {
            $0.leading.equalTo(self.categoryImage.snp.trailing).offset(10)
            $0.centerY.equalTo(self)
        }
        
        self.timeLabel.snp.makeConstraints {
            $0.trailing.equalTo(self.snp.trailing).inset(20)
            $0.centerY.equalTo(self)
        }
    }
    
    
}
