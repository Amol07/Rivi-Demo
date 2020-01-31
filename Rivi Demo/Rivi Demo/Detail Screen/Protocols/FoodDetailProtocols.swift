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
    func displayUI()
    func reloadTableView(withIndicies indicies: [IndexPath])
}

// View to Presenter
protocol FoodDetailsPresenterProtocol: AnyObject {
    var view: FoodDetailsViewProtocol? { get set }
    var foodData: FoodDataViewModel { get set }
    var currentSelectedIndex: Int { get set }
   
    init(foodData: FoodDataViewModel, currentSelectedIndex: Int)
    func viewDidLoad()
    func numberOfItemsIn(section: Int) -> Int
    func getFoodItemAt(indexPath: IndexPath) -> FoodConfigurable
    func getHeaderText() -> String
    func getSelectedCoverImageUrl() -> String?
    func numberOfPages() -> Int
    func selectedCard(atIndex indexPath: IndexPath)
}
