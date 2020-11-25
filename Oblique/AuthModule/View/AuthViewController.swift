//
//  AuthViewController.swift
//  Oblique
//
//  Created by Максим Алексеев on 17.10.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit
import SnapKit

enum AuthState {
    case signup
    case signin
}

class AuthViewController: UIViewController {
    // MARK:- Dependencies
    var presenter: AuthInput!
    
    // MARK:- Properties
    var authState: AuthState? = .signup {
        didSet {
            didChangeState()
        }
    }
    
    // Shows if keyboard appeared
    var isKeyboardAppeared: Bool = false
    
    // MARK:- Views
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .lightFieldGray
        textField.font = .systemFont(ofSize: 18)
        textField.textColor = .white
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
        button.layer.cornerRadius = 20
        button.backgroundColor = .mainPurple
        button.addTarget(self, action: #selector(didPressSignButton), for: .touchUpInside)
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
        label.isUserInteractionEnabled = true
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
        guard let emailText = emailTextField.text,
             let passwordText = passwordTextField.text
            else { return }
        
        switch authState {
        case .signin:
            presenter.signIn(email: emailText, password: passwordText)
        case .signup:
            guard let confirmPassText = confirmPasswordTextField.text,
                  let nameText = nameTextField.text
                else { return }
            presenter.signUp(email: emailText, password: passwordText, confirmPass: confirmPassText, name: nameText)
        case .none:
            break
        }
    }
    
    @objc func keyboardWillShow( notification: Notification) {
        guard !isKeyboardAppeared else { return }
        self.isKeyboardAppeared.toggle()
        
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
                self.view.frame.origin.y -= newHeight
            }, completion: { _ in
            })
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        self.isKeyboardAppeared.toggle()
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
                self.view.frame.origin.y = 0
            })
        }
    }
    
    @objc func didTapAround() {
        view.endEditing(true)
    }
    
    @objc func didTapSignOptionLabel() {
        switch authState {
        case .signup:
            authState = .signin
        case .signin:
            authState = .signup
        default:
            break
        }
    }
    
    // MARK:- Public methods
    func didChangeState() {
        switch authState {
        case .signin:
            signButton.setTitle("Sign In", for: .normal)
            
            let attributedTitle = NSMutableAttributedString(string: "Don't have an account? ", attributes:
                [NSAttributedString.Key.font: UIFont.systemFont(ofSize: (14)),
                 NSAttributedString.Key.foregroundColor: UIColor.white])
            let attributedString = NSAttributedString(string: "Sign up", attributes: [NSAttributedString.Key.foregroundColor: UIColor.mainPurple])
            attributedTitle.append(attributedString)
            signOptionLabel.attributedText = attributedTitle
            
            UIView.animate(withDuration: 0.25, animations: {
                self.nameTextField.alpha = 0
                self.confirmPasswordTextField.alpha = 0
            }) { _ in
                self.fieldsStackView.removeArrangedSubview(self.nameTextField)
                self.fieldsStackView.removeArrangedSubview(self.confirmPasswordTextField)
                self.nameTextField.removeFromSuperview()
                self.confirmPasswordTextField.removeFromSuperview()
                
                self.fieldsStackView.snp.makeConstraints { make in
                    make.leading.equalTo(self.view).offset(25)
                    make.trailing.equalTo(self.view).offset(-25)
                    make.height.equalTo(100)
                    make.bottom.equalTo(self.signButton.snp.top).offset(-40)
                }
            }
            
        default:
            break
        }
    }
    
    func didAuthentificate(token: String?) {
        if let _ = token {
            
        }
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
//        configureImageView()
    }
    
//    private func configureImageView() {
//        view.addSubview(iconImageView)
//        iconImageView.snp.makeConstraints { make in
//            make.centerX.equalTo(view)
//            make.bottom.equalTo(fieldsStackView.snp.top).offset(-45)
//        }
//    }
    
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
            make.bottom.equalTo(signOptionLabel.snp.top).offset(-25)
        }
    }
    
    private func configureSignOptionLabel() {
        view.addSubview(signOptionLabel)
        signOptionLabel.snp.makeConstraints { make in
            make.bottom.equalTo(view).offset(-50)
            make.centerX.equalTo(view)
        }
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapSignOptionLabel))
        signOptionLabel.addGestureRecognizer(gestureRecognizer)
    }
    
    // MARK:- Inits
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
}

