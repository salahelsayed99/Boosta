//
//  NetworkManager.swift
//  Boosta
//
//  Created by Salah  on 22/04/2022.
//

import Foundation
import Moya

protocol Networkable {
    var provider: MoyaProvider<UserService> { get }
    func fetchUser(completion: @escaping (Result<User, Error>) -> ())
    func fetchAlbums(userID: Int, completion: @escaping (Result<[AlbumElement], Error>) -> ())
    func fetchPhotos(albumID: Int, completion: @escaping (Result<Photos, Error>) -> ())
}

class NetworkManager: Networkable {
    var provider = MoyaProvider<UserService>(plugins: [NetworkLoggerPlugin()])

    func fetchUser(completion: @escaping (Result<User, Error>) -> ()) {
        request(target: .getUser, completion: completion)
    }
    
    func fetchAlbums(userID: Int, completion: @escaping (Result<Album, Error>) -> ()) {
        request(target: .getAlbums(userID: userID), completion: completion)
    }

    func fetchPhotos(albumID: Int, completion: @escaping (Result<Photos, Error>) -> ()) {
        request(target: .getPhotos(albumID: albumID), completion: completion)
    }

    
}

private extension NetworkManager {
    private func request<T: Decodable>(target: UserService, completion: @escaping (Result<T, Error>) -> ()) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

