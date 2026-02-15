//
//  GenreChipCell.swift
//  TheMovieApp
//
//  Created by Ibrahim Kolchi on 15.02.26.
import UIKit

final class GenreChipCell: UICollectionViewCell {

    static let id = "GenreChipCell"

    private let label: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 13, weight: .semibold)
        l.textColor = .systemBlue
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
        contentView.layer.cornerRadius = 14

        contentView.addSubview(label)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        ])
    }

    required init?(coder: NSCoder) { fatalError() }

    func configure(_ text: String) {
        label.text = text
    }
}
