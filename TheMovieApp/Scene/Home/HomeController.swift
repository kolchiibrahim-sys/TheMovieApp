//
//  HomeController.swift
//  TheMovieApp
//
//  Created by Kolchı Ibrahım on 31.01.26.
//
import UIKit

final class HomeController: BaseController {

    private let viewModel = HomeViewModel()
    private let searchResultsController = SearchResultsController()
    private lazy var searchController = UISearchController(
        searchResultsController: searchResultsController
    )

    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 24

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(
            HomeSectionCell.self,
            forCellWithReuseIdentifier: "HomeSectionCell"
        )
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func configureUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true

        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search movies"
    }
    override func configureViewModel() {
        viewModel.onUpdate = { [weak self] in
            self?.collection.reloadData()
        }

        viewModel.loadHomeData()
    }

    override func configureConstraints() {
        view.addSubview(collection)
        NSLayoutConstraint.activate([
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
extension HomeController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text ?? ""

        guard !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            searchResultsController.update(movies: [])
            return
        }

        MovieManager().fetchMovies(endpoint: .searchMovies(query: text)) { [weak self] movies in
            self?.searchResultsController.update(movies: movies)
        }
    }
}
extension HomeController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchResultsController.update(movies: [])
    }
}
extension HomeController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.items.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "HomeSectionCell",
            for: indexPath
        ) as! HomeSectionCell

        let section = viewModel.items[indexPath.section]
        cell.configure(with: section)

        cell.seeAllTapped = { [weak self] in
            guard let self = self else { return }
            let vc = SeeAllController(
                title: section.title,
                endpoint: section.endpoint
            )

            self.navigationController?.pushViewController(vc, animated: true)
        }

        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width, height: 260)
    }
}
