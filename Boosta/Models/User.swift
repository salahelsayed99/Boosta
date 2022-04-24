//
//  User.swift
//  Boosta
//
//  Created by Salah  on 21/04/2022.
//

import Foundation

// MARK: - User
struct User: Codable {
    let id: Int
    let name:String
    let address: Address
}

// MARK: - Address
struct Address: Codable {
    let street, suite, city, zipcode: String
}

