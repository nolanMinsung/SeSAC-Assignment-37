//
//  NumbersViewController.swift
//  SaSAC-Assignment-37
//
//  Created by 김민성 on 8/19/25.
//

import UIKit

import RxSwift
import RxCocoa

class NumbersViewController: UIViewController {
    
    private let rootView = NumbersView()
    private let viewModel = NumbersViewModel()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        view.endEditing(true)
    }
    
    private func bind() {
        
        let input = NumbersViewModel.Input(
            textField1Input: rootView.numberTextField1.rx.text.orEmpty,
            textField2Input: rootView.numberTextField2.rx.text.orEmpty,
            textField3Input: rootView.numberTextField3.rx.text.orEmpty,
        )
        
        let output = viewModel.transform(input: input)
        
        output.resultTextOutput
            .bind(to: rootView.resultNumberLabel.rx.text)
            .disposed(by: disposeBag)
        
    }
    
}
