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
    var currentSelectedIndex: Int
    
    //private var tempSelectedIndex: Int
    
    required init(foodData: LocalFoodData, currentSelectedIndex: Int) {
        self.foodData = foodData
        self.currentSelectedIndex = currentSelectedIndex
        //self.tempSelectedIndex = selectedIndex
    }
    
    func viewDidLoad() {
        self.view?.displayUI()
    }
    
    func numberOfItemsIn(section: Int) -> Int {
        guard let cards = self.foodData.card else { return 0 }
        return cards.count
    }
    
    func getFoodItemAt(indexPath: IndexPath) -> Card {
        guard let cards = self.foodData.card else { return Card(cardType: .invalid) }
        return cards[indexPath.item]
    }
    
    func getSelectedCoverImageUrl() -> String? {
        guard let cards = self.foodData.card else { return "" }
        let card = cards[self.currentSelectedIndex]
        return card.cardImage
    }
    
    func selectedCard(atIndex indexPath: IndexPath) {
        guard let cards = self.foodData.card, self.currentSelectedIndex != indexPath.item else { return }
        cards[self.currentSelectedIndex].isExpanded = false
        self.currentSelectedIndex = indexPath.item
        cards[self.currentSelectedIndex].isExpanded = true
        self.view?.displayUI()
        self.view?.reloadTableView()
    }
    
    func numberOfPages() -> Int {
        guard let cards = self.foodData.card else { return 0 }
        return cards.count
    }
    
    func getHeaderText() -> String {
        return "\(self.foodData.headerDetails?.title ?? "") \(self.foodData.headerDetails?.city ?? "")"
    }
    
    deinit {
        guard let cards = self.foodData.card else { return }
        cards[self.currentSelectedIndex].isExpanded = false
    }
}
