//
//  ForgotPasswordController.swift
//  TheMovieApp
//
//  Created by Kolchı Ibrahım on 01.02.26.
//
import UIKit

class ForgotPasswordController: UIViewController {
    
    // MARK: - UI Elements
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
        iv.image = UIImage(named: "amico 1") // Assets-ə əlavə etməlisən
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let l = UILabel()
        l.text = "Forgot Password?"
        l.font = .systemFont(ofSize: 28, weight: .bold)
        l.textColor = .black
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let descriptionLabel: UILabel = {
        let l = UILabel()
        l.text = "Don't worry! It happens. Please enter the email address associated with your account."
        l.font = .systemFont(ofSize: 14, weight: .regular)
        l.textColor = .darkGray
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let emailTextField: UITextField = {
        let t = UITextField()
        t.placeholder = "Email / Mobile Number"
        
        // Sol tərəfdəki ikon
        let iconView = UIImageView(image: UIImage(systemName: "at"))
        iconView.tintColor = .lightGray
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 20))
        iconView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        paddingView.addSubview(iconView)
        
        t.leftView = paddingView
        t.leftViewMode = .always
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    private let separatorView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.systemGray5
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let submitButton: UIButton = {
        let b = UIButton(type: .system)
        var config = UIButton.Configuration.filled()
        config.title = "Submit"
        config.baseBackgroundColor = UIColor(white: 0.15, alpha: 1) // Tünd boz/qara
        config.baseForegroundColor = .white
        config.background.cornerRadius = 12
        
        b.configuration = config
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureConstraints()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        [backButton, illustrationImageView, titleLabel,
         descriptionLabel, emailTextField, separatorView, submitButton].forEach { view.addSubview($0) }
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            // Back Button
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            // Illustration
            illustrationImageView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),
            illustrationImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            illustrationImageView.heightAnchor.constraint(equalToConstant: 220),
            illustrationImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            // Title
            titleLabel.topAnchor.constraint(equalTo: illustrationImageView.bottomAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            // Description
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            // TextField
            emailTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 40),
            emailTextField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 45),
            
            // Separator
            separatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 5),
            separatorView.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            
            // Submit Button
            submitButton.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 40),
            submitButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            submitButton.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            submitButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
}
