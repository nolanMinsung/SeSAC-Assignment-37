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
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let usernameValidation = rootView.userNameInputTextField.rx.text.orEmpty
            .map { $0.count >= 5 }
            .share(replay: 1)
        
        let passwordValidation = rootView.passwordInputTextField.rx.text.orEmpty
            .map { $0.count >= 5 }
            .share(replay: 1)
        
        usernameValidation
            .map { $0 ? 0.0 : 1.0 }
            .bind(to: rootView.usernameValidationLabel.rx.alpha)
            .disposed(by: disposeBag)
        
        passwordValidation
            .map { $0 ? 0.0 : 1.0 }
            .bind(to: rootView.passwordValidationLabel.rx.alpha)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(
            usernameValidation,
            passwordValidation
        )
        .map { $0.0 && $0.1 }
        .bind(to: rootView.completeButton.rx.isEnabled)
        .disposed(by: disposeBag)
        
        
        
        // 한 개의 스트림만 가져가고자 한다면 다음과 같은 방법으로도 가능할 듯.
        // 근데 alpha 값 등을 조절하는 데에는 bind 코드가 더 깔끔하다고 생각되긴 함.
        
//        Observable.combineLatest(
//            rootView.userNameInputTextField.rx.text.orEmpty,
//            rootView.passwordInputTextField.rx.text.orEmpty
//        )
//        .map { ($0.count >= 5, $1.count >= 5) }
//        .do { [weak self] isUsernameValidLength, isValidPasswordLenth in
//            self?.rootView.usernameValidationLabel.alpha = isUsernameValidLength ? 0 : 1
//            self?.rootView.passwordValidationLabel.alpha = isValidPasswordLenth ? 0 : 1
//        }
//        .map { $0 && $1 }
//        .bind(to: rootView.completeButton.rx.isEnabled)
//        .disposed(by: disposeBag)
        
        rootView.completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        view.endEditing(true)
    }
    
    @objc private func completeButtonTapped() {
        let alertCon = UIAlertController(title: "Username, Password 모두 유효합니다.", message: "This is wonderful.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "확인", style: .cancel)
        alertCon.addAction(cancelAction)
        present(alertCon, animated: true)
    }
    
}
