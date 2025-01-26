//
//  Enum+.swift
//  smsmee
//
//  Created by KimRin on 1/26/25.
//

import Foundation

//MARK: - 문자에서 날짜,시간, 내용등의 데이터를 추출하기위한 패턴
enum TextPattern: String {
    
    case date = "\\d{2}/\\d{2}"
    case time = "\\d{2}:\\d{2}"
    case amount = "\\d{1,3}(,\\d{3})*원"
    case content = "\\b[\\w가-힣]+\\b"
}


