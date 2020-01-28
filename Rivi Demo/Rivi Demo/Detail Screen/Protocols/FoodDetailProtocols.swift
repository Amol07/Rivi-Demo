//
//  FoodDetailProtocols.swift
//  Rivi Demo
//
//  Created by Amol Prakash on 29/01/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

protocol FoodDetailsViewProtocol: AnyObject {
    var presenter: FoodDetailsPresenterProtocol? { get set }
    func displayUI(for foodData: LocalFoodData?)
}

// View to Presenter
protocol FoodDetailsPresenterProtocol: AnyObject {
    var view: FoodDetailsViewProtocol? { get set }
    var foodData: LocalFoodData { get set }
    var selectedIndex: Int { get set }
   
    init(foodData: LocalFoodData, selectedIndex: Int)
    func viewDidLoad()
}
