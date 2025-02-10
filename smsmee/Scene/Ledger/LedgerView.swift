//
//  LedgerView.swift
//  smsmee
//
//  Created by KimRin on 1/26/25.
//

import DGCharts
import SnapKit
import UIKit

class LedgerView: UIView {
    lazy var calendarView = CalendarView()
    lazy var chartView: PieChartView = {
        let chartView = PieChartView()
        chartView.noDataText = "작성된 내역이 없습니다."
        chartView.isHidden = true
        chartView.highlightPerTapEnabled = false
        return chartView
    }()
    
    var dateButton: UIButton = {
        let button = UIButton()
        button.setTitle("2024년", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        return button
    }()
//    UIFactory.makeButton(title: "", bgColor: .clear)
//    ButtonFactory.clearButton()
//        .setFont(.boldSystemFont(ofSize: 22))
//        .setBorderColor(.clear)
//        .build()

    let previousButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
//        button.tintColor = .black
//        button.backgroundColor = .white
//        button.layer.cornerRadius = 5
//        button.layer.borderWidth = 1
//        button.layer.borderColor = UIColor.black.cgColor
        
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "chevron.left")
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 10, weight: .bold) // ✅ 아이콘 크기 설정
        config.imagePadding = 10 // ✅ 이미지와 버튼 경계 사이 간격
        config.imagePlacement = .leading // ✅ 이미지 위치 설정
        
        let button = UIButton(configuration: config)
        button.tintColor = .black // ✅ 아이콘 색상
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        
        return button
        
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .black
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        return button
    } ()
    
    let todayButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("오늘", for: .normal)
        button.tintColor = .black
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()

    
    let segmentController = {
        let segmentController = UISegmentedControl(items: ["캘린더", "소비내역 차트"])
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 16)
        ]
        segmentController.setTitleTextAttributes(attributes, for: .normal)
        segmentController.selectedSegmentIndex = 0
        segmentController.backgroundColor = .primaryBlue.withAlphaComponent(0.6)
        segmentController.selectedSegmentTintColor = .primaryBlue
        segmentController.layer.borderColor = UIColor(.clear).cgColor
        segmentController.layer.cornerRadius = 0
        return segmentController
    }()
    
    
    
    lazy var floatingButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "pencilButton"), for: .normal)
        return button
    }()
    
    let pencilButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.image = UIImage(systemName: "pencil")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .medium))
        button.configuration = config
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.3
        button.alpha = 0.0
        return button
    }()
    
    let quickMessageButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.image = UIImage(systemName: "text.append")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .medium))
        button.configuration = config
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.3
        button.alpha = 0.0
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureWeekLabel()
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureWeekLabel() {
        calendarView.weekStackView.distribution = .fillEqually
        let dayOfTheWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        
        for i in 0...6 {
            let label = UILabel()
            label.text = dayOfTheWeek[i]
            switch label.text {
            case "Sat": label.backgroundColor = .systemBlue
            case "Sun": label.backgroundColor = .systemRed
            default: label.backgroundColor = .black.withAlphaComponent(0.8)
            }
            
            label.layer.borderColor = UIColor.white.cgColor
            label.layer.borderWidth = 0.5
            label.textColor = .white
            label.font = .systemFont(ofSize: 13, weight: .bold)
            label.textAlignment = .center
            calendarView.weekStackView.addArrangedSubview(label)
        }
    }
    
    func addActionToPencilButton(_ action: UIAction) {
        pencilButton.addAction(action, for: .touchUpInside)
    }
    
    private func configureUI() {
        
        [
            dateButton,
            previousButton,
            todayButton,
            nextButton,
            calendarView,
            chartView,
            segmentController,
            floatingButton,
            pencilButton,
            quickMessageButton,
//            moveBudgetButton
            
        ].forEach { self.addSubview($0) }
        
        
        self.dateButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.height.equalTo(50)
            make.leading.equalTo(self.snp.leading).offset(20)
        }
        previousButton.snp.makeConstraints { make in
            make.trailing.equalTo(todayButton.snp.leading).offset(-10)
            make.centerY.equalTo(dateButton.snp.centerY)
            make.width.height.equalTo(15)
            
        }
        

        
        self.nextButton.snp.makeConstraints {
            $0.trailing.equalTo(self.snp.trailing).offset(-20)
            $0.centerY.equalTo(dateButton.snp.centerY)
            $0.width.height.equalTo(15)
            
        }
        
        todayButton.snp.makeConstraints { make in
            make.trailing.equalTo(nextButton.snp.leading).offset(-10)
            make.centerY.equalTo(dateButton.snp.centerY)
            make.width.equalTo(50)
            make.height.equalTo(15)
        }
        self.segmentController.snp.makeConstraints {
            $0.top.equalTo(dateButton.snp.bottom).offset(25)
            $0.height.equalTo(30)
            $0.leading.trailing.equalToSuperview()
        }
        
        self.calendarView.snp.makeConstraints {
            $0.top.equalTo(self.segmentController.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(self.snp.horizontalEdges)
            $0.bottom.equalTo(self.snp.bottom)
        }
        self.chartView.snp.makeConstraints {
            $0.top.equalTo(self.segmentController.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(self.snp.horizontalEdges)
            $0.bottom.equalTo(self.snp.bottom)
        }
        
        floatingButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(40)
            $0.width.height.equalTo(60)
        }
        
        pencilButton.snp.makeConstraints {
            $0.centerX.equalTo(floatingButton.snp.centerX)
            $0.bottom.equalTo(floatingButton.snp.top).offset(-15)
            $0.width.height.equalTo(40)
        }
        
        quickMessageButton.snp.makeConstraints {
            $0.centerX.equalTo(floatingButton.snp.centerX)
            $0.bottom.equalTo(pencilButton.snp.top).offset(-15)
            $0.width.height.equalTo(40)
        }
        
    }
    
    
    func popButtons(isActive: Bool) {
        if isActive {
            pencilButton.layer.transform = CATransform3DMakeScale(0.4, 0.4, 1)
            UIView.animate(withDuration: 0.3, delay: 0.2, usingSpringWithDamping: 0.55, initialSpringVelocity: 0.3, options: [.curveEaseInOut], animations: { [weak self] in
                guard let self = self else { return }
                pencilButton.layer.transform = CATransform3DIdentity
                pencilButton.alpha = 1.0
                
            })
            quickMessageButton.layer.transform = CATransform3DMakeScale(0.4, 0.4, 1)
            UIView.animate(withDuration: 0.3, delay: 0.2, usingSpringWithDamping: 0.55, initialSpringVelocity: 0.3, options: [.curveEaseInOut], animations: { [weak self] in
                guard let self = self else { return }
                quickMessageButton.layer.transform = CATransform3DIdentity
                quickMessageButton.alpha = 1.0
                
            })
        } else {
            UIView.animate(withDuration: 0.15, delay: 0.2, options: []) { [weak self] in
                guard let self = self else { return }
                pencilButton.layer.transform = CATransform3DMakeScale(0.4, 0.4, 0.1)
                pencilButton.alpha = 0.0
                
                quickMessageButton.layer.transform = CATransform3DMakeScale(0.4, 0.4, 0.1)
                quickMessageButton.alpha = 0.0
                
                
            }
        }
    }
    
    
    
}

