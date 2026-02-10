//
//  FavoritesController.swift
//  TheMovieApp
//
//  Created by Kolchı Ibrahım on 10.02.26.
//

import UIKit
import Alamofire
import Kingfisher
final class FavaritesController: BaseController {

    // MARK: - State
    private var movies: [Movie] = []
    private let manager = MovieManager()

    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 24
        layout.minimumInteritemSpacing = 16

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(
            HomeCell.self,
            forCellWithReuseIdentifier: "HomeCell"
        )
        return collection
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFavorites()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(favoritesUpdated),
            name: .favoritesUpdated,
            object: nil
        )
    }

    // MARK: - UI
    override func configureUI() {
        title = "Favorites"
        view.backgroundColor = .systemBackground
    }

    // MARK: - Constraints
    override func configureConstraints() {
        view.addSubview(collection)
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // MARK: - Data
    private func loadFavorites() {
        let ids = FavoritesManager.shared.allIds()
        movies.removeAll()

        guard !ids.isEmpty else {
            DispatchQueue.main.async {
                self.collection.reloadData()
            }
            return
        }

        ids.forEach { id in
            manager.fetchMovies(endpoint: .searchMovies(query: "\(id)")) { [weak self] result in
                guard let movie = result.first else { return }
                self?.movies.append(movie)

                DispatchQueue.main.async {
                    self?.collection.reloadData()
                }
            }
        }
    }

    @objc private func favoritesUpdated() {
        loadFavorites()
    }
}

// MARK: - CollectionView
extension FavaritesController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        movies.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "HomeCell",
            for: indexPath
        ) as! HomeCell

        cell.configure(data: movies[indexPath.item])
        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = (collectionView.frame.width - 16 * 3) / 2
        return .init(width: width, height: 260)
    }
}
