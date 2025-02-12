//
//  TransactionVC.swift
//  smsmee
//
//  Created by KimRin on 2/11/25.
//

import UIKit
import SnapKit

final class TransactionListVC: UIViewController {

    let transactionView: TransactionListView
    var transactionList: [Transaction] = []
    var today = Date()
    let dateManager = DateManager.shared
    
    var dailyIncome = 0
    var dailyExpense = 0
    
    init(transactionView: TransactionListView) {
        
        self.transactionView = transactionView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setupUI()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        transactionView.listCollectionView.reloadData()
        reloadTotalAmount()
    }
    
    private func setupUI() {
        
        transactionView.listCollectionView.dataSource = self
        transactionView.listCollectionView.delegate = self
        transactionView.listCollectionView.register(TransactionListCell.self, forCellWithReuseIdentifier: TransactionListCell.reuseId)
        self.view.addSubview(transactionView)
        
        transactionView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }

    func setDate(day: Date){
        today = day
        let dateString = DateFormatter.yearToDay.string(from: day)
        self.navigationItem.title = dateString
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
            
        
//            let imcomeString = KoreanCurrencyFormatter.shared.string(from: incomeAmount)
//            let expenseString = KoreanCurrencyFormatter.shared.string(from: expesneAmount)

            self.transactionView.dailyIncome.text = "수입: \(imcomeString) 원"
            self.transactionView.dailyExpense.text = "지출: \(expenseString) 원"
            
        
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

