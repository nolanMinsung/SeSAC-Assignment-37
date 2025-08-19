//
//  SimpleTableViewExampleView.swift
//  SaSAC-Assignment-37
//
//  Created by 김민성 on 8/19/25.
//

import UIKit

import SnapKit

final class SimpleTableViewExampleView: UIView {
    
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView.backgroundColor = .systemBlue
        tableView.rowHeight = 80.0
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
