//
//  PhotosViewModel.swift
//  Boosta
//
//  Created by Salah  on 22/04/2022.
//

import Foundation
import RxSwift
import RxCocoa


class PhotosViewModel{

    var shownPhotos : PublishSubject<[Photo]> = PublishSubject()
    var allPhotos: Photos = []

    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    
    func getPhotos(_ id:Int){
        networkManager.fetchPhotos(albumID: id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.shownPhotos.onNext(response)
                self.allPhotos = response
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func searchBarUpdated(_ query:String){
        var a:[Photo] = []
        a.append(contentsOf: allPhotos)
        var filteredData = allPhotos.filter({ (photo) -> Bool in
            return (photo.title.range(of: query, options: .caseInsensitive, range: nil, locale: nil) != nil)
        })
        filteredData = query.isEmpty ? allPhotos : filteredData
        shownPhotos.onNext(filteredData)

    }
        
}
