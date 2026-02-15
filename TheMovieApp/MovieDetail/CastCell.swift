//
//  CastCell.swift
//  TheMovieApp
//
//  Created by Ibrahim Kolchi on 15.02.26.
//
import UIKit
import Kingfisher

final class CastCell: UICollectionViewCell {

    static let id = "CastCell"

    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 35
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let nameLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 12)
        l.textAlignment = .center
        l.numberOfLines = 2
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 70),
            imageView.heightAnchor.constraint(equalToConstant: 70),

            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 6),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    required init?(coder: NSCoder) { fatalError() }

    func configure(_ cast: Cast) {
        nameLabel.text = cast.name

        if let path = cast.profilePath {
            let url = URL(string: "https://image.tmdb.org/t/p/w200\(path)")
            imageView.kf.setImage(with: url)
        }
    }
}
