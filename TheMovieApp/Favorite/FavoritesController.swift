//
//  FavoritesController.swift
//  TheMovieApp
//
//  Created by Kolchı Ibrahım on 10.02.26.
//
import UIKit

final class FavoritesController: BaseController {

    private var movies: [Movie] = []
    private let manager = MovieManager()

    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 24

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

    override func viewDidLoad() {
        super.viewDidLoad()
        loadFavorites()
    }

    override func configureUI() {
        title = "Favorites"
        view.backgroundColor = .systemBackground
    }

    override func configureConstraints() {
        view.addSubview(collection)
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func loadFavorites() {
        let ids = FavoritesManager.shared.allIds()
        movies.removeAll()

        guard !ids.isEmpty else {
            collection.reloadData()
            return
        }

        ids.forEach { id in
            manager.fetchMovies(endpoint: .searchMovies(query: "\(id)")) { [weak self] result in
                guard let movie = result.first else { return }
                self?.movies.append(movie)
                self?.collection.reloadData()
            }
        }
    }
}
extension FavoritesController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
        .init(width: collectionView.frame.width / 2 - 16, height: 260)
    }
}
