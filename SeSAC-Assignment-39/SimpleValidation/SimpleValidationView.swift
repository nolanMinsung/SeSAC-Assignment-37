//
//  SimpleValidationView.swift
//  SaSAC-Assignment-37
//
//  Created by 김민성 on 8/19/25.
//

import UIKit

import SnapKit

final class SimpleValidationView: UIView {
    
    private let userNameTitleLabel = UILabel()
    let userNameInputTextField = UITextField()
    let usernameValidationLabel = UILabel()
    private let userNameStackView = UIStackView()
    
    private let passwordTitleLabel = UILabel()
    let passwordInputTextField = UITextField()
    let passwordValidationLabel = UILabel()
    private let passwordStackView = UIStackView()
    
    let completeButton = UIButton(configuration: .filled())
    
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
private extension SimpleValidationView {
    
    func setupDesign() {
        backgroundColor = .systemBackground
        
        userNameTitleLabel.text = "Username"
        userNameInputTextField.borderStyle = .roundedRect
        usernameValidationLabel.textColor = .systemRed
        usernameValidationLabel.text = "Username has to be at least 5 characters"
        
        passwordTitleLabel.text = "Password"
        passwordInputTextField.borderStyle = .roundedRect
        passwordValidationLabel.textColor = .systemRed
        passwordValidationLabel.text = "Password has to be at least 5 characters"
        
        completeButton.configuration?.baseBackgroundColor = .systemBlue
        completeButton.configuration?.cornerStyle = .large
        completeButton.configuration?.title = "Do something"
        completeButton.configurationUpdateHandler = { button in
            button.configuration?.baseBackgroundColor = button.isEnabled ? .systemBlue : .systemGray
        }
        completeButton.isEnabled = false
    }
    
    func setupHierarchy() {
        userNameStackView.addArrangedSubview(userNameTitleLabel)
        userNameStackView.addArrangedSubview(userNameInputTextField)
        userNameStackView.addArrangedSubview(usernameValidationLabel)
        addSubview(userNameStackView)
        passwordStackView.addArrangedSubview(passwordTitleLabel)
        passwordStackView.addArrangedSubview(passwordInputTextField)
        passwordStackView.addArrangedSubview(passwordValidationLabel)
        addSubview(passwordStackView)
        addSubview(completeButton)
    }
    
    func setupLayoutConstraints() {
        [userNameStackView, passwordStackView].forEach { stackView in
            stackView.axis = .vertical
            stackView.spacing = 8
            stackView.alignment = .fill
            stackView.distribution = .fill
        }
        userNameStackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(20)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
        passwordStackView.snp.makeConstraints { make in
            make.top.equalTo(userNameStackView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
        completeButton.snp.makeConstraints { make in
            make.top.equalTo(passwordStackView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(44)
        }
    }
    
}
