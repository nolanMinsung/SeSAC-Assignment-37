//
//  SimpleTableViewExampleViewController.swift
//  SaSAC-Assignment-37
//
//  Created by 김민성 on 8/19/25.
//

import UIKit

import RxSwift
import RxCocoa

class SimpleTableViewExampleViewController: UIViewController {
    
    let rootView = SimpleTableViewExampleView()
    
    let tableViewItems = Observable.just(["NumbersExample으로 가기", "SimpleValidationExample으로 가기"] + [2, 3, 4, 5, 6, 7, 8, 9, 10].map({ "\($0)" }))
    
    let disposeBag = DisposeBag()
    
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView.tableView.register(
            SimpleTableViewExampleCell.self,
            forCellReuseIdentifier: SimpleTableViewExampleCell.identifier
        )
        
        tableViewItems.bind(
            to: rootView.tableView.rx.items,
            curriedArgument: { [weak self] tableView, row, element in
                guard let cell = self?.rootView.tableView.dequeueReusableCell(
                    withIdentifier: SimpleTableViewExampleCell.identifier
                ) as? SimpleTableViewExampleCell else {
                    fatalError()
                }
                cell.titleLabel.text = element
                return cell
            }
        ).disposed(by: disposeBag)
        
        rootView.tableView.rx.modelSelected(String.self)
            .bind(
                with: self,
                onNext: { owner, cellString in
                    // 하드코딩이라 좋지는 않다. 개선이 필요한 부분.
                    if cellString == "NumbersExample으로 가기" {
                        owner.navigationController?.pushViewController(NumbersViewController(), animated: true)
                    } else if cellString == "SimpleValidationExample으로 가기" {
                        owner.navigationController?.pushViewController(SimpleValidationViewController(), animated: true)
                    }
                }
            ).disposed(by: disposeBag)
    }
    
}
