//
//  SeeAllController.swift
//  TheMovieApp
//
//  Created by Ibrahim Kolchi on 14.02.26.
//
import UIKit

final class SeeAllController: UIViewController {

    private var movies: [Movie] = []
    private let endpoint: Endpoint

    private var currentPage = 1
    private var totalPages = 1
    private var isLoading = false

    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 12

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .systemBackground
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.dataSource = self
        collection.delegate = self
        collection.register(HomeCell.self, forCellWithReuseIdentifier: "HomeCell")
        return collection
    }()

    init(title: String, endpoint: Endpoint) {
        self.endpoint = endpoint
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(collection)

        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        fetchMovies()
    }

    private func fetchMovies() {
        guard !isLoading else { return }
        guard currentPage <= totalPages else { return }

        isLoading = true

        MovieManager().fetchMovies(endpoint: endpoint, page: currentPage) { [weak self] movies, totalPages in
            guard let self = self else { return }

            self.movies.append(contentsOf: movies)
            self.totalPages = totalPages
            self.currentPage += 1
            self.isLoading = false
            self.collection.reloadData()
        }
    }
}

extension SeeAllController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCell
        cell.configure(data: movies[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 12) / 2
        return CGSize(width: width, height: width * 1.6)
    }
}

extension SeeAllController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y

        if position > (collection.contentSize.height - scrollView.frame.size.height - 100) {
            fetchMovies()
        }
    }
}
