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
    private let dateManager = DateManager.shared
    var todayItem: CalendarItem?
    let dayLabel = UIFactory.label(title: "1", textSize: 18)
    
    let incomeLabel = UIFactory.label(title: "10000", textSize: 18, textColor: .systemBlue)
    let expenseLabel = UIFactory.label(title: "5000", textSize: 18, textColor: .pastelRed)
    private let totalAmountLabel = UIFactory.label(title: "5000", textSize: 18)
    
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
        let dayString = dateStringFormatter(date: item.date)
        self.dayLabel.text = dayString
        if !item.isThisMonth {
            validation()
        } else {
            switch item.dayType {
            case .Saturday:
                self.dayLabel.textColor = .primaryBlue
            case .Sunday:
                self.dayLabel.textColor = .systemRed
            default:
                self.dayLabel.textColor = .black
            }
            
            self.incomeLabel.text = item.totalIncome == 0 ? "" : "\(item.totalIncome)"
            self.expenseLabel.text =  item.totalExpense == 0 ? "" : "\(item.totalExpense)"
            self.totalAmountLabel.text =  item.totalAmount == 0 ? "" : "\(item.totalAmount)"
            
        }


        
    }
    
    func validation() {
        dayLabel.textColor = self.dayLabel.textColor.withAlphaComponent(0.4)
        incomeLabel.text = ""
        expenseLabel.text = ""
        totalAmountLabel.text = ""
    }
    
    //어떻게 나눌것이냐. -> 다 통일해서 화면을 그릴때 다 호출하는ㅈ 방향으로 진행하자

    
    
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
    
    // 당일 날짜 표시 기능
        private func isToday(currentDay: Date) {
            let today = dateManager.transformDateWithoutTime(date: Date())
            if currentDay == today {
                self.layer.borderColor = UIColor.red.cgColor
                self.layer.borderWidth = 0.5
            }
            else {
                self.layer.borderColor = UIColor.gray.cgColor
                self.layer.borderWidth = 0.2
            }
        }
}
