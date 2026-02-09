//
//  HomeController.swift
//  TheMovieApp
//
//  Created by Kolchı Ibrahım on 31.01.26.
//
import UIKit

final class HomeController: BaseController {

    private let viewModel = HomeViewModel()
    private let searchController = UISearchController(
        searchResultsController: SearchResultsController()
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

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearch()
        bindViewModel()
        viewModel.loadHomeData()
    }

    // MARK: - UI
    override func configureUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
    }

    // MARK: - Search
    private func configureSearch() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search movies"
    }

    // MARK: - Constraints
    override func configureConstraints() {
        view.addSubview(collection)
        NSLayoutConstraint.activate([
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    // MARK: - Binding
    private func bindViewModel() {
        viewModel.onSuccess = { [weak self] in
            self?.collection.reloadData()
        }

        viewModel.onError = { error in
            print("API ERROR:", error)
        }
    }
}
extension HomeController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text ?? ""

        viewModel.searchMovies(query: text) { movies in
            let resultsVC = searchController.searchResultsController
                as? SearchResultsController
            resultsVC?.update(movies: movies)
        }
    }
}
extension HomeController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.cancelSearch()
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
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

     
        return .init(
            width: collectionView.frame.width,
            height: 260
        )
    }
}
