//
//  PhotoCell.swift
//  Boosta
//
//  Created by Salah  on 23/04/2022.
//

import UIKit
import Kingfisher

class PhotoCell: UICollectionViewCell {

    @IBOutlet weak var photo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

     var album: Photo! {
        didSet {
            self.photo.kf.setImage(with: URL(string: album.url))
        }
    }

    
    
}
