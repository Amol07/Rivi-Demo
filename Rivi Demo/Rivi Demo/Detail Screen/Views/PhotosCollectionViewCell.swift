//
//  PhotosCollectionViewCell.swift
//  Rivi Demo
//
//  Created by Amol Prakash on 31/01/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell, Reusable, NibLoadable {

    @IBOutlet private weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imageView.layer.cornerRadius = 5
    }
    
    func comfigure(imgUrl: String) {
        self.imageView.setImage(with: imgUrl, placeHolder: UIImageView.placeHolderImage, completed: nil)
    }
}
