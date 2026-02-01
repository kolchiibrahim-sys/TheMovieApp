//
//  RegisterController.swift
//  TheMovieApp
//
//  Created by Kolchı Ibrahım on 01.02.26.
//
import UIKit

class LoginController: UIViewController {
    
    private let illustrationImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "2 Adam")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let l = UILabel()
        l.text = "Login"
        l.font = .systemFont(ofSize: 32, weight: .bold)
        l.textColor = .black
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let emailTextField: UITextField = {
        let t = UITextField()
        t.placeholder = "Email"
        let iconView = UIImageView(image: UIImage(systemName: "at"))
        iconView.tintColor = .lightGray
        t.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        iconView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        t.leftView?.addSubview(iconView)
        t.leftViewMode = .always
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    private let emailSeparator: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.systemGray5
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let passwordTextField: UITextField = {
        let t = UITextField()
        t.placeholder = "Password"
        t.isSecureTextEntry = true
        let iconView = UIImageView(image: UIImage(systemName: "lock"))
        iconView.tintColor = .lightGray
        t.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        iconView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        t.leftView?.addSubview(iconView)
        t.leftViewMode = .always
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    private let passwordSeparator: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.systemGray5
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let forgotPasswordButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Forgot Password?", for: .normal)
        b.setTitleColor(.systemBlue, for: .normal)
        b.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    private let loginButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Continue", for: .normal)
        b.backgroundColor = .black
        b.setTitleColor(.white, for: .normal)
        b.layer.cornerRadius = 12
        b.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    private let orLabel: UILabel = {
        let l = UILabel()
        l.text = "OR"
        l.textColor = .lightGray
        l.font = .systemFont(ofSize: 14)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let googleLoginButton: UIButton = {
        let b = UIButton(type: .system)
        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.filled()
            config.title = "Login with Google"
            config.baseBackgroundColor = UIColor(white: 0.96, alpha: 1)
            config.baseForegroundColor = .gray
            config.image = UIImage(named: "google")?.withRenderingMode(.alwaysOriginal)
            config.imagePlacement = .leading
            config.imagePadding = 15
            config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
            config.cornerStyle = .fixed
            b.configuration = config
        } else {
            // Fallback for iOS versions prior to 15.0
            b.setTitle("Login with Google", for: .normal)
            b.setTitleColor(.gray, for: .normal)
            b.backgroundColor = UIColor(white: 0.96, alpha: 1)
            b.layer.cornerRadius = 12
            b.setImage(UIImage(named: "google")?.withRenderingMode(.alwaysOriginal), for: .normal)
            b.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
            b.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    private let joinNowLabel: UIButton = {
        let b = UIButton(type: .system)
        let attr: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.lightGray]
        let boldAttr: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.systemBlue, .font: UIFont.boldSystemFont(ofSize: 14)]
        
        let mAttr = NSMutableAttributedString(string: "Joined us before? ", attributes: attr)
        mAttr.append(NSAttributedString(string: "Login", attributes: boldAttr))
        
        b.setAttributedTitle(mAttr, for: .normal)
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
        [illustrationImageView, titleLabel, emailTextField, emailSeparator,
         passwordTextField, passwordSeparator, forgotPasswordButton,
         loginButton, orLabel, googleLoginButton, joinNowLabel].forEach { view.addSubview($0) }
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            illustrationImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            illustrationImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            illustrationImageView.heightAnchor.constraint(equalToConstant: 250),
            
            titleLabel.topAnchor.constraint(equalTo: illustrationImageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            emailSeparator.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 5),
            emailSeparator.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            emailSeparator.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            emailSeparator.heightAnchor.constraint(equalToConstant: 1),
            
            passwordTextField.topAnchor.constraint(equalTo: emailSeparator.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordSeparator.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 5),
            passwordSeparator.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            passwordSeparator.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            passwordSeparator.heightAnchor.constraint(equalToConstant: 1),
            
            forgotPasswordButton.topAnchor.constraint(equalTo: passwordSeparator.bottomAnchor, constant: 10),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: passwordSeparator.trailingAnchor),
            
            loginButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 30),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            loginButton.heightAnchor.constraint(equalToConstant: 56),
            
            orLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            orLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            googleLoginButton.topAnchor.constraint(equalTo: orLabel.bottomAnchor, constant: 20),
            googleLoginButton.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor),
            googleLoginButton.trailingAnchor.constraint(equalTo: loginButton.trailingAnchor),
            googleLoginButton.heightAnchor.constraint(equalToConstant: 56),
            
            joinNowLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            joinNowLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

