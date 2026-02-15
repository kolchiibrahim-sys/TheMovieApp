//
//  MovieDetailController.swift
//  TheMovieApp
//
//  Created by Kolchı Ibrahım on 01.02.26.
//
import UIKit
import Kingfisher

final class MovieDetailController: UIViewController {

    private let movieId: Int
    private let manager = MovieManager()

    private var genres: [Genre] = []
    private var cast: [Cast] = []
    private var reviews: [Review] = []

    private let tabs = ["About Movie", "Reviews", "Cast"]
    private var selectedTab = 0

    private var overviewTopToCast: NSLayoutConstraint!
    private var overviewTopToTabs: NSLayoutConstraint!

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let posterImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 20
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let titleLabel: UILabel = {
        let l = UILabel()
        l.font = .boldSystemFont(ofSize: 26)
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private let infoLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14)
        l.textColor = .systemGray
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private lazy var genreCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.dataSource = self
        cv.delegate = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(GenreChipCell.self, forCellWithReuseIdentifier: GenreChipCell.id)
        return cv
    }()

    private lazy var tabCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 24
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.dataSource = self
        cv.delegate = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(TabCell.self, forCellWithReuseIdentifier: "TabCell")
        return cv
    }()

    private lazy var castCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 12
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.dataSource = self
        cv.delegate = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CastCell.self, forCellWithReuseIdentifier: CastCell.id)
        return cv
    }()

    private lazy var reviewsCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.dataSource = self
        cv.delegate = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(ReviewCell.self, forCellWithReuseIdentifier: ReviewCell.id)
        return cv
    }()

    private let overviewLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 16)
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    init(movieId: Int) {
        self.movieId = movieId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
        fetchMovie()
        castCollection.isHidden = true
        reviewsCollection.isHidden = true
    }

    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        [posterImageView, titleLabel, infoLabel, genreCollection, tabCollection, castCollection, reviewsCollection, overviewLabel]
            .forEach { contentView.addSubview($0) }

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        overviewTopToCast = overviewLabel.topAnchor.constraint(equalTo: castCollection.bottomAnchor, constant: 16)
        overviewTopToTabs = overviewLabel.topAnchor.constraint(equalTo: tabCollection.bottomAnchor, constant: 16)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            posterImageView.heightAnchor.constraint(equalToConstant: 420),

            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor),

            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            infoLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),

            genreCollection.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 12),
            genreCollection.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            genreCollection.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            genreCollection.heightAnchor.constraint(equalToConstant: 32),

            tabCollection.topAnchor.constraint(equalTo: genreCollection.bottomAnchor, constant: 20),
            tabCollection.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            tabCollection.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            tabCollection.heightAnchor.constraint(equalToConstant: 40),

            castCollection.topAnchor.constraint(equalTo: tabCollection.bottomAnchor, constant: 16),
            castCollection.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            castCollection.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            castCollection.heightAnchor.constraint(equalToConstant: 110),

            reviewsCollection.topAnchor.constraint(equalTo: tabCollection.bottomAnchor, constant: 16),
            reviewsCollection.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            reviewsCollection.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            reviewsCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),

            overviewTopToCast,
            overviewLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            overviewLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            overviewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }

    private func fetchMovie() {
        manager.fetchMovieDetail(id: movieId) { [weak self] movie in
            guard let movie else { return }
            DispatchQueue.main.async {
                self?.titleLabel.text = movie.title
                self?.overviewLabel.text = movie.overview
                let year = movie.releaseDate?.prefix(4) ?? ""
                let runtime = movie.runtime ?? 0
                let rating = movie.voteAverage ?? 0
                self?.infoLabel.text = "\(year) • \(runtime) min • ⭐️ \(rating)"
                self?.genres = movie.genres ?? []
                self?.genreCollection.reloadData()
                if let path = movie.posterPath {
                    let url = CoreHelper.shared.configureImageURL(path: path)
                    self?.posterImageView.kf.setImage(with: URL(string: url))
                }
                self?.fetchCast()
                self?.fetchReviews()
            }
        }
    }

    private func fetchCast() {
        manager.fetchCast(movieId: movieId) { [weak self] cast in
            DispatchQueue.main.async {
                self?.cast = cast
                self?.castCollection.reloadData()
            }
        }
    }

    private func fetchReviews() {
        manager.fetchReviews(movieId: movieId) { [weak self] reviews in
            DispatchQueue.main.async {
                self?.reviews = reviews
                self?.reviewsCollection.reloadData()
            }
        }
    }

    private func updateTabContent() {
        let isAbout = selectedTab == 0
        let isReviews = selectedTab == 1
        let isCast = selectedTab == 2

        overviewLabel.isHidden = !isAbout
        castCollection.isHidden = !isCast
        reviewsCollection.isHidden = !isReviews

        overviewTopToCast.isActive = isCast
        overviewTopToTabs.isActive = isAbout
    }
}

extension MovieDetailController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tabCollection { return tabs.count }
        if collectionView == castCollection { return cast.count }
        if collectionView == reviewsCollection { return reviews.count }
        return genres.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == tabCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabCell", for: indexPath) as! TabCell
            cell.configure(title: tabs[indexPath.item], selected: selectedTab == indexPath.item)
            return cell
        }

        if collectionView == castCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCell.id, for: indexPath) as! CastCell
            cell.configure(cast[indexPath.item])
            return cell
        }

        if collectionView == reviewsCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCell.id, for: indexPath) as! ReviewCell
            cell.configure(reviews[indexPath.item])
            return cell
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreChipCell.id, for: indexPath) as! GenreChipCell
        cell.configure(genres[indexPath.item].name)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == tabCollection {
            selectedTab = indexPath.item
            tabCollection.reloadData()
            updateTabContent()
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        if collectionView == tabCollection {
            let text = tabs[indexPath.item]
            let width = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 16, weight: .semibold)]).width + 10
            return CGSize(width: width, height: 30)
        }

        if collectionView == castCollection {
            return CGSize(width: 80, height: 100)
        }

        if collectionView == reviewsCollection {
            return CGSize(width: collectionView.frame.width, height: 140)
        }

        let text = genres[indexPath.item].name
        let width = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 13, weight: .semibold)]).width + 24
        return CGSize(width: width, height: 28)
    }
}

