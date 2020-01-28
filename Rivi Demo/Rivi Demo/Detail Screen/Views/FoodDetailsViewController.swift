//
//  FoodDetailsViewController.swift
//  Rivi Demo
//
//  Created by Amol Prakash on 29/01/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

class FoodDetailsViewController: UIViewController {
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
