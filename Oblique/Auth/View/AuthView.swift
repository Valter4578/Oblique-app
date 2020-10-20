//
//  AuthView.swift
//  Oblique
//
//  Created by Максим Алексеев on 17.10.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import SnapKit

class AuthView: UIView {
    
    // MARK:- Views
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "oblique")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .lightFieldGray
        textField.font = .systemFont(ofSize: 18)
        textField.textContentType = .name
        textField.borderStyle = .none
        return textField
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .lightFieldGray
        textField.font = .systemFont(ofSize: 18)
        textField.textContentType = .emailAddress
        textField.borderStyle = .none
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .lightFieldGray
        textField.font = .systemFont(ofSize: 18)
        textField.textContentType = .password
        textField.borderStyle = .none
        return textField
    }()
    
    let confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .lightFieldGray
        textField.font = .systemFont(ofSize: 18)
        textField.textContentType = .password
        textField.borderStyle = .none
        return textField
    }()
    
    lazy var fieldsStackView: UIStackView = UIStackView(arrangedSubviews: [nameTextField, emailTextField, passwordTextField, confirmPasswordTextField])
    
    let signButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
//        button.backgroundColor = .mainPurple
        return button
    }()
    
    let signOptionLabel: UILabel = {
        let label = UILabel()
        let attributedTitle = NSMutableAttributedString(string: "Already have an account? ", attributes:
            [NSAttributedString.Key.font: UIFont.systemFont(ofSize: (14)),
             NSAttributedString.Key.foregroundColor: UIColor.white])
        let attributedString = NSAttributedString(string: "Sign in", attributes: [NSAttributedString.Key.foregroundColor: UIColor.mainPurple])
        attributedTitle.append(attributedString)
        label.attributedText = attributedTitle
        return label
    }()
    
    // MARK:- Configures
    func configureViews() {
        backgroundColor = .mainBlack
        configureSignOptionLabel()
        configureSignButton()
        configureFieldsStack()
        configureImageView()
    }
    
    private func configureImageView() {
        addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.bottom.equalTo(fieldsStackView.snp.top).offset(-45)
            make.width.equalTo(175)
            make.height.equalTo(182)
        }
    }
    
    private func configureFieldsStack() {
        fieldsStackView.axis = .vertical
        fieldsStackView.distribution = .fillEqually
        fieldsStackView.spacing = 13
        
        addSubview(fieldsStackView)
        fieldsStackView.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(25)
            make.trailing.equalTo(self).offset(-25)
            //            make.top.equalTo(iconImageView.snp.bottom).offset(50)
            make.height.equalTo(230)
            make.bottom.equalTo(signButton.snp.top).offset(-40)
        }
    }
    
    private func configureSignButton() {
        signButton.layer.cornerRadius = 28
//        signButton.addGradient(colors: [.mainPurple, .accentPurple])
        
        addSubview(signButton)
        signButton.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(25)
            make.trailing.equalTo(self).offset(-25)
            make.height.equalTo(50)
            make.bottom.equalTo(signOptionLabel.snp.top).offset(-25)
        }
    }
    
    private func configureSignOptionLabel() {
        addSubview(signOptionLabel)
        signOptionLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self).offset(-50)
            make.centerX.equalTo(self)
        }
    }
    
    // MARK:- Overriden methods
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let gradientLayer = CAGradientLayer().gradientColors(colors: [.mainPurple, .accentPurple])
        gradientLayer.frame = signButton.bounds
        gradientLayer.cornerRadius = 20
        signButton.layer.insertSublayer(gradientLayer, at: 0)
        signButton.layer.cornerRadius = 20
        
        fieldsStackView.subviews.map { $0.layer.cornerRadius = 17 }
    }
}
