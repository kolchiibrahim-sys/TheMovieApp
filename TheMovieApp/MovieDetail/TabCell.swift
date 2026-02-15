//
//  TabCell.swift
//  TheMovieApp
//
//  Created by Ibrahim Kolchi on 15.02.26.
//

import UIKit

final class TabCell: UICollectionViewCell {

    private let label = UILabel()
    private let underline = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false

        underline.backgroundColor = .systemBlue
        underline.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(label)
        contentView.addSubview(underline)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            underline.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 6),
            underline.heightAnchor.constraint(equalToConstant: 3),
            underline.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            underline.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            underline.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) { fatalError() }

    func configure(title: String, selected: Bool) {
        label.text = title
        label.textColor = selected ? .label : .systemGray
        underline.isHidden = !selected
    }
}
