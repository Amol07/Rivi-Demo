//
//  FoodDetailsTableViewCell.swift
//  Rivi Demo
//
//  Created by Amol Prakash on 29/01/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

class FoodDetailsTableViewCell: FoodTableViewCell, NibLoadable {
    
    @IBOutlet private weak var parentStackView: UIStackView!
    @IBOutlet private weak var detailContainerView: FoodDetailsView!
    @IBOutlet private weak var detailContainerStackView: UIStackView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.detailContainerView.isHidden = true
    }
    
    override func configure(forCard card: FoodConfigurable) {
        super.configure(forCard: card)
        super.displaySeprator(isExpanded: card.isExpanded)
        if card.isExpanded {
            self.detailContainerView.isHidden = false
            self.detailContainerView.configureViews(foodDetails: card.cardDetails!)
        } else {
            self.detailContainerView.isHidden = true
        }
        super.updateContainerView()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
}
