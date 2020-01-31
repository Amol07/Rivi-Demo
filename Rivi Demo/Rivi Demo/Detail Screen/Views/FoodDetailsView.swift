//
//  FoodDetailsView.swift
//  Rivi Demo
//
//  Created by Amol Prakash on 30/01/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

class FoodDetailsView: UIView {
    @IBOutlet private weak var aboutView: FoodDetailsTitleDescriptionView!
    @IBOutlet private weak var locations: FoodDetailsTitleDescriptionView!
    @IBOutlet private weak var dishes: FoodDetailsTitleDescriptionView!
    @IBOutlet private weak var photoView: FoodPhotoView!
    @IBOutlet private weak var moreView: UIView!
    @IBOutlet private weak var moreLabel: UILabel!
    
    func configureViews(foodDetails: FoodDetailsConfigurable) {
        if let aboutData = foodDetails.about {
            self.aboutView.show(title: aboutData.title, description: aboutData.description)
            self.aboutView.isHidden = false
        } else {
            self.aboutView.isHidden = true
        }
        
        if let dishes = foodDetails.dishes {
            self.dishes.show(title: dishes.title, description: dishes.description)
            self.dishes.isHidden = false
        } else {
            self.dishes.isHidden = true
        }
        
        if let locations = foodDetails.locaction {
            self.locations.show(title: locations.title, description: locations.description)
            self.locations.isHidden = false
        } else {
            self.locations.isHidden = true
        }
        
        if let photo = foodDetails.photos, !photo.photos.isEmpty {
            self.photoView.configure(title: photo.title, photos: photo.photos)
            self.photoView.isHidden = false
        } else {
            self.photoView.isHidden = true
        }
    }
}

class FoodDetailsTitleDescriptionView: UIView {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    func show(title: String, description: NSAttributedString) {
        self.titleLabel.text = title
        self.descriptionLabel.attributedText = description
    }
}

class FoodPhotoView: UIView {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    var collectionDataSource = CollectionViewDataSource()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureFlowLayout()
        self.collectionView.register(cellType: PhotosCollectionViewCell.self)
        self.collectionView.delegate = self.collectionDataSource
        self.collectionView.dataSource = self.collectionDataSource
    }
    
    func configure(title: String, photos: [String]) {
        self.titleLabel.text = title
        self.collectionDataSource.dataSource = photos
        self.collectionView.reloadData()
    }
    
    private func configureFlowLayout() {
        if let layout = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
            layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        }
    }
}
