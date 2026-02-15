//
//  HomeViewModel.swift
//  TheMovieApp
//
//  Created by Kolchı Ibrahım on 31.01.26.
//
import Foundation

final class HomeViewModel {

    private(set) var items: [HomeModel] = []
    var onUpdate: (() -> Void)?
    private let service = MovieManager()

    func loadHomeData() {
        items.removeAll()
        fetchTrending()
        fetchNowPlaying()
        fetchUpcoming()
        fetchPopular()
        fetchTopRated()
    }

    private func fetchTrending() {
        service.fetchMovies(endpoint: .trendingMovies) { [weak self] movies in
            self?.items.append(
                HomeModel(
                    title: "Trending Today",
                    movies: movies,
                    endpoint: .trendingMovies
                )
            )
            self?.onUpdate?()
        }
    }

    private func fetchNowPlaying() {
        service.fetchMovies(endpoint: .nowPlayingMovies) { [weak self] movies in
            self?.items.append(
                HomeModel(
                    title: "Now Playing",
                    movies: movies,
                    endpoint: .nowPlayingMovies
                )
            )
            self?.onUpdate?()
        }
    }

    private func fetchUpcoming() {
        service.fetchMovies(endpoint: .upcomingMovies) { [weak self] movies in
            self?.items.append(
                HomeModel(
                    title: "Upcoming",
                    movies: movies,
                    endpoint: .upcomingMovies
                )
            )
            self?.onUpdate?()
        }
    }

    private func fetchPopular() {
        service.fetchMovies(endpoint: .popularMovies) { [weak self] movies in
            self?.items.append(
                HomeModel(
                    title: "Popular",
                    movies: movies,
                    endpoint: .popularMovies
                )
            )
            self?.onUpdate?()
        }
    }

    private func fetchTopRated() {
        service.fetchMovies(endpoint: .topRatedMovies) { [weak self] movies in
            self?.items.append(
                HomeModel(
                    title: "Top Rated",
                    movies: movies,
                    endpoint: .topRatedMovies
                )
            )
            self?.onUpdate?()
        }
    }
}
