//
//  ReviewCell.swift
//  TheMovieApp
//
//  Created by Ibrahim Kolchi on 15.02.26.
//
import UIKit

final class ReviewCell: UICollectionViewCell {

    static let id = "ReviewCell"

    private let authorLabel: UILabel = {
        let l = UILabel()
        l.font = .boldSystemFont(ofSize: 14)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private let contentLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14)
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(authorLabel)
        contentView.addSubview(contentLabel)

        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            contentLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 6),
            contentLabel.leadingAnchor.constraint(equalTo: authorLabel.leadingAnchor),
            contentLabel.trailingAnchor.constraint(equalTo: authorLabel.trailingAnchor),
            contentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) { fatalError() }

    func configure(_ review: Review) {
        authorLabel.text = review.author
        contentLabel.text = review.content
    }
}
