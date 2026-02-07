import UIKit

class ActorController: BaseController {
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
    
    private let viewModel = ActorViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureViewModel() {
        viewModel.getActorList()
        viewModel.success = {
            self.collection.reloadData()
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopImageBottomLabelCell.identifier,
                                                      for: indexPath) as! TopImageBottomLabelCell
        cell.configure(data: viewModel.items[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 168, height: 168)
    }
}
