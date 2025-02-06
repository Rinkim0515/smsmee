//
//  MessageReader.swift
//  smsmee
//
//  Created by KimRin on 2/1/25.
//

import UIKit

import SnapKit
import RxSwift

final class MessageReaderVC: UIViewController, ViewModelBindable {
    typealias VM = MessageReaderVM
    typealias Intent = MessageReaderIntent
    typealias State = MessageReaderState
    
    let viewModel: MessageReaderVM
    
    let disposeBag = DisposeBag()
    
    private let messageReaderView = MessageReaderView()
    
    init(viewModel: MessageReaderVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        view.addSubview(messageReaderView)
        messageReaderView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        messageReaderView.submitButton.addAction(UIAction(handler: { [weak self] _ in
            self?.saveData()
        }), for: .touchUpInside)
    }

    private func saveData() {
        if let text = messageReaderView.inputTextView.text {
            viewModel.intentRelay.accept(.saveText(text)) // Intent 전달
        }
    }
    
    func render(state: MessageReaderState) {
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

    private func showAlert(title: String, message: String, handler: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            handler?()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}
