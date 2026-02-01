//
//  VerificationController.swift
//  TheMovieApp
//
//  Created by Kolchı Ibrahım on 01.02.26.
//
import UIKit

class VerificationController: UIViewController {
    
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
        iv.image = UIImage(named: "Mektubdan Cixan Adam")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let l = UILabel()
        l.text = "Verification code"
        l.font = .systemFont(ofSize: 26, weight: .bold)
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let subtitleLabel: UILabel = {
        let l = UILabel()
        l.text = "A 4 digit code has been sent to +91 701*****34"
        l.font = .systemFont(ofSize: 14, weight: .regular)
        l.textColor = .gray
        l.textAlignment = .center
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let otpStackView: UIStackView = {
        let s = UIStackView()
        s.axis = .horizontal
        s.spacing = 20
        s.distribution = .fillEqually
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    private let verifyButton: UIButton = {
        let b = UIButton(type: .system)
        var config = UIButton.Configuration.filled()
        config.title = "Verify"
        config.baseBackgroundColor = .black
        config.baseForegroundColor = .white
        config.background.cornerRadius = 12
        b.configuration = config
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    private let resendLabel: UILabel = {
        let l = UILabel()
        l.text = "Resend Code"
        l.font = .systemFont(ofSize: 14, weight: .medium)
        l.textColor = .gray
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let timerLabel: UILabel = {
        let l = UILabel()
        l.text = "1:20 min left"
        l.font = .systemFont(ofSize: 14, weight: .medium)
        l.textColor = .gray
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureConstraints()
        setupOTPFields()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        [backButton, illustrationImageView, titleLabel, subtitleLabel,
         otpStackView, verifyButton, resendLabel, timerLabel].forEach { view.addSubview($0) }
    }
    
    private func setupOTPFields() {
        for _ in 0..<4 {
            let tf = UITextField()
            tf.backgroundColor = UIColor(white: 0.95, alpha: 1)
            tf.layer.cornerRadius = 12
            tf.textAlignment = .center
            tf.font = .systemFont(ofSize: 24, weight: .bold)
            tf.keyboardType = .numberPad
            tf.heightAnchor.constraint(equalToConstant: 60).isActive = true
            otpStackView.addArrangedSubview(tf)
        }
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            illustrationImageView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 10),
            illustrationImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            illustrationImageView.heightAnchor.constraint(equalToConstant: 220),
            
            titleLabel.topAnchor.constraint(equalTo: illustrationImageView.bottomAnchor, constant: 30),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            otpStackView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 40),
            otpStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            otpStackView.widthAnchor.constraint(equalToConstant: 280),
            
            verifyButton.topAnchor.constraint(equalTo: otpStackView.bottomAnchor, constant: 40),
            verifyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            verifyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            verifyButton.heightAnchor.constraint(equalToConstant: 56),
            
            resendLabel.topAnchor.constraint(equalTo: verifyButton.bottomAnchor, constant: 20),
            resendLabel.leadingAnchor.constraint(equalTo: verifyButton.leadingAnchor),
            
            timerLabel.topAnchor.constraint(equalTo: verifyButton.bottomAnchor, constant: 20),
            timerLabel.trailingAnchor.constraint(equalTo: verifyButton.trailingAnchor)
        ])
    }
}
