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
    var foodData: FoodDataViewModel
    var currentSelectedIndex: Int
    
    //private var tempSelectedIndex: Int
    
    required init(foodData: FoodDataViewModel, currentSelectedIndex: Int) {
        self.foodData = foodData
        self.currentSelectedIndex = currentSelectedIndex
        //self.tempSelectedIndex = selectedIndex
    }
    
    func viewDidLoad() {
        self.view?.displayUI()
    }
    
    func numberOfItemsIn(section: Int) -> Int {
        guard let foodArray = self.foodData.foodArray else { return 0 }
        return foodArray.count
    }
    
    func getFoodItemAt(indexPath: IndexPath) -> FoodConfigurable {
        guard let foodArray = self.foodData.foodArray else { return FoodViewModel(model: Card(cardType: .invalid)) }
        return foodArray[indexPath.item]
    }
    
    func getSelectedCoverImageUrl() -> String? {
        guard let foodArray = self.foodData.foodArray else { return "" }
        let food = foodArray[self.currentSelectedIndex]
        return food.imageUrl
    }
    
    func selectedCard(atIndex indexPath: IndexPath) {
        guard var foodArray = self.foodData.foodArray, self.currentSelectedIndex != indexPath.item else { return }
        foodArray[self.currentSelectedIndex].isExpanded = false
        var indicies = [IndexPath(item: self.currentSelectedIndex, section: 0)]
        self.currentSelectedIndex = indexPath.item
        indicies.append(indexPath)
        foodArray[self.currentSelectedIndex].isExpanded = true
        self.view?.displayUI()
        self.view?.reloadTableView(withIndicies: indicies)
    }
    
    func numberOfPages() -> Int {
        guard let foodArray = self.foodData.foodArray else { return 0 }
        return foodArray.count
    }
    
    func getHeaderText() -> String {
        return "\(self.foodData.foodHeaderDetails?.title ?? "") \(self.foodData.foodHeaderDetails?.city ?? "")"
    }
    
    deinit {
        guard var foodArray = self.foodData.foodArray else { return }
        foodArray[self.currentSelectedIndex].isExpanded = false
    }
}
