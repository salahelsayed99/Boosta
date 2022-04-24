//
//  ProfileViewModel.swift
//  Boosta
//
//  Created by Salah  on 22/04/2022.
//

import Foundation
import RxSwift
import RxCocoa


class ProfileViewModel{
    
    let name : PublishSubject<String> = PublishSubject()
    let address : PublishSubject<String> = PublishSubject()
    let albums : PublishSubject<Album> = PublishSubject()
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    
    func getFirstUser(){
        networkManager.fetchUser { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.name.onNext(response.name)
                let fullAddress = "\(response.address.street),\(response.address.suite),\(response.address.city),\(response.address.zipcode)"
                self.address.onNext(fullAddress)
                self.getAlbums(response.id)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getAlbums(_ id:Int){
        networkManager.fetchAlbums(userID: id){ [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
            self.albums.onNext(response)
            case .failure(let error):
                print(error)
            }

        }
    }
    
}
