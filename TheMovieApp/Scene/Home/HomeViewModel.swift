//
//  HomeViewModel.swift
//  TheMovieApp
//
//  Created by Kolchı Ibrahım on 31.01.26.
//

import Foundation

struct HomeModel {
    let title: String
    let items: [MovieResult]
}

final class HomeViewModel {
    var items = [HomeModel]()
    
    let manager = CoreManager()
    
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    
    func getMovies() {
        getNowPlayingMovies()
        getPopularMovies()
        getUpcomingMovies()
        getTopRatedMovies()
    }
    
    private func getNowPlayingMovies() {
        manager.request(model: Movie.self,
                        endpoint: "movie/now_playing") { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
            } else if let data {
                self.items.append(.init(title: "Now Playing",
                                        items: data.results ?? []))
                self.success?()
            }
        }
    }
    
    private func getPopularMovies() {
        manager.request(model: Movie.self,
                        endpoint: "movie/popular") { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
                } else if let data {
                self.items.append(.init(title: "Popular",
                                        items: data.results ?? []))
                self.success?()
            }
        }
    }
    
    private func getTopRatedMovies() {
        manager.request(model: Movie.self,
                        endpoint: "movie/top_rated") { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
            } else if let data {
                self.items.append(.init(title: "Top Rated",
                                        items: data.results ?? []))
                self.success?()
            }
        }
    }
    
    private func getUpcomingMovies() {
        manager.request(model: Movie.self,
                        endpoint: "movie/upcoming") { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
            } else if let data {
                self.items.append(.init(title: "Upcoming",
                                        items: data.results ?? []))
                self.success?()
            }
        }
    }
}
