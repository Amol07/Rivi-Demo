//
//  SelfSizedTableView.swift
//  Rivi Demo
//
//  Created by Amol Prakash on 29/01/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

class SelfSizedTableView: UITableView {
    var maxHeight: CGFloat {
        let y = self.superview?.frame.origin.y ?? 0 + self.frame.origin.y + 20
        return UIScreen.main.bounds.height - y
    }
    
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
    }
    
    override var intrinsicContentSize: CGSize {
        self.setNeedsLayout()
        self.layoutIfNeeded()
        let height = min(self.contentSize.height, self.maxHeight)
        return CGSize(width: self.contentSize.width, height: height)
    }
}
