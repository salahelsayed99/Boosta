//
//  Albums.swift
//  Boosta
//
//  Created by Salah  on 22/04/2022.
//


import Foundation

// MARK: - AlbumElement
struct AlbumElement: Codable {
    let userID, id: Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title
    }
}

typealias Album = [AlbumElement]
