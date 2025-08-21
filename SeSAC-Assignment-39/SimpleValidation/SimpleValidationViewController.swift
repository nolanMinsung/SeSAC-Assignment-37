//
//  SimpleValidationViewController.swift
//  SaSAC-Assignment-37
//
//  Created by 김민성 on 8/19/25.
//

import UIKit

import RxSwift
import RxCocoa

class SimpleValidationViewController: UIViewController {
    
    private let rootView = SimpleValidationView()
    private let viewModel = SimpleValidationViewModel()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let input = SimpleValidationViewModel.Input(
            userNameInput: rootView.userNameInputTextField.rx.text.orEmpty,
            passwordInput: rootView.passwordInputTextField.rx.text.orEmpty,
            completeButtonTapInput: rootView.completeButton.rx.tap
        )
        
        let output = viewModel.transform(input: input)
        
        output.usernameValidationResult
            .map { $0 ? 0.0 : 1.0 }
            .bind(to: rootView.usernameValidationLabel.rx.alpha)
            .disposed(by: disposeBag)
        
        output.passwordValidationResult
            .map { $0 ? 0.0 : 1.0 }
            .bind(to: rootView.passwordValidationLabel.rx.alpha)
            .disposed(by: disposeBag)
        
        output.completeButtonEnable
            .bind(to: rootView.completeButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.completeButtonTapOutput
            .bind(
                with: self,
                onNext: { owner, _ in
                    owner.showCompleteAlert()
                }
            )
            .disposed(by: disposeBag)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        view.endEditing(true)
    }
    
    private func showCompleteAlert() {
        let alertCon = UIAlertController(title: "Username, Password 모두 유효합니다.", message: "This is wonderful.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "확인", style: .cancel)
        alertCon.addAction(cancelAction)
        present(alertCon, animated: true)
    }
    
}
