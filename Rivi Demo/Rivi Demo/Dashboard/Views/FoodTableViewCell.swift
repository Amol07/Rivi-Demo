//
//  FoodTableViewCell.swift
//  Rivi Demo
//
//  Created by Amol Prakash on 29/01/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

class FoodTableViewCell: UITableViewCell, Reusable {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var foodImageView: UIImageView! {
        didSet {
            self.foodImageView.layer.cornerRadius = 5.0
        }
    }
    @IBOutlet private weak var sepratorView: UIView!
    
    func configure(forCard card: Card) {
        self.titleLabel.text = card.title
        self.descriptionLabel.text = card.description
        self.foodImageView.setImage(with: card.cardImage, placeHolder: UIImageView.placeHolderImage)
    }
    
    // Methods for details food cell.
    
    func displaySeprator(isExpanded: Bool) {
        isExpanded ? (self.sepratorView.isHidden =  false) :( self.sepratorView.isHidden =  true)
    }
    
    func updateContainerView() {
        self.containerView.layer.cornerRadius = 5
    }
}
