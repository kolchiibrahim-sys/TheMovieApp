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

    private let key = "favorite_movie_ids"

    private var favoriteIds: Set<Int> {
        get {
            let array = UserDefaults.standard.array(forKey: key) as? [Int] ?? []
            return Set(array)
        }
        set {
            UserDefaults.standard.set(Array(newValue), forKey: key)
        }
    }

    func isFavorite(id: Int) -> Bool {
        favoriteIds.contains(id)
    }

    func toggle(id: Int) {
        var ids = favoriteIds
        if ids.contains(id) {
            ids.remove(id)
        } else {
            ids.insert(id)
        }
        favoriteIds = ids
    }

    func allIds() -> [Int] {
        Array(favoriteIds)
    }
}
