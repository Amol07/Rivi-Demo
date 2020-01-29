//
//  ShowMoreTableViewCell.swift
//  Rivi Demo
//
//  Created by Amol Prakash on 29/01/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

class ShowMoreTableViewCell: UITableViewCell, Reusable {
    @IBOutlet private weak var titleLabel: UILabel!
    
    func configure(forCard card: Card) {
        self.titleLabel.text = card.title
    }
}
