//
//  FavoritesManager.swift
//  TheMovieApp
//
//  Created by Kolchı Ibrahım on 10.02.26.
//
import Foundation

final class FavoritesManager {

    static let shared = FavoritesManager()
    private init() {}

    private let key = "favorite_movies"

    private var favorites: Set<Int> {
        get {
            let array = UserDefaults.standard.array(forKey: key) as? [Int] ?? []
            return Set(array)
        }
        set {
            UserDefaults.standard.set(Array(newValue), forKey: key)
        }
    }

    func toggle(id: Int) {
        var favs = favorites

        if favs.contains(id) {
            favs.remove(id)
        } else {
            favs.insert(id)
        }

        favorites = favs
    }

    func isFavorite(id: Int) -> Bool {
        favorites.contains(id)
    }

    func getAll() -> [Int] {
        Array(favorites)
    }
}
