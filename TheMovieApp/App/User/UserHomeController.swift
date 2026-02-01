//
//  UserHomeController.swift
//  TheMovieApp
//
//  Created by Kolchı Ibrahım on 01.02.26.
//
import UIKit

class UserHomeController: UIViewController {
    
    private let skipButton: UIButton = {
        let b = UIButton(type: .system)
        var config = UIButton.Configuration.plain()
        config.title = "Skip >>"
        config.baseForegroundColor = .lightGray
        b.configuration = config
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    private let illustrationImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Salam Veren Qiz")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let l = UILabel()
        l.text = "Create your Profile"
        l.font = .systemFont(ofSize: 24, weight: .bold)
        l.textColor = .black
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let descriptionLabel: UILabel = {
        let l = UILabel()
        l.text = "Complete your profile to help you find a roommate who will be right for you."
        l.font = .systemFont(ofSize: 15, weight: .regular)
        l.textColor = .gray
        l.textAlignment = .center
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.numberOfPages = 3
        pc.currentPage = 2
        pc.currentPageIndicatorTintColor = .black
        pc.pageIndicatorTintColor = .systemGray5
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()
    
    private let nextButton: UIButton = {
        let b = UIButton(type: .system)
        var config = UIButton.Configuration.plain()
        config.title = "Next"
        config.baseForegroundColor = .gray
        config.attributedTitle?.font = .systemFont(ofSize: 18, weight: .medium)
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
        [skipButton, illustrationImageView, titleLabel, descriptionLabel, pageControl, nextButton].forEach { view.addSubview($0) }
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            skipButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            illustrationImageView.topAnchor.constraint(equalTo: skipButton.bottomAnchor, constant: 40),
            illustrationImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            illustrationImageView.heightAnchor.constraint(equalToConstant: 300),
            illustrationImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            titleLabel.topAnchor.constraint(equalTo: illustrationImageView.bottomAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            pageControl.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -20),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
