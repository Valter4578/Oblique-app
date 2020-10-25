//
//  AuthViewController.swift
//  Oblique
//
//  Created by Максим Алексеев on 17.10.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import SnapKit

class AuthViewController: UIViewController {
    // MARK:- Dependencies
    
    // MARK:- Properties
    
    // MARK:- Constraints references
    var signButtonBottomConstraint: Constraint? = nil
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
        textField.textColor = .textGray
        textField.attributedPlaceholder = NSAttributedString(string: "Your name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.textGray])
        textField.textContentType = .name
        textField.borderStyle = .none
        textField.setPlaceholderPadding(10)
        return textField
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .lightFieldGray
        textField.textColor = .textGray
        //        textField.placeholder = "Your email"
        textField.attributedPlaceholder = NSAttributedString(string: "Your email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.textGray])
        textField.font = .systemFont(ofSize: 18)
        textField.textContentType = .emailAddress
        textField.borderStyle = .none
        textField.setPlaceholderPadding(10)
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .lightFieldGray
        textField.textColor = .textGray
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.textGray])
        textField.font = .systemFont(ofSize: 18)
        textField.textContentType = .password
        textField.borderStyle = .none
        textField.setPlaceholderPadding(10)
        return textField
    }()
    
    let confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .lightFieldGray
        textField.textColor = .textGray
        textField.attributedPlaceholder = NSAttributedString(string: "Confirm password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.textGray])
        textField.font = .systemFont(ofSize: 18)
        textField.textContentType = .password
        textField.borderStyle = .none
        textField.setPlaceholderPadding(10)
        return textField
    }()
    
    lazy var fieldsStackView: UIStackView = UIStackView(arrangedSubviews: [nameTextField, emailTextField, passwordTextField, confirmPasswordTextField])
    
    let signButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.addTarget(self, action: #selector(didPressSignButton), for: .touchUpInside)
        button.layer.cornerRadius = 20
        button.backgroundColor = .mainPurple
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
    
    // MARK:- Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        hideKeyboardByTapAround()
        
        NotificationCenter.default.addObserver( self, selector: #selector(keyboardWillShow(notification:)), name:  UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK:- Selectors
    @objc func didPressSignButton() {
        
    }
    
    @objc func keyboardWillShow( notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            var newHeight: CGFloat
            let duration:TimeInterval = (notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve: UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            if #available(iOS 11.0, *) {
                newHeight = keyboardFrame.cgRectValue.height - self.view.safeAreaInsets.bottom
            } else {
                newHeight = keyboardFrame.cgRectValue.height
            }
            
            UIView.animate(withDuration: duration, delay: TimeInterval(0), options: animationCurve, animations: {
                print(newHeight)
                self.iconImageView.alpha = 0
                self.view.frame.origin.y -= newHeight
            })
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            var newHeight: CGFloat
            let duration:TimeInterval = (notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve: UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            if #available(iOS 11.0, *) {
                newHeight = keyboardFrame.cgRectValue.height - self.view.safeAreaInsets.bottom
            } else {
                newHeight = keyboardFrame.cgRectValue.height
            }
            UIView.animate(withDuration: duration, delay: TimeInterval(0), options: animationCurve, animations: {
                self.iconImageView.alpha = 1
                self.view.frame.origin.y = 0
            })
        }
    }
    
    @objc func didTapAround() {
        view.endEditing(true)
    }
    
    // MARK:- Private methods
    private func hideKeyboardByTapAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapAround))
        view.addGestureRecognizer(tap)
    }
    
    // MARK:- Configures
    func configureViews() {
        view.backgroundColor = .mainBlack
        configureSignOptionLabel()
        configureSignButton()
        configureFieldsStack()
        configureImageView()
    }
    
    private func configureImageView() {
        view.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(fieldsStackView.snp.top).offset(-45)
            //            make.9top.equalTo(self).offset(50)
        }
    }
    
    private func configureFieldsStack() {
        fieldsStackView.axis = .vertical
        fieldsStackView.distribution = .fillEqually
        fieldsStackView.spacing = 13
        
        view.addSubview(fieldsStackView)
        fieldsStackView.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(25)
            make.trailing.equalTo(view).offset(-25)
            make.height.equalTo(200)
            make.bottom.equalTo(signButton.snp.top).offset(-40)
        }
        
        fieldsStackView.subviews.map { $0.layer.cornerRadius = 17 }
    }
    
    private func configureSignButton() {
        view.addSubview(signButton)
        signButton.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(25)
            make.trailing.equalTo(view).offset(-25)
            make.height.equalTo(50)
            self.signButtonBottomConstraint = make.bottom.equalTo(signOptionLabel.snp.top).offset(-25).constraint
        }
    }
    
    private func configureSignOptionLabel() {
        view.addSubview(signOptionLabel)
        signOptionLabel.snp.makeConstraints { make in
            make.bottom.equalTo(view).offset(-50)
            make.centerX.equalTo(view)
        }
    }
    
    // MARK:- Inits
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
}

