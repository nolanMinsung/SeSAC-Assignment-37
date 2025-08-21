//
//  NumbersViewModel.swift
//  SeSAC-Assignment-39
//
//  Created by 김민성 on 8/21/25.
//

import RxSwift
import RxCocoa

final class NumbersViewModel {
    
    struct Input {
        let textField1Input: ControlProperty<String>
        let textField2Input: ControlProperty<String>
        let textField3Input: ControlProperty<String>
    }
    
    struct Output {
        let resultTextOutput: BehaviorRelay<String>
    }
    
    private let disposeBag = DisposeBag()
    
    init() { }
    
    
    func transform(input: Input) -> Output {
        
        let resultTextOutput = BehaviorRelay<String>(value: "")
        
        Observable.combineLatest(
            input.textField1Input,
            input.textField2Input,
            input.textField3Input,
        ).map { text1, text2, text3 in
            let num1 = Int(text1) ?? 0
            let num2 = Int(text2) ?? 0
            let num3 = Int(text3) ?? 0
            return (num1 + num2 + num3).description
        }.bind(
            onNext: { resultTextOutput.accept($0) }
        )
        .disposed(by: disposeBag)
        
        return Output(resultTextOutput: resultTextOutput)
    }
    
}
