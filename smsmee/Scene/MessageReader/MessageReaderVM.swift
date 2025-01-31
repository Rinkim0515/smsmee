//
//  MessageReaderVM.swift
//  smsmee
//
//  Created by KimRin on 2/1/25.
//

import Foundation

class MessageReaderVM: BaseViewModel<MessageReaderIntent, MessageReaderState> {
    override func transform() {
        intentSubject
            .subscribe(onNext: { [weak self] intent in
                guard let self = self else { return }
                switch intent {
                case . saveText(let text)
                    
                }
            })
    }
    
    private func handleSave(_ text: String) {
        guard let transaction = extractPaymentDetails(from: text) else {
            updateState(.failure("입력된 정보가 올바르지 않습니다."))
            return
        }
        
        if transaction.Amount == 0 {
            updateState(.failure("100,000원 형식으로 작성해주세요."))
            return
        }
        
        saveCurrentData(item: transaction)
        let savedTimeString = DateFormatter.yearMonthDay.string(from: transaction.transactionDate)
        updateState(.success("\(savedTimeString) 날짜에 저장되었습니다!"))
    }
    
    private func extractPaymentDetails(from text: String) -> TransactionItem{
        let dateString = RegexManager.shared.extractDate(from: text)
        let timeString = RegexManager.shared.extractTime(from: text)
        let amountString = RegexManager.shared.extractAmount(from: text)
        let titleString = RegexManager.shared.extractContent(from: text)
        
        var remainingText = text
        
        if let timeRange = text.range(of: timeString) {
            remainingText = String(text[timeRange.upperBound...]).trimmingCharacters(in: .whitespacesAndNewlines)
        }
        if let amountRange = remainingText.range(of: amountString) {
            remainingText = String(remainingText[amountRange.upperBound...]).trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        let amount = RegexManager.shared.convertStringToInt(from: amountString)
        let date: Date = makeDate(date: dateString, time: timeString)
        
        
        return TransactionItem(name: titleString,
                               Amount: amount,
                               isIncom: false,
                               transactionDate: date,
                               memo: text)
    }
    
    private func makeDate(date:String, time: String?) -> Date {
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: Date())
        var selectedMonthDay = date
        let selectedTime = time ?? "11:11"
        
        selectedMonthDay.replace(at: 2, with: "-")
        
        let dateFormatter = DateFormatter.YMDHM
        dateFormatter.timeZone = TimeZone.init(secondsFromGMT: 32400)
        
        let thistime = "\(currentYear)-\(selectedMonthDay) \(selectedTime)"
        
        let savetime = dateFormatter.date(from: thistime) ?? Date()
        
        return savetime
    }
    
    func saveCurrentData(item: TransactionItem) {
        
        let date = item.transactionDate
        let amount = Int64(item.Amount)
        let statement = item.isIncom
        let titleTextField = item.name
        let categoryTextField = ""
        let memo = item.memo
        

        
        
    }
}
