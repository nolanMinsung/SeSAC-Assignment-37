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
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Observable.combineLatest(
            rootView.numberTextField1.rx.text.orEmpty,
            rootView.numberTextField2.rx.text.orEmpty,
            rootView.numberTextField3.rx.text.orEmpty,
        ).map { text1, text2, text3 in
            let num1 = Int(text1) ?? 0
            let num2 = Int(text2) ?? 0
            let num3 = Int(text3) ?? 0
            return (num1 + num2 + num3).description
        }
        .bind(to: rootView.resultNumberLabel.rx.text)
        .disposed(by: disposeBag)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        view.endEditing(true)
    }
    
}
