//
//  HomeCell.swift
//  TheMovieApp
//
//  Created by Kolchı Ibrahım on 31.01.26.
//
import UIKit
import Alamofire
import Kingfisher

final class HomeCell: UICollectionViewCell {

    private var movieId: Int?
    private let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .systemRed
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let posterImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerCurve = .continuous
        iv.layer.cornerRadius = 16
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let gradientLayer = CAGradientLayer()


    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(favoriteButton)

        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.08
        contentView.layer.shadowOffset = CGSize(width: 0, height: 4)
        contentView.layer.shadowRadius = 10
        contentView.layer.masksToBounds = false

        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.75).cgColor
        ]
        gradientLayer.locations = [0.5, 1.0]
        posterImageView.layer.addSublayer(gradientLayer)

        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImageView.heightAnchor.constraint(
                equalTo: posterImageView.widthAnchor,
                multiplier: 1.5
            ),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),

            favoriteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            favoriteButton.widthAnchor.constraint(equalToConstant: 24),
            favoriteButton.heightAnchor.constraint(equalToConstant: 24)
        ])

        favoriteButton.addAction(
            UIAction { [weak self] _ in
                guard let id = self?.movieId else { return }
                FavoritesManager.shared.toggle(id: id)
                self?.updateFavoriteIcon()

                NotificationCenter.default.post(
                    name: .favoritesUpdated,
                    object: nil
                )
            },
            for: .touchUpInside
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = posterImageView.bounds
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
        titleLabel.text = nil
        movieId = nil
    }


    func configure(data: Movie) {
        movieId = data.id
        titleLabel.text = data.title

        updateFavoriteIcon()

        if let path = data.posterPath {
            let url = CoreHelper.shared.configureImageURL(path: path)
            posterImageView.kf.setImage(with: URL(string: url))
        }
    }

    private func updateFavoriteIcon() {
        guard let id = movieId else { return }
        let isFav = FavoritesManager.shared.isFavorite(id: id)
        let imageName = isFav ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.15) {
                self.transform = self.isHighlighted
                    ? CGAffineTransform(scaleX: 0.96, y: 0.96)
                    : .identity
            }
        }
    }
}
extension Notification.Name {
    static let favoritesUpdated = Notification.Name("favoritesUpdated")
}
