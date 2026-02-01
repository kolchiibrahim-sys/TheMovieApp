//
//  LoginPasswordController.swift
//  TheMovieApp
//
//  Created by Kolchı Ibrahım on 01.02.26.
//
import UIKit

class SignUpController: UIViewController {
    
    private let backButton: UIButton = {
        let b = UIButton(type: .system)
        b.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        b.tintColor = .black
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    private let illustrationImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "signup_illustration")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let l = UILabel()
        l.text = "Sign Up"
        l.font = .systemFont(ofSize: 30, weight: .bold)
        l.textColor = .black
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let emailTextField: UITextField = {
        let t = UITextField()
        t.placeholder = "Email"
        let icon = UIImageView(image: UIImage(systemName: "at"))
        icon.tintColor = .gray
        t.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        t.leftViewMode = .always
        let iconView = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
        iconView.image = UIImage(systemName: "at")
        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = .lightGray
        t.leftView?.addSubview(iconView)
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    private let nameTextField: UITextField = {
        let t = UITextField()
        t.placeholder = "Full Name"
        let iconView = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
        iconView.image = UIImage(systemName: "person")
        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = .lightGray
        t.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        t.leftView?.addSubview(iconView)
        t.leftViewMode = .always
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    private let mobileTextField: UITextField = {
        let t = UITextField()
        t.placeholder = "Mobile"
        let iconView = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
        iconView.image = UIImage(systemName: "phone")
        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = .lightGray
        t.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        t.leftView?.addSubview(iconView)
        t.leftViewMode = .always
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    private let termsLabel: UILabel = {
        let l = UILabel()
        let text = "By signing up, you've agree to our terms and conditions and Privacy Policy."
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: (text as NSString).range(of: "terms and conditions"))
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: (text as NSString).range(of: "Privacy Policy"))
        l.attributedText = attributedString
        l.font = .systemFont(ofSize: 13)
        l.numberOfLines = 0
        l.textColor = .lightGray
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let continueButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Continue", for: .normal)
        b.backgroundColor = .black
        b.setTitleColor(.white, for: .normal)
        b.layer.cornerRadius = 12
        b.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
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
        [backButton, illustrationImageView, titleLabel, emailTextField,
         nameTextField, mobileTextField, termsLabel, continueButton].forEach { view.addSubview($0) }
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            illustrationImageView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),
            illustrationImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            illustrationImageView.heightAnchor.constraint(equalToConstant: 250),
            
            titleLabel.topAnchor.constraint(equalTo: illustrationImageView.bottomAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            nameTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            mobileTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            mobileTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            mobileTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            mobileTextField.heightAnchor.constraint(equalToConstant: 50),
            
            termsLabel.topAnchor.constraint(equalTo: mobileTextField.bottomAnchor, constant: 20),
            termsLabel.leadingAnchor.constraint(equalTo: mobileTextField.leadingAnchor),
            termsLabel.trailingAnchor.constraint(equalTo: mobileTextField.trailingAnchor),
            
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            continueButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
}
