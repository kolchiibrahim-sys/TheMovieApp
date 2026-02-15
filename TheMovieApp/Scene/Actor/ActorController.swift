import UIKit

final class ActorController: BaseController {

    private let viewModel = ActorViewModel()

    private lazy var searchController = UISearchController(searchResultsController: nil)

    lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .zero
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 16

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(TopImageBottomLabelCell.self,
                            forCellWithReuseIdentifier: TopImageBottomLabelCell.identifier)
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func configureUI() {
        title = "Actors"

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search actors"
    }

    override func configureViewModel() {
        viewModel.getActorList()

        viewModel.success = { [weak self] in
            self?.collection.reloadData()
        }

        viewModel.error = { message in
            print(message)
        }
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

extension ActorController: CollectionConfiguration {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        viewModel.items.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TopImageBottomLabelCell.identifier,
            for: indexPath
        ) as! TopImageBottomLabelCell

        cell.configure(data: viewModel.items[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 168, height: 168)
    }
}

extension ActorController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y

        if position > (collection.contentSize.height - scrollView.frame.size.height - 100) {
            viewModel.getActorList()
        }
    }
}

extension ActorController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {

        let text = searchController.searchBar.text ?? ""

        if text.trimmingCharacters(in: .whitespaces).isEmpty {
            viewModel.resetSearch()
        } else {
            viewModel.searchActors(query: text)
        }
    }
}
