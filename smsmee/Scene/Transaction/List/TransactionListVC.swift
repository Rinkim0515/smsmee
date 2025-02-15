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
    
    var today = Date()
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
        reloadTotalAmount()
    }
    
    
    
    func render(state: TransactionListState) {
        
    }
    
    func updateData() {
        viewModel.expenseAmount
            .map{ String($0) }
            .bind(to: listView.dailyExpense.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.incomeAmount
            .map { String($0) }
            .bind(to: listView.dailyIncome.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.currrentDate
            .map { DateFormatter.yearToDayKR.string(from: $0) }
            .bind(to: self.navigationItem.rx.title)
            .disposed(by: disposeBag)
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
        
        
        listView.listCollectionView.dataSource = self
        listView.listCollectionView.delegate = self
        listView.listCollectionView.register(TransactionListCell.self, forCellWithReuseIdentifier: TransactionListCell.reuseId)
        self.view.addSubview(listView)
        
        listView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }

    
    private func reloadTotalAmount() {
        
        let startTime = dateManager.getDayOfStart(date: today)
        let endTime = dateManager.getDayOfEnd(date: today)
        
        transactionList = Array(RealmManager.shared.fetchDiaryBetweenDates(startTime,endTime))
        
            var incomeAmount = 0
            var expesneAmount = 0
            
            for item in transactionList {
                if item.isIncome { incomeAmount += Int(item.amount) }
                else { expesneAmount += Int(item.amount) }
            }
        let imcomeString = "\(incomeAmount)"
        let expenseString = "\(expesneAmount)"
            
    

            self.listView.dailyIncome.text = "수입: \(imcomeString) 원"
            self.listView.dailyExpense.text = "지출: \(expenseString) 원"
            
        
    }
    
}

extension TransactionListVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let viewController = MoneyDiaryEditVC(item: transactionList[indexPath.row])
//        self.navigationController?.pushViewController(viewController, animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return transactionList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TransactionListCell.reuseId,
            for: indexPath) as? TransactionListCell
                
        else { return UICollectionViewCell() }
        
        cell.updateData(transaction: transactionList[indexPath.row])
        cell.layer.cornerRadius = 20
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
        return cell
    }
}

extension TransactionListVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width
        return CGSize(width: width, height: 70)
    }
}

