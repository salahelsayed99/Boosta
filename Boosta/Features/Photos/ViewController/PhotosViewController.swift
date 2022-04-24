//
//  PhotosViewController.swift
//  Boosta
//
//  Created by Salah  on 22/04/2022.
//

import UIKit
import RxSwift
import RxCocoa

class PhotosViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var photosCollectionView: UICollectionView!
    private let viewModel = PhotosViewModel()
    private let disposeBag = DisposeBag()
    
    var albumId:Int?{
        didSet{
            viewModel.getPhotos(albumId ?? 0)
        }
    }
    
    var navigationTitle:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        setUpBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = navigationTitle
    }
    
    
    func setUpCollectionView(){
        photosCollectionView.register(UINib(nibName: Constants.photoCell, bundle: nil), forCellWithReuseIdentifier:Constants.photoCell)
        var flowLayout: UICollectionViewFlowLayout {
            let _flowLayout = UICollectionViewFlowLayout()
            _flowLayout.itemSize = CGSize(width: photosCollectionView.frame.size.width / 3, height: 130)
            _flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            _flowLayout.scrollDirection = .vertical
            _flowLayout.minimumInteritemSpacing = 0.0
            _flowLayout.minimumLineSpacing = 0.0
            return _flowLayout
        }
        photosCollectionView.collectionViewLayout = flowLayout
    }
    
    func setUpBinding(){
        viewModel.shownPhotos.bind(to: photosCollectionView.rx.items(cellIdentifier: Constants.photoCell, cellType: PhotoCell.self)) {  (row,album,cell) in
            cell.album = album
            }
        .disposed(by: disposeBag)
        
        photosCollectionView
            .rx
            .modelAndIndexSelected(Photo.self)
            .subscribe(onNext: {[weak self] (model, index) in
                self?.goToZoomVC(image: model.url)
            }).disposed(by: disposeBag)
        
        searchBar
            .rx.text
            .orEmpty
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [unowned self] query in
                viewModel.searchBarUpdated(query)
            })
            .disposed(by: disposeBag)

        
    }

    func goToZoomVC(image:String){
        let storyBoard = UIStoryboard(name: Constants.storyBoardName, bundle: nil)
        let destinationVC = storyBoard.instantiateViewController(withIdentifier: Constants.zoomViewControllerIdentifier) as! ZoomViewController
        destinationVC.url = image
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
}

