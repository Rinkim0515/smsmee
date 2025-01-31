//
//  DateFormatter.swift
//  smsmee
//
//  Created by KimRin on 2/1/25.
//

import Foundation

//MARK: - 연 월 일
extension DateFormatter {
    static let yearToHour: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter
    }()
    static let yearToDay: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    static let yearToMonth: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM"
        return formatter
    }()
}

//MARK: - 연 혹은 일
extension DateFormatter {
    static let onlyYear: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    static let onlyday: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter
    }()
}
    
//MARK: - 한국 연월
extension DateFormatter {
    static let yearToMonthKR: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 "
        return formatter
    }()
    static let yearToDayKR: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 "
        return formatter
    }()
    static let hourToMinuteKr: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH시 mm분"
        return formatter
    }()
    
}
