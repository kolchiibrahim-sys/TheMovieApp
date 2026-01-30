//
//  CoreHelper.swift
//  TheMovieApp
//
//  Created by Kolchı Ibrahım on 31.01.26.
//

import Foundation
import Alamofire

enum EncodingType {
    case url, json
}

class CoreHelper {
    static let shared = CoreHelper()
    
    private let version = "3"
    private let baseURL = "https://api.themoviedb.org/"
    
    private let imageSize = "w500"
    private let imageBaseURL = "https://image.tmdb.org/t/p/"
    
    let headers: HTTPHeaders = [
        "accept": "application/json",
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlMjI1MzQxNmZhYzBjZDI0NzYyOTFlYjMzYzkyYmViNyIsIm5iZiI6MTY0ODYyMDAzNC4xNTgwMDAyLCJzdWIiOiI2MjQzZjIwMmM1MGFkMjAwNWNkZTk1ZjAiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.xs9Bib0qWPDMeB9YXyPkYa4CzmQ5W4-N6rgdaLRPlZc"
    ]
    
    func configureURL(endpoint: String) -> String {
        baseURL + version + "/" + endpoint
    }
    
    func configureImageURL(path: String) -> String {
        imageBaseURL + imageSize + path
    }
}
