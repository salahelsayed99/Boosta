//
//  APIManager.swift
//  Boosta
//
//  Created by Salah  on 21/04/2022.
//

import Foundation
import Moya


enum UserService {
    case getUser
    case getAlbums(userID: Int)
    case getPhotos(albumID:Int)
}


extension UserService:TargetType{
    var baseURL: URL {
        return URL.init(string:Constants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getUser:
            return "users/1"
        case .getAlbums(_):
            return "albums"
        case .getPhotos(_):
            return "photos"

        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getUser:
            return .get
        case .getAlbums(_),.getPhotos(_):
            return .get
        }

    }
    
    var sampleData: Data{
        switch self {
        case .getUser:
            return Data()
        case .getAlbums(userID: let userID):
            return "{'userId':'\(userID)'}".data(using: .utf8)!
        case .getPhotos(albumID: let albumID):
            return "{'albumId':'\(albumID)'}".data(using: .utf8)!

        }

    }
    
    var task: Task {
        switch self {
        case .getUser:
            return .requestPlain
        case .getAlbums(userID: let userID):
            return .requestParameters(parameters: ["userId":userID], encoding: URLEncoding.default)
        case .getPhotos(albumID: let albumID):
            return .requestParameters(parameters: ["albumId":albumID], encoding: URLEncoding.default)
        }

    }
    
    var headers: [String : String]? {
        return ["Content-Typer":"application/json"]
    }
    
    
}
