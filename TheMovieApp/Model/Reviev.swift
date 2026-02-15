//
//  Reviev.swift
//  TheMovieApp
//
//  Created by Ibrahim Kolchi on 15.02.26.
//
import Foundation

struct ReviewResponse: Decodable {
    let results: [Review]
}

struct Review: Decodable {
    let id: String
    let author: String
    let content: String
}
