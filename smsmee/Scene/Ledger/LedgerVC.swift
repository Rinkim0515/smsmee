//
//  ViewController.swift
//  smsmee
//
//  Created by KimRin on 1/26/25.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

final class LedgerVC: UIViewController, ViewModelBindable {
    
    typealias VM = LedgerVM
    typealias Intent = LedgerIntent
    typealias State = LedgerState
    
    let viewModel: LedgerVM
    private let ledgerView = LedgerView()
    
    let disposeBag = DisposeBag()
    
    
    private var calendarDate = Date()
    private var calendarItems = [CalendarItem]()
    
    
    init(viewModel: LedgerVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupUI()
        updateDate()
    }
    
    
    func setupUI() {
        view.addSubview(ledgerView)
        ledgerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        ledgerView.calendarView.calendarCollectionView.register(CalendarCell.self, forCellWithReuseIdentifier: CalendarCell.reuseId)
    }

    func render(state: LedgerState) {
        
    }
    
    private func updateDate() {
        viewModel.calendarItems
            .bind(to: ledgerView.calendarView.calendarCollectionView.rx.items(cellIdentifier: CalendarCell.reuseId, cellType: CalendarCell.self)) { index, item, cell in
                cell.updateDate(with: item)
            }
            .disposed(by: disposeBag)
            
    }




}

extension LedgerVC/*: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout*/ {

//    
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let viewController = DailyTransactionVC(transactionView: DailyTransactionView())
//        viewController.setDate(day: self.calendarItems[indexPath.row].date)
//        self.navigationController?.pushViewController(viewController, animated: true)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        42//셀개수 고정 (6주 * 7일)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCell.reuseId, for: indexPath) as? CalendarCell else { return UICollectionViewCell() }
//        
//        cell.updateDate(item: self.calendarItems[indexPath.item])
//        
//        return cell
//    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalWidth = collectionView.frame.width
        let numberOfItemsPerRow: CGFloat = 7  // 가로로 7개 배치
        let itemWidth = totalWidth / numberOfItemsPerRow
        let itemHeight = itemWidth * 1.3
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0 //여백없음
    }
}



