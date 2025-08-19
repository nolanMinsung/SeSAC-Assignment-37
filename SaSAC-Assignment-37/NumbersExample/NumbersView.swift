//
//  NumbersView.swift
//  SaSAC-Assignment-37
//
//  Created by 김민성 on 8/19/25.
//

import UIKit

import SnapKit

final class NumbersView: UIView {
    
    let numberTextField1 = UITextField()
    let numberTextField2 = UITextField()
    let numberTextField3 = UITextField()
    private let numberTextFieldStackView = UIStackView()
    private let plusOperatorLabel = UILabel()
    private let separator = UIView()
    let resultNumberLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupDesign()
        setupHierarchy()
        setupLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: - Initial Settings
private extension NumbersView {
    
    func setupDesign() {
        backgroundColor = .systemBackground
        
        [numberTextField1, numberTextField2, numberTextField3].forEach { textField in
            textField.borderStyle = .roundedRect
            textField.textAlignment = .right
            textField.keyboardType = .numberPad
        }
        
        plusOperatorLabel.text = "+"
        plusOperatorLabel.font = .systemFont(ofSize: 17, weight: .bold)
        
        separator.backgroundColor = .label
        
        resultNumberLabel.font = .systemFont(ofSize: 19, weight: .bold)
        resultNumberLabel.textAlignment = .right
        resultNumberLabel.text = "0"
    }
    
    func setupHierarchy() {
        [numberTextField1, numberTextField2, numberTextField3].forEach { textField in
            numberTextFieldStackView.addArrangedSubview(textField)
        }
        addSubview(numberTextFieldStackView)
        addSubview(plusOperatorLabel)
        addSubview(separator)
        addSubview(resultNumberLabel)
    }
    
    func setupLayoutConstraints() {
        numberTextFieldStackView.axis = .vertical
        numberTextFieldStackView.spacing = 8
        numberTextFieldStackView.alignment = .fill
        numberTextFieldStackView.distribution = .fill
        numberTextFieldStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(97)
        }
        
        plusOperatorLabel.snp.makeConstraints { make in
            make.centerY.equalTo(numberTextField3)
            make.trailing.equalTo(numberTextField3.snp.leading).offset(-8)
        }
        
        separator.snp.makeConstraints { make in
            make.top.equalTo(numberTextFieldStackView.snp.bottom).offset(8)
            make.leading.equalTo(plusOperatorLabel)
            make.trailing.equalTo(numberTextFieldStackView)
            make.height.equalTo(1)
        }
        
        resultNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(separator.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(separator)
        }
    }
    
}
