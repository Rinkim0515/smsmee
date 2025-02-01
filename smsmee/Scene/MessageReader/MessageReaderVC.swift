//
//  MessageReader.swift
//  smsmee
//
//  Created by KimRin on 2/1/25.
//

import UIKit

import SnapKit
import RxSwift

class MesaageReaderVC: BaseViewController<MessageReaderVM, MessageReaderIntent, MessageReaderState> {
    
    private let messageReaderView = MessageReaderView()
    override func viewDidLoad() {
        setupUI()
        saveData()
    }
    
    override func setupUI() {
        view.addSubview(messageReaderView)
        messageReaderView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        messageReaderView.submitButton.addAction(UIAction(handler: { [weak self] _ in
            self?.saveData()
        }), for: .touchUpInside)
    }
    
    func saveData() {
         if let text = messageReaderView.inputTextView.text {
             viewModel.intentSubject.onNext(.saveText(text)) // Intent 전달
         }
     }
    
    override func render(state: MessageReaderState) {
        switch state {
        case .idle:
            break
        case .success(let message):
            showAlert(title: "저장 성공", message: message) {
                self.navigationController?.popViewController(animated: true)
            }
        case .failure(let message):
            showAlert(title: "저장 실패", message: message)
        }
    }
    
    func showAlert(title: String, message: String, handler: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.dismiss(animated: true)
            
        }
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    
}
