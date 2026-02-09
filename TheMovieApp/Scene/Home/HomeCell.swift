//
//  HomeCell.swift
//  TheMovieApp
//
//  Created by Kolchı Ibrahım on 31.01.26.
//
import UIKit
import Kingfisher
final class HomeCell: UICollectionViewCell {

    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.15
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let posterImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(containerView)
        containerView.addSubview(posterImageView)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            posterImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}
extension HomeCell {

    func configure(data movie: Movie) {
        posterImageView.kf.setImage(
            with: movie.posterURL,
            placeholder: UIImage(named: "placeholder"),
            options: [
                .transition(.fade(0.25)),   
                .cacheOriginalImage
            ]
        )
    }
}
