//
//  FeedModel.swift
//  rickandmorty
//
//  Created by Pavel Kozlov on 11.02.2021.
//

import Foundation

struct Feed: Codable {
    let info: Info
    let results: [Character]
}

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct Character: Codable {
    let id: Int
    let name: String
    let status: String //enum will be best
    let species: String
    let type: String //enum will be best
    let gender: String
    let origin: Origin
    let location: Origin
    let image: String
    let episode: [String]
    let url: String
    let created: String // formatter
}

struct Origin: Codable {
    let name: String
    let url: String
}
