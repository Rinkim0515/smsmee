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
        ledgerView.calendarView.calendarCollectionView.delegate = self
    }

    func render(state: LedgerState) {
        switch state {
        case .naviagateToDetail(let date):
            let viewController = DailyTransactionVC(transactionView: DailyTransactionView())
            viewController.today = date
                self.navigationController?.pushViewController(viewController, animated: true)
            
        default:
            return
         
        }
    }


    
    private func updateDate() {
        viewModel.stateRelay
            .bind(onNext: { [weak self] state in
                self?.render(state: state)
            })
            .disposed(by: disposeBag)
        
        viewModel.calendarItems
            .bind(to: ledgerView.calendarView.calendarCollectionView.rx.items(cellIdentifier: CalendarCell.reuseId, cellType: CalendarCell.self)) { index, item, cell in
                cell.updateDate(with: item)
                
            }
            .disposed(by: disposeBag)
        
        viewModel.currentDate
            .map {
                DateFormatter.yearToMonthKR.string(from: $0)
                 }
            .bind(to: ledgerView.dateButton.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        ledgerView.calendarView.calendarCollectionView.rx.modelSelected(CalendarItem.self)
            .subscribe(onNext: { [weak self] item in

                self?.viewModel.intentRelay.accept(.tapCell(item))
            })
            .disposed(by: disposeBag)
        
        ledgerView.nextButton.rx.tap
            .map { LedgerIntent.moveNextMonth}
            .bind(to: viewModel.intentRelay)
            .disposed(by: disposeBag)
        
        ledgerView.previousButton.rx.tap
            .map { LedgerIntent.movePreviousMonth}
            .bind(to: viewModel.intentRelay)
            .disposed(by: disposeBag)
            
        ledgerView.todayButton.rx.tap
            .map { LedgerIntent.moveToday}
            .bind(to: viewModel.intentRelay)
            .disposed(by: disposeBag)
        
            
    }




}

extension LedgerVC: UICollectionViewDelegateFlowLayout {

    

//    
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let viewController = DailyTransactionVC(transactionView: DailyTransactionView())
//        viewController.setDate(day: self.calendarItems[indexPath.row].date)
//        self.navigationController?.pushViewController(viewController, animated: true)
//    }
//    
   

    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalWidth = collectionView.frame.width
        let numberOfItemsPerRow: CGFloat = 7  // 가로로 7개 배치
        let itemWidth = totalWidth / numberOfItemsPerRow
        let itemHeight = itemWidth * 1.4
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0 //여백없음
    }
}



