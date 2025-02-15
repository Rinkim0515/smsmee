//
//  PlanListVC.swift
//  smsmee
//
//  Created by KimRin on 2/6/25.
//

import UIKit

import SnapKit

class PlanListVC: UIViewController {
    
    private let planlistView = PlanListView()
    
    private let items: [Item] = [
        Item(title: "테스트 제목 1", dDay: "D-5", amount: "₩10,000"),
        Item(title: "테스트 제목 2", dDay: "D-10", amount: "₩20,000"),
        Item(title: "테스트 제목 3", dDay: "D-15", amount: "₩30,000")
    ]

    override func loadView() {
        //위에 그리는걸로 바꾸자
        self.view = planlistView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        addTarget()
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    

    private func setupCollectionView() {
        planlistView.collectionView.delegate = self
        planlistView.collectionView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
}
//MARK: - Add Target
extension PlanListVC {
    
    func addTarget() {
        planlistView.addButton.addTarget(self, action: #selector(handleAddButton), for: .touchUpInside)
    }
    
    
    
    @objc func handleAddButton() {
        let viewController = UIViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}


extension PlanListVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = UIViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlanListCell.reuseId, for: indexPath) as? PlanListCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: items[indexPath.item])
        return cell
    }
}


extension PlanListVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width
        return CGSize(width: width, height: 70)
    }
}
