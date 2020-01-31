//
//  CollectionViewDataSource.swift
//  Rivi Demo
//
//  Created by Amol Prakash on 31/01/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

class CollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var dataSource: [String] = [String]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let url = self.dataSource[indexPath.item]
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: PhotosCollectionViewCell.self)
        cell.comfigure(imgUrl: url)
        return cell
    }
}

extension CollectionViewDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 70)
    }
}
