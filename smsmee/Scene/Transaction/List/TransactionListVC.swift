//
//  TransactionVC.swift
//  smsmee
//
//  Created by KimRin on 2/11/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class TransactionListVC: UIViewController, ViewModelBindable {
    
    typealias Intent = TransactionListIntent
    typealias State = TransactionListState
    typealias VM = TransactionListVM
    
    var disposeBag = DisposeBag()
    let listView = TransactionListView()

    var transactionList: [Transaction] = []
    var viewModel: TransactionListVM
    let dateManager = DateManager.shared
    var dailyIncome = 0
    var dailyExpense = 0
    
    //MARK: - LifeCycle
    init(viewModel: TransactionListVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setupUI()
        
        updateData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        listView.listCollectionView.reloadData()
    }
    
    
    

    
    func updateData() {
        viewModel.stateRelay
            .bind(onNext: { [weak self] state in
                self?.render(state: state)
                
            })
            .disposed(by: disposeBag)
        viewModel.expenseAmount
            .map{ String($0) }
            .bind(to: listView.incomeLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.incomeAmount
            .map { String($0) }
            .bind(to: listView.expenseLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.currrentDate
            .map { DateFormatter.yearToDayKR.string(from: $0) }
            .bind(to: self.navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        viewModel.transactions
            .bind(to: listView.listCollectionView.rx.items(cellIdentifier:TransactionListCell.reuseId, cellType: TransactionListCell.self)) { index, item, cell in
                cell.updateData(transaction: item)
                
                cell.layer.cornerRadius = 20
                cell.layer.borderWidth = 1
                cell.layer.borderColor = UIColor.black.cgColor
            }
            .disposed(by: disposeBag)
        listView.listCollectionView.rx.modelSelected(Transaction.self)
            .subscribe(onNext: { [weak self] item in
                self?.viewModel.intentRelay.accept(.tapCell(item))
                //탭이 되었음을 알리고 데이터를 전달해줘야하는데  그래야 edit으로
            })
            .disposed(by: disposeBag)
    }
    
    func render(state: TransactionListState) {
        switch state {
        case .navigateToDetail(let item):
            let viewController = TransactionVC(transactionItem: item)
            self.navigationController?.pushViewController(viewController, animated: true)
        default:
            return
        }
    }
    
    
    
    private func setupUI() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,  // 원하는 색상으로 변경
            .font: UIFont.boldSystemFont(ofSize: 18) // 폰트 설정 (선택 사항)
        ]
        
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        
        
        
        listView.listCollectionView.delegate = self
        listView.listCollectionView.register(TransactionListCell.self, forCellWithReuseIdentifier: TransactionListCell.reuseId)
        
        self.view.addSubview(listView)
        
        listView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        
    }
    func accept(date: Date) {
        viewModel.currrentDate.accept(date)
    }
    
    
}

extension TransactionListVC {

    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        guard let cell = collectionView.dequeueReusableCell(
//            withReuseIdentifier: TransactionListCell.reuseId,
//            for: indexPath) as? TransactionListCell
//                
//        else { return UICollectionViewCell() }
//        
//        cell.updateData(transaction: transactionList[indexPath.row])
//        cell.layer.cornerRadius = 20
//        cell.layer.borderWidth = 1
//        cell.layer.borderColor = UIColor.black.cgColor
//        return cell
//    }
}

extension TransactionListVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width
        return CGSize(width: width, height: 70)
    }
}

