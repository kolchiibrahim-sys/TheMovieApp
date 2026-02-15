//
//  FavoritesController.swift
//  TheMovieApp
//
//  Created by Kolchı Ibrahım on 10.02.26.
//
import UIKit
import Alamofire
import Kingfisher

final class FavoritesController: BaseController,
                                 UICollectionViewDataSource,
                                 UICollectionViewDelegateFlowLayout {

    private var movies: [Movie] = []
    private let manager = MovieManager()
    private var filteredMovies: [Movie] = []
    private var isSearching = false

    private lazy var searchController = UISearchController(searchResultsController: nil)

    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 24
        layout.minimumInteritemSpacing = 16

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(HomeCell.self,
                            forCellWithReuseIdentifier: "HomeCell")
        return collection
    }()

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

    override func configureUI() {
        title = "Favorites"
        view.backgroundColor = .systemBackground

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search favorites"
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

    private func fetchFavorites(completion: @escaping ([Movie]) -> Void) {
        let ids = FavoritesManager.shared.getAll()
        var result: [Movie] = []

        guard !ids.isEmpty else {
            completion([])
            return
        }

        let group = DispatchGroup()

        ids.forEach { id in
            group.enter()
            manager.fetchMovieDetail(id: id) { movie in
                if let movie { result.append(movie) }
                group.leave()
            }
        }

        group.notify(queue: .main) {
            completion(result)
        }
    }

    private func loadFavorites() {
        fetchFavorites { [weak self] movies in
            self?.movies = movies
            self?.collection.reloadData()
        }
    }

    @objc private func favoritesUpdated() {
        let oldMovies = movies

        fetchFavorites { [weak self] newMovies in
            guard let self else { return }

            let oldIds = Set(oldMovies.map { $0.id })
            let newIds = Set(newMovies.map { $0.id })
            let removedIds = oldIds.subtracting(newIds)

            self.movies = newMovies

            if let removedId = removedIds.first,
               let index = oldMovies.firstIndex(where: { $0.id == removedId }),
               let cell = self.collection.cellForItem(at: IndexPath(item: index, section: 0)) {

                UIView.animate(withDuration: 0.35, animations: {
                    cell.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                    cell.alpha = 0
                }) { _ in
                    let indexPath = IndexPath(item: index, section: 0)
                    self.collection.performBatchUpdates {
                        self.collection.deleteItems(at: [indexPath])
                    }
                }

            } else {
                self.collection.reloadData()
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        isSearching ? filteredMovies.count : movies.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "HomeCell",
            for: indexPath
        ) as! HomeCell

        let movie = isSearching ? filteredMovies[indexPath.item] : movies[indexPath.item]
        cell.configure(data: movie)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = (collectionView.frame.width - 16 * 3) / 2
        return .init(width: width, height: 260)
    }
}

extension FavoritesController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {

        let text = searchController.searchBar.text ?? ""

        if text.isEmpty {
            isSearching = false
            filteredMovies.removeAll()
        } else {
            isSearching = true
            filteredMovies = movies.filter {
                $0.title.lowercased().contains(text.lowercased())
            }
        }

        collection.reloadData()
    }
}
