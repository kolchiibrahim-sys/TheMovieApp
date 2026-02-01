//
//  ResetPasswordController.swift
//  TheMovieApp
//
//  Created by Kolchı Ibrahım on 01.02.26.
//

import UIKit

class ResetPasswordController: UIViewController {
    
    private let backButton: UIButton = {
        let b = UIButton(type: .system)
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "arrow.left")
        config.baseForegroundColor = .black
        b.configuration = config
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    private let illustrationImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "2 Nefer Puzzle")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let l = UILabel()
        l.text = "Reset Password"
        l.font = .systemFont(ofSize: 28, weight: .bold)
        l.textColor = .black
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let newPasswordTextField: UITextField = {
        let t = UITextField()
        t.placeholder = "New Password"
        t.isSecureTextEntry = true
        
        let leftIcon = UIImageView(image: UIImage(systemName: "lock"))
        leftIcon.tintColor = .lightGray
        let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 20))
        leftIcon.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        leftPadding.addSubview(leftIcon)
        t.leftView = leftPadding
        t.leftViewMode = .always
        
        let rightButton = UIButton(type: .custom)
        rightButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        rightButton.tintColor = .lightGray
        rightButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        t.rightView = rightButton
        t.rightViewMode = .always
        
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    private let newSeparator: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.systemGray5
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let confirmPasswordTextField: UITextField = {
        let t = UITextField()
        t.placeholder = "Confirm New Password"
        t.isSecureTextEntry = true
        
        let leftIcon = UIImageView(image: UIImage(systemName: "lock"))
        leftIcon.tintColor = .lightGray
        let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 20))
        leftIcon.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        leftPadding.addSubview(leftIcon)
        t.leftView = leftPadding
        t.leftViewMode = .always
        
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    private let confirmSeparator: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.systemGray5
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let resetPasswordButton: UIButton = {
        let b = UIButton(type: .system)
        var config = UIButton.Configuration.filled()
        config.title = "Reset Password"
        config.baseBackgroundColor = .black
        config.baseForegroundColor = .white
        config.background.cornerRadius = 12
        b.configuration = config
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureConstraints()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        [backButton, illustrationImageView, titleLabel,
         newPasswordTextField, newSeparator, confirmPasswordTextField,
         confirmSeparator, resetPasswordButton].forEach { view.addSubview($0) }
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            illustrationImageView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 10),
            illustrationImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            illustrationImageView.heightAnchor.constraint(equalToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: illustrationImageView.bottomAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            newPasswordTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            newPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            newPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            newPasswordTextField.heightAnchor.constraint(equalToConstant: 45),
            
            newSeparator.topAnchor.constraint(equalTo: newPasswordTextField.bottomAnchor, constant: 5),
            newSeparator.leadingAnchor.constraint(equalTo: newPasswordTextField.leadingAnchor),
            newSeparator.trailingAnchor.constraint(equalTo: newPasswordTextField.trailingAnchor),
            newSeparator.heightAnchor.constraint(equalToConstant: 1),
            
            confirmPasswordTextField.topAnchor.constraint(equalTo: newSeparator.bottomAnchor, constant: 25),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: newPasswordTextField.leadingAnchor),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: newPasswordTextField.trailingAnchor),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 45),
            
            confirmSeparator.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 5),
            confirmSeparator.leadingAnchor.constraint(equalTo: confirmPasswordTextField.leadingAnchor),
            confirmSeparator.trailingAnchor.constraint(equalTo: confirmPasswordTextField.trailingAnchor),
            confirmSeparator.heightAnchor.constraint(equalToConstant: 1),
            
            resetPasswordButton.topAnchor.constraint(equalTo: confirmSeparator.bottomAnchor, constant: 40),
            resetPasswordButton.leadingAnchor.constraint(equalTo: newPasswordTextField.leadingAnchor),
            resetPasswordButton.trailingAnchor.constraint(equalTo: newPasswordTextField.trailingAnchor),
            resetPasswordButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
}
