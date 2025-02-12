//
//  BudgetVC.swift
//  smsmee
//
//  Created by KimRin on 2/12/25.
//

import UIKit

//final class MoneyDiaryBudgetEditVC: UIViewController {
//    // MARK: - Properties
//    private let moneyDiaryBudgetEditView: MoneyDiaryBudgetEditView = MoneyDiaryBudgetEditView()
////    private let budgetCoreDataManager: BudgetCoreDataManager = BudgetCoreDataManager()
//    private let planService: FinancialPlanService = FinancialPlanService()
//    private let currentYear: Int
//    private let currentMonth: Int
//    // FIXME: 꼭 넘겨줄때 날짜로 넘겨주게 바꿔줄것!!!!!!!!!!!!!
//    private var currentDate: Date?
//    
//    //MARK: - Serivce
//    private let dateManager = DateManager.shared
//    private let realmManager = RealmManager.shared
//    
//    
//    // 예산 데이터
//    var budgetList: [MyBudgets] = []
//    
//    var entities: [MyBudget] = []
//    
//    // MARK: - ViewController Init
//    init(currentYear: Int, currentMonth: Int) {
//        self.currentYear = currentYear
//        self.currentMonth = currentMonth
//        super.init(nibName: nil, bundle: nil)
//        
//        
//        setupCurrentDate()
//        setupList()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    // MARK: - Life Cycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupTableView()
//        addButtonEvent()
//        setupNavigation()
//        setTotalAmountView()
//    }
//    
//    override func loadView() {
//        super.loadView()
//        self.view = moneyDiaryBudgetEditView
//    }
//    
//    // MARK: - Method
//    
//    func setTotalAmountView() {
//        moneyDiaryBudgetEditView.totalView.amountLabel.text = "\(setTotalAmount())"
//    }
//    func getBudgetList() {
//
//    }
//    
//    
//    
//    
//    func setSectionAmount(forSection section: Int) -> String {
//
//        
//        let total = budgetList[section].items.reduce(0) { sum, item in
//            return sum + Int64(item.amount)
//        }
//        return "\(KoreanCurrencyFormatter.shared.string(from: total)) 원"
//        
//        
//        
//    }
//    
//    func setTotalAmount() -> String {
//        var total: Int64 = 0
//        
//        for listIndex in 0..<budgetList.count {
//            for item in budgetList[listIndex].items {
//                if item.statement {
//                    total += item.amount
//                } else {
//                    total -= item.amount
//                }
//            }
//        }
//        
//        return "\(KoreanCurrencyFormatter.shared.string(from: total)) 원"
//    }
//    
//    func addNewItem(toSection section: Int) {
//        let item = MyBudget()
//        item.date = currentDate
//        item.statement = section == 0 ? true : false
//        item.category = ""
//        item.amount = 0
//        
//        
//        budgetList[section].items.append(item)
//        
//        let indexPath = IndexPath(row: budgetList[section].items.count - 1, section: section)
//        moneyDiaryBudgetEditView.tableView.insertRows(at: [indexPath], with: .automatic)
//    }
//    
//    // MARK: - Private Method
//    // FIXME: 꼭 넘겨줄때 날짜로 넘겨주게 바꿔줄것!!!!!!!!!!!!!
//    
//    //여기는 지금 init에서 받은 연도와 월을 전달해서 Date를 1일자로 고정 변환 시킴
//    private func setupCurrentDate() {
//        var dateComponents = DateComponents()
//        dateComponents.timeZone = TimeZone(secondsFromGMT: 0)
//        dateComponents.year = currentYear
//        dateComponents.month = currentMonth
//        dateComponents.day = 1
//        let calendar = Calendar.current
//        
//        if let currentDate = calendar.date(from: dateComponents) {
//            self.currentDate = currentDate // 한국 시간대로 변환된 Date 저장
//            print("한국 시간으로 설정된 currentDate: \(currentDate)")
//        } else {
//            print("날짜 오류")
//            return
//        }
//        
//        
//        
//    }
//    
//    private func setupTableView() {
//        moneyDiaryBudgetEditView.tableView.dataSource = self
//        moneyDiaryBudgetEditView.tableView.delegate = self
//        moneyDiaryBudgetEditView.tableView.register(MoneyDiaryBudgetEditCell.self, forCellReuseIdentifier: "MoneyDiaryBudgetEditCell")
//        moneyDiaryBudgetEditView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AssetPlanCell")
//        moneyDiaryBudgetEditView.tableView.register(BudgetHeaderView.self, forHeaderFooterViewReuseIdentifier: "MoneyDiaryBudgetEditHeaderView")
//    }
//    
//    private func setupNavigation() {
//        navigationItem.title = "\(currentYear)년 \(currentMonth)월 예산안"
//    }
//    
//    private func addButtonEvent() {
//        let saveButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonTapped))
//        navigationItem.rightBarButtonItem = saveButton
//    }
//    
//    // 리스트 불러오기
//    private func setupList() {
//        //해당하는달 값을 전부 가져와야함
//        
//        
//
//        
//        let firstdayOfMonth = DateManager.shared.getFirstDayInMonth(date: currentDate!)
//        let lastdayOfMonth = DateManager.shared.getlastDayInMonth(date: currentDate!)
//        
//        let selectedBudgetList2 = Array(RealmManager.shared.fetchDiaryBetweenDates2(firstdayOfMonth, lastdayOfMonth))
//        
//        
//        
//        //여기서 수입 플랜
//        let incomeList: [MyBudget] = selectedBudgetList2.filter { $0.statement }.map {
//            let budget = MyBudget()
//            budget.amount = $0.amount
//            budget.statement = $0.statement
//            budget.category = $0.category ?? ""
//            budget.date = currentDate
//            return budget
//
//        }
//        //여기서 소비플랜
//        let expendList: [MyBudget] = selectedBudgetList2.filter { !$0.statement }.map {
//            let budget = MyBudget()
//            budget.amount = $0.amount
//            budget.statement = $0.statement
//            budget.category = $0.category ?? ""
//            budget.date = currentDate
//
//            return budget
//        }
//        
//        
//        //여기는 재무플랜
//        
//        let planList: [MyBudget] = planService.fetchAllFinancialPlans().map {
//            let currentMonth = String(currentMonth).count == 1 ? "0\(currentMonth)" : "\(currentMonth)"
//            let amount = calculateSavings(startDate: $0.startDate, endDate: $0.endDate, amount: $0.amount)["\(currentYear)-\(currentMonth)"]
//            let budget = MyBudget()
//            budget.amount = amount ?? 0
//            budget.statement = false
//            budget.category = $0.title
//            budget.date = currentDate
//            
//            return budget
////            return BudgetItem(amount: amount ?? 0, statement: false, category: $0.title, date: currentDate!)
//        }
//        
//        
//        
//        
//        budgetList = [
//            MyBudgets(title: "수입 플랜", items: incomeList),
//            MyBudgets(title: "나의 재무목표 플랜", items: planList),
//            MyBudgets(title: "소비 플랜", items: expendList)
//        ]
//    }
//    
//    //MARK: - writeing
//    //주어진 범위 안의 데이터를 불러오기
//    func get123() -> [MyBudget] {
//        let n1 = dateManager.calculateStartAndEndOfDay(for: currentDate!)
//        
//        let entities = Array(realmManager.fetchDiaryBetweenDates2(n1.startOfDay, n1.endOfDay))
//    
//        return entities
//    }
//    
//    func divideCategory() -> [[MyBudget]] {
//        let entities = get123()
//        
//        let incomePlan = entities.filter { entity in
//            entity.statement == true
//        }
//        
//        let expensePlan = entities.filter { entity in
//            entity.statement == false
//        }
//        
//        return [incomePlan, expensePlan]
//    }
//    
//    
//    
//    
//    /*
//     MyBudget 에 예산안이 여러개가 있을것인데
//     그중에서 특정 날짜에 대한 데이터를 가져온후에 가져온것에서 상태값에 따라 Footer에 대입을 해주고
//     데이터를 지우고 삭제하는 로직을 하고있는거네 ? 업데이트가 아니라 지우고 재설정
//     간단하게 일자 -> 호출 -> 분리 -> 노출 -> 저장
//     
//     데이터 구성
//     현재는 두가지로 만 진행되고있음
//     화면 진입 -> 데이터 호출 어떤? Budget 데이터
//     호출 과 덮어쓰기
//     
//     
//     
//     */
//    //MyBudget 불러오기
//
//    
//    func updateMyBudets() {
//        
//    }
//    
//    // 텍스트 필드에 있는값 다 가져오는 메서드
//    private func getBudgetItems() -> [MyBudget]? {
//        
//        var budgetItems: [MyBudget] = []
//        
//        for section in 0..<budgetList.count {
//            if section != 1 {
//                for row in 0..<budgetList[section].items.count {
//                    let indexPath = IndexPath(row: row, section: section)
//                    if let cell = moneyDiaryBudgetEditView.tableView.cellForRow(at: indexPath) as? MoneyDiaryBudgetEditCell {
//                        guard let category = cell.categoryTextField.text, category != "" else {
//                            return nil
//                        }
//                        
//                        let amountText = cell.amountTextField.text ?? ""
//                        let amount = KoreanCurrencyFormatter.shared.number(from: amountText) ?? 0
//                        
//                        let item = budgetList[section].items[row]
//                        let budgetItem = MyBudget()
//                        budgetItem.amount = amount
//                        budgetItem.statement = item.statement
//                        budgetItem.category = category
//                        budgetItem.date = currentDate!
//                        
//                        
//                        budgetItems.append(budgetItem)
//                    }
//                }
//            }
//        }
//        
//        return budgetItems
//    }
//    
//
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    func calculateSavings(startDate: Date?, endDate: Date?, amount: Int64) -> [String: Int64] {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        guard let start = startDate,
//              let end = endDate else {
//            return [:]
//        }
//        let calendar = Calendar.current
//        let totalDays = calendar.dateComponents([.day], from: start, to: end).day! + 1
//        let dailyAmount = Double(amount) / Double(totalDays)
//        var monthlySavings: [String: Double] = [:]
//        var currentDate = start
//        while currentDate <= end {
//            let monthKey = dateFormatter.string(from: currentDate).prefix(7)
//            monthlySavings[String(monthKey), default: 0] += dailyAmount
//            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
//        }
//        return monthlySavings.mapValues { Int64(round($0)) }
//    }
//    
//    // MARK: - Objc
//    @objc private func deleteButtonTapped(_ sender: UIButton) {
//        let section = sender.tag / 1000
//        let row = sender.tag % 1000
//        
//        guard section < budgetList.count, row < budgetList[section].items.count else {
//            print("잘못된 인덱스 접근: section \(section), row \(row)")
//            return
//        }
//        
//        budgetList[section].items.remove(at: row)
//
//        moneyDiaryBudgetEditView.tableView.deleteRows(at: [IndexPath(row: row, section: section)], with: .automatic)
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//            self.moneyDiaryBudgetEditView.tableView.reloadData()
//        }
//        
//        setTotalAmountView()
//    }
//    
//    @objc private func saveButtonTapped() {
//        
//        
//        
//        let budgetItems = getBudgetItems()
//        
//        guard let budgetItems = budgetItems else {
//            showAlert(message: "빈 값을 입력할 수 없습니다.", AlertTitle: "알림", buttonClickTitle: "확인")
//            return
//        }
//        // 이부분이 저장
//
//        let n1 = dateManager.calculateStartAndEndOfDay(for: currentDate!)
//        realmManager.deleteBetweenDates(n1.startOfDay, n1.endOfDay)
//        
//        //어디에 있는걸 가져올것인지?
//        for i in budgetItems {
//            RealmManager.shared.update(i)
//        }
//        
//        
//        
//        
//        
//        
////        budgetCoreDataManager.saveBudget(budgetList: budgetItems)
//        
//        showSyncAlert(message: "저장이 완료 되었습니다.", AlertTitle: "저장 성공", buttonClickTitle: "확인") { [weak self] in
//            guard let self = self else { return }
//            self.navigationController?.popViewController(animated: true)
//        }
//    }
//    
//    @objc private func doneTapped() {
//        moneyDiaryBudgetEditView.endEditing(true)
//    }
//}
//
//// MARK: - UITableViewDataSource
//extension MoneyDiaryBudgetEditVC: UITableViewDataSource {
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return budgetList.count
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 1 {
//            return budgetList[section].items.count
//        }
//        return budgetList[section].items.count + 1
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let list = budgetList[indexPath.section]
//        
//        if indexPath.row < list.items.count {
//            let item = list.items[indexPath.row]
//            let amount = KoreanCurrencyFormatter.shared.string(from: item.amount)
//            
//            if indexPath.section == 1 {
//                let cell = tableView.dequeueReusableCell(withIdentifier: "AssetPlanCell", for: indexPath)
//                cell.textLabel?.text = "\(item.category): \(amount) 원"
//                cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
//                cell.textLabel?.textColor = .black
//                return cell
//            } else {
//                let cell = tableView.dequeueReusableCell(withIdentifier: "MoneyDiaryBudgetEditCell", for: indexPath) as! MoneyDiaryBudgetEditCell
//                let toolbar = UIToolbar()
//                toolbar.sizeToFit()
//                toolbar.items = [
//                    UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),  // 빈 공간
//                    UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(doneTapped))
//                ]
//                cell.categoryTextField.text = item.category
//                cell.amountTextField.text = "\(amount)"
//                
//                cell.categoryTextField.delegate = self
//                cell.amountTextField.delegate = self
//                cell.categoryTextField.inputAccessoryView = toolbar
//                cell.amountTextField.inputAccessoryView = toolbar
//                
//                cell.categoryTextField.tag = indexPath.section * 1000 + indexPath.row
//                cell.amountTextField.tag = indexPath.section * 1000 + indexPath.row + 100
//                
//                cell.deleteButton.tag = indexPath.section * 1000 + indexPath.row
//                cell.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
//                
//                return cell
//            }
//        } else {
//            let addCell = UITableViewCell(style: .default, reuseIdentifier: "addCell")
//            addCell.textLabel?.text = "항목 추가하기"
//            addCell.textLabel?.textColor = .systemBlue
//            addCell.textLabel?.textAlignment = .center
//            return addCell
//        }
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        
//        if indexPath.row == budgetList[indexPath.section].items.count {
//            addNewItem(toSection: indexPath.section)
//        }
//    }
//}
//
//// MARK: - UITableViewDelegate
//extension MoneyDiaryBudgetEditVC: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MoneyDiaryBudgetEditHeaderView") as? BudgetHeaderView else {
//            return UITableViewHeaderFooterView()
//        }
//        
//        headerView.titleLabel.text = "\(budgetList[section].title)"
//        headerView.amountLabel.text = "\(setSectionAmount(forSection: section))"
//        //헤더뷰의 백그라운드 컬러
//        switch section {
//        case 0:
//            headerView.backgroundView?.backgroundColor = UIColor(hex: "#3FB6DC")
//        case 1:
//            headerView.backgroundView?.backgroundColor = UIColor(hex: "#2DC76D")
//        case 2:
//            headerView.backgroundView?.backgroundColor = UIColor(hex: "#FF7052")
//        default:
//            headerView.backgroundView?.backgroundColor = .lightGray
//        }
//        
//        return headerView
//    }
//    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 40
//    }
//}
//
//extension MoneyDiaryBudgetEditVC: UITextFieldDelegate {
//
//    // 입력이 끝났을 때 호출되는 메서드
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        let section = textField.tag / 1000
//        let row = textField.tag % 1000
//        
//        if row < 100 {
//            // 카테고리 입력
//            budgetList[section].items[row].category = textField.text ?? ""
//        } else {
//            // 금액 입력
//            updateAmount(for: section, row: row, text: textField.text)
//        }
//        
//        // 총 합계 텍스트만 업데이트
//        updateSectionHeader(forSection: section)
//    }
//    
//    private func updateSectionHeader(forSection section: Int) {
//        // 헤더 뷰의 레이블 텍스트를 직접 업데이트
//        guard let headerView = moneyDiaryBudgetEditView.tableView.headerView(forSection: section) as? BudgetHeaderView else {
//            return
//        }
//        
//        // 섹션의 총 합계 업데이트
//        headerView.amountLabel.text = "\(setSectionAmount(forSection: section))"
//        // 전체 총합계 업데이트
//        moneyDiaryBudgetEditView.totalView.amountLabel.text = "\(setTotalAmount())"
//    }
//    
//    // 텍스트 필드의 내용이 변경될 때 호출되는 메서드
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        guard textField.tag % 1000 >= 100 else { return true } // amountTextField만 처리
//        
//        if !isValidAmountInput(string) {
//            return false
//        }
//        
//        // 현재 텍스트와 새로운 텍스트를 조합
//        let currentText = textField.text ?? ""
//        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
//        
//        // 콤마 제거 후 숫자 포맷 적용
//        let formattedText = formatNumberWithComma(newText)
//        textField.text = formattedText
//        
//        return false
//    }
//
//    // 숫자에 콤마를 추가하는 함수
//    private func formatNumberWithComma(_ number: String) -> String {
//        let numberString = number.replacingOccurrences(of: ",", with: "")
//        guard let numberValue = Int(numberString) else { return number }
//        let numberFormatter = NumberFormatter()
//        numberFormatter.numberStyle = .decimal
//        return numberFormatter.string(from: NSNumber(value: numberValue)) ?? number
//    }
//    
//    // Return 버튼을 눌렀을 때 호출되는 메서드
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        let section = textField.tag / 1000
//        let row = textField.tag % 1000
//        
//        if row < 100 {
//            // categoryTextField인 경우
//            moveToNextField(from: textField, section: section, row: row)
//        } else {
//            // amountTextField인 경우
//            textField.resignFirstResponder()
//        }
//        
//        return true
//    }
//    
//    // 금액 업데이트 함수
//    private func updateAmount(for section: Int, row: Int, text: String?) {
//        let amountText = text?.replacingOccurrences(of: ",", with: "") ?? "0"
//        let amount = Int64(amountText) ?? 0
//        budgetList[section].items[row - 100].amount = amount
//    }
//    
//    // 유효한 금액 입력 확인
//    private func isValidAmountInput(_ string: String) -> Bool {
//        return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string)) || string.isEmpty
//    }
//    
//    // 다음 텍스트 필드로 이동하는 함수
//    private func moveToNextField(from textField: UITextField, section: Int, row: Int) {
//        let nextIndexPath = IndexPath(row: row, section: section)
//        
//        if let nextCell = moneyDiaryBudgetEditView.tableView.cellForRow(at: nextIndexPath) as? MoneyDiaryBudgetEditCell {
//            nextCell.amountTextField.becomeFirstResponder()
//        } else {
//            let nextRowIndexPath = IndexPath(row: row + 1, section: section)
//            if let nextCell = moneyDiaryBudgetEditView.tableView.cellForRow(at: nextRowIndexPath) as? MoneyDiaryBudgetEditCell {
//                nextCell.categoryTextField.becomeFirstResponder()
//            } else {
//                textField.resignFirstResponder()
//            }
//        }
//    }
//}
