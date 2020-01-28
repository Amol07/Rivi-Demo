//
//  FoodDetailsPresenter.swift
//  Rivi Demo
//
//  Created by Amol Prakash on 29/01/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

class FoodDetailsPresenter: FoodDetailsPresenterProtocol {    
    weak var view: FoodDetailsViewProtocol?
    var foodData: LocalFoodData
    var selectedIndex: Int
    
    required init(foodData: LocalFoodData, selectedIndex: Int) {
        self.foodData = foodData
        self.selectedIndex = selectedIndex
    }
    
    func viewDidLoad() {
        
    }
}
