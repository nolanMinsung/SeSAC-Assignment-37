//
//  SimpleValidationViewModel.swift
//  SeSAC-Assignment-39
//
//  Created by 김민성 on 8/21/25.
//

import RxSwift
import RxCocoa

final class SimpleValidationViewModel {
    
    struct Input {
        let userNameInput: ControlProperty<String>
        let passwordInput: ControlProperty<String>
        let completeButtonTapInput: ControlEvent<Void>
    }
    
    struct Output {
        let usernameValidationResult: BehaviorRelay<Bool>
        let passwordValidationResult: BehaviorRelay<Bool>
        let completeButtonEnable: BehaviorRelay<Bool>
        let completeButtonTapOutput: PublishRelay<Void>
    }
    
    private let disposeBag = DisposeBag()
    
    init() {
        
    }
    
    func transform(input: Input) -> Output {
        
        let usernameValidationResult = BehaviorRelay<Bool>(value: false)
        let passwordValidationResult = BehaviorRelay<Bool>(value: false)
        let completeButtonEnable = BehaviorRelay<Bool>(value: false)
        let completeButtonTapOutput = PublishRelay<Void>()
        
        let usernameValidation = input.userNameInput
            .map { $0.count >= 5 }
            .share(replay: 1)
        
        let passwordValidation = input.passwordInput
            .map { $0.count >= 5 }
            .share(replay: 1)
        
        let completeButtonTapped = input.completeButtonTapInput
        
        usernameValidation.bind(to: usernameValidationResult).disposed(by: disposeBag)
        passwordValidation.bind(to: passwordValidationResult).disposed(by: disposeBag)
        completeButtonTapped.bind(to: completeButtonTapOutput).disposed(by: disposeBag)
        
        Observable.combineLatest(
            usernameValidation,
            passwordValidation
        )
        .map { $0.0 && $0.1 }
        .bind(to: completeButtonEnable)
        .disposed(by: disposeBag)
        
        return Output(
            usernameValidationResult: usernameValidationResult,
            passwordValidationResult: passwordValidationResult,
            completeButtonEnable: completeButtonEnable,
            completeButtonTapOutput: completeButtonTapOutput
        )
    }
    
}
