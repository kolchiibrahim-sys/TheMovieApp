//
//  TopImageBottomLabelCell.swift
//  TheMovieApp
//
//  Created by Kolchı Ibrahım on 31.01.26.
//

import UIKit

class TopImageBottomLabelCell: UICollectionViewCell {
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.textColor = .black
        l.font = .systemFont(ofSize: 16, weight: .medium)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    lazy var topImage: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 16
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static let identifier = "TopImageBottomLabelCell"
    
    private func configureConstraints() {
        addSubview(titleLabel)
        addSubview(topImage)
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            topImage.topAnchor.constraint(equalTo: topAnchor),
            topImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            topImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            topImage.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -8),
        ])
    }
    
    func configure(data: MovieResult) {
        titleLabel.text = data.originalTitle
        topImage.loadURL(data: data.posterPath ?? "")
    }
}
