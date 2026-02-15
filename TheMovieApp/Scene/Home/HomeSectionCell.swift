//
//  HomeSection.swift
//  TheMovieApp
//
//  Created by Kolchı Ibrahım on 09.02.26.
//
// AI YAZIB 
import UIKit

final class HomeSectionCell: UICollectionViewCell {

    private var movies: [Movie] = []
    var seeAllTapped: (() -> Void)?
    var movieTapped: ((Int) -> Void)?

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let seeAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("See All", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var collection: UICollectionView = {
        let collection = UICollectionView(
            frame: .zero,
            collectionViewLayout: makeHorizontalLayout()
        )
        collection.dataSource = self
        collection.delegate = self
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isScrollEnabled = false
        collection.register(HomeCell.self, forCellWithReuseIdentifier: "HomeCell")
        return collection
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(titleLabel)
        contentView.addSubview(seeAllButton)
        contentView.addSubview(collection)

        seeAllButton.addTarget(self,
                               action: #selector(handleSeeAll),
                               for: .touchUpInside)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            seeAllButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            seeAllButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            collection.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            collection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    @objc private func handleSeeAll() {
        seeAllTapped?()
    }

    func configure(with model: HomeModel) {
        titleLabel.text = model.title
        movies = model.movies
        seeAllButton.isHidden = movies.isEmpty

        if model.title.contains("Results") {
            collection.setCollectionViewLayout(
                makeSearchGridLayout(),
                animated: false
            )
        } else {
            collection.setCollectionViewLayout(
                makeHorizontalLayout(),
                animated: false
            )
        }

        collection.reloadData()
    }

    private func makeHorizontalLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(140),
            heightDimension: .absolute(210)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 12)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .estimated(140),
            heightDimension: .absolute(210)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous

        return UICollectionViewCompositionalLayout(section: section)
    }

    private func makeSearchGridLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .estimated(260)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 6, bottom: 16, trailing: 6)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(260)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 12, bottom: 0, trailing: 12)
        section.orthogonalScrollingBehavior = .none

        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension HomeSectionCell: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        movies.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "HomeCell",
            for: indexPath
        ) as! HomeCell

        cell.configure(data: movies[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        movieTapped?(movies[indexPath.item].id)
    }
}
