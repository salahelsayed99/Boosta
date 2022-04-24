//
//  ProfileViewController.swift
//  Boosta
//
//  Created by Salah  on 22/04/2022.
//

import UIKit
import RxSwift
import RxCocoa

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var address: UILabel!
    
    @IBOutlet weak var myAlbumLabel: UILabel!
    
    @IBOutlet weak var profileTableView: UITableView!
    
    private let viewModel = ProfileViewModel()
    private let disposeBag = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setUpBinding()
    }
    
    func setUpTableView(){
        profileTableView.register(UINib(nibName: Constants.profileCell, bundle: nil), forCellReuseIdentifier: Constants.profileCell)
        profileTableView.backgroundColor = .white        
    }
    
    func setUpBinding(){
        viewModel.name.bind(to: name.rx.text).disposed(by: disposeBag)
        viewModel.address.bind(to: address.rx.text).disposed(by: disposeBag)
        viewModel.albums.bind(to: profileTableView.rx.items(cellIdentifier: Constants.profileCell, cellType: ProfileCell.self)) {  (row,album,cell) in
            cell.albumName.text = album.title
            }
        .disposed(by: disposeBag)
        profileTableView
            .rx
            .modelAndIndexSelected(AlbumElement.self)
            .subscribe(onNext: {[weak self] (model, index) in
                self?.profileTableView.deselectRow(at: index, animated: true)
                self?.goToPhotosVC(id: model.id, title: model.title)
            }).disposed(by: disposeBag)
        viewModel.getFirstUser()
    }
    
    
    func goToPhotosVC(id:Int,title:String){
        let storyBoard = UIStoryboard(name: Constants.storyBoardName, bundle: nil)
        let destinationVC = storyBoard.instantiateViewController(withIdentifier: Constants.photoViewControllerIdentifier) as! PhotosViewController
        destinationVC.albumId = id
        destinationVC.navigationTitle = title
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }

}
