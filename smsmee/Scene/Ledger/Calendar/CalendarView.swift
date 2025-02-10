//
//  CalendarView.swift
//  smsmee
//
//  Created by KimRin on 2/7/25.
//

import UIKit

import SnapKit

class CalendarView: UIView {
    
    lazy var weekStackView = UIStackView()
    lazy var calendarCollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
                flowLayout.sectionInset = UIEdgeInsets.zero
        flowLayout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(CalendarCell.self, forCellWithReuseIdentifier: CalendarCell.reuseId)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
        self.backgroundColor = .white
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI(){
        calendarCollectionView.isPagingEnabled = true
        
        [
            weekStackView,
            calendarCollectionView
        ].forEach { self.addSubview($0) }
     
        weekStackView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.horizontalEdges.equalTo(self.snp.horizontalEdges)
            make.height.equalTo(22)
        }
        calendarCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.weekStackView.snp.bottom).offset(2)
            make.width.equalTo(self.snp.width)
            make.height.equalTo(self.snp.height)
            
        }
    }
}
