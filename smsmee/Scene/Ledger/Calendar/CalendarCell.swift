//
//  CalendarCell.swift
//  smsmee
//
//  Created by KimRin on 2/7/25.
//
/*여기서 그려야하는것들이
 이번주인지 아닌지, 토요일 인지 아닌지 일요일 인지 아닌지,
 토달금액만 받아서 주면됨
 */


import UIKit
import SnapKit

final class CalendarCell: UICollectionViewCell, CellReusable {
    
    var todayItem: CalendarItem?
    let dayLabel = UIFactory.makeLabel(title: "1", textSize: 18)
    
    let incomeLabel = UIFactory.makeLabel(title: "10000", textColor: .systemBlue, textSize: 18)
    let expenseLabel = UIFactory.makeLabel(title: "5000", textColor: .pastelRed, textSize: 18)
    private let totalAmountLabel = UIFactory.makeLabel(title: "5000", textSize: 18)
    
    private lazy var moneyStackView = {
        let stackView = UIStackView(arrangedSubviews:
                                        [self.incomeLabel,
                                         self.expenseLabel,
                                         self.totalAmountLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        stackView.alignment = .center
        return stackView
    }()
    
    //frame .zero?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 0.2
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 0.2
        self.backgroundColor = .white
    }
    
    func updateDate(with item: CalendarItem) {
        
        self.todayItem = item
//        isThisMonth(today: item)
//        isToday(currentDay: item.date)
        dayLabel.text = dateStringFormatter(date: item.date)

        //여기에서. 섹션 검사를 해야할듯
        if item.date < Date() {
            
           
             if isSameWeekAsToday(date: item.date) {
                 self.backgroundColor = .white
            }
            else {
                self.backgroundColor = item.backgroundColor
            }
        }
        
//        let temp = RealmManager.shared.fetchDiaryBetweenDates()
//        
//        
//        let (income, expense) = temp.reduce((0, 0)) { accumulator, i in
//            i.statement ? (accumulator.0 + Int(i.amount), accumulator.1) : (accumulator.0, accumulator.1 + Int(i.amount)) }
//        
//        let totalAmount = income - expense
//        if item.isThisMonth {
//            self.expenseLabel.text = expense == 0 ? "" : "\(expense)"
//            self.incomeLabel.text = income == 0 ? "" : "\(income)"
//            self.totalAmountLabel.text = totalAmount == 0 ? "" : "\(totalAmount)"
//        }
        
    }
    
    
    private func dateStringFormatter(date: Date) -> String {
        let today = DateFormatter.onlyday.string(from: date)
        let dayString = RegexManager.shared.removeLeadingZeros(from: today)
        let month = String(Calendar.current.component(.month, from: date))
        
        return dayString == "1" ? "\(month).\(dayString)" : dayString
        
    }
    

    
    

    
    

    

    
    
}
//MARK: - Render
extension CalendarCell {
    private func setupUI() {
        dayLabel.font = .boldSystemFont(ofSize: 12)
        [
            dayLabel,
            moneyStackView
        ].forEach { self.addSubview($0) }
        [
            incomeLabel,
            expenseLabel,
            totalAmountLabel
            
        ].forEach {
            $0.textAlignment = .center
            $0.numberOfLines = 1
            $0.font = .systemFont(ofSize: 15)
            $0.adjustsFontSizeToFitWidth = true
            $0.minimumScaleFactor = 0.6
        }
        dayLabel.snp.makeConstraints {
            $0.leading.equalTo(self.snp.leading).offset(3)
            $0.top.equalTo(self.snp.top).offset(3)
        }
        moneyStackView.snp.makeConstraints {
            $0.bottom.equalTo(self.snp.bottom).inset(2)
            $0.centerX.equalTo(self.snp.centerX)
            $0.height.equalTo(30)
        }

    }

}

//MARK: - Calculation

extension CalendarCell {
    func isSameWeekAsToday(date: Date) -> Bool {
        guard let todayWeekRange = Calendar.current.dateInterval(of: .weekOfYear, for: Date()),
              let dateWeekRange = Calendar.current.dateInterval(of: .weekOfYear, for: date) else {
            return false
        }
        
        // 두 날짜가 같은 주에 속하는지 비교
        return todayWeekRange == dateWeekRange
    }
    
//    private func isThisMonth(today: CalendarItem) {
//        let weekday = DateManager.shared.getWeekday(month: today.date)
//        
//        switch weekday {
//        case 1:
//            self.dayLabel.textColor = .systemRed
//        case 7:
//            
//            self.dayLabel.textColor = .systemBlue
//        default:
//            self.dayLabel.textColor = .black
//        }
//        
//        if today.isThisMonth != true {
//            dayLabel.textColor = self.dayLabel.textColor.withAlphaComponent(0.4)
//            incomeLabel.text = ""
//            expenseLabel.text = ""
//            totalAmountLabel.text = ""
//            }
//        
//
//    }
    
//    private func isToday(currentDay: Date) {
//        let today = DateManager.shared.transformDateWithoutTime(date: Date())
//        if currentDay == today {
//            self.layer.borderColor = UIColor.red.cgColor
//            self.layer.borderWidth = 0.5
//        }
//        else {
//            self.layer.borderColor = UIColor.gray.cgColor
//            self.layer.borderWidth = 0.2
//        }
//    }
}
