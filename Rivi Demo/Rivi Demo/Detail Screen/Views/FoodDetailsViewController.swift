//
//  FoodDetailsViewController.swift
//  Rivi Demo
//
//  Created by Amol Prakash on 29/01/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

class FoodDetailsViewController: UIViewController {
    @IBOutlet private weak var curatedLabel: UILabel!
    @IBOutlet private weak var headerLabel: UILabel!
    @IBOutlet private weak var coverImageView: UIImageView! {
        didSet {
            self.coverImageView.layer.borderColor = UIColor.clear.cgColor
            self.coverImageView.layer.cornerRadius = 5.0
        }
    }
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var tableView: UITableView!
    
    var presenter: FoodDetailsPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension FoodDetailsViewController: FoodDetailsViewProtocol {
    
    func displayUI(for foodData: LocalFoodData?) {
        
    }
}

extension FoodDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "FoodDetailCell", for: indexPath)
    }
}

