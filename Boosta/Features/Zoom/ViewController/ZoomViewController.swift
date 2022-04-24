//
//  ZoomViewController.swift
//  Boosta
//
//  Created by Salah  on 23/04/2022.
//

import UIKit
import Kingfisher

class ZoomViewController: UIViewController {

    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var url:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setShareButton()
    }
    
    func setShareButton(){
        let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(systemName: Constants.shareIcon), style: .plain, target: self, action: #selector(shareAction))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func shareAction(){
            ShareUtility.share(self.image.image as AnyObject, inViewController: self)
    }

    
    func setUpUI(){
        scrollView.minimumZoomScale = Constants.minZoomScale
        scrollView.maximumZoomScale = Constants.maxZoomScale
        image.kf.setImage(with: URL(string: url ?? ""))
    }
    
}

extension ZoomViewController:UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return image
    }
}
