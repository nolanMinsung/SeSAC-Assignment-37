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
    
    let tableViewItems = Observable.just(["NumbersExample", "SimpleValidationExample"] + [2, 3, 4, 5, 6, 7, 8, 9, 10].map({ "\($0)" }))
    
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
                    if cellString == "NumbersExample" {
                        let orangeVC = UIViewController()
                        orangeVC.view.backgroundColor = .systemOrange
                        owner.navigationController?.pushViewController(orangeVC, animated: true)
                    }
                }
            ).disposed(by: disposeBag)
    }
    
}
