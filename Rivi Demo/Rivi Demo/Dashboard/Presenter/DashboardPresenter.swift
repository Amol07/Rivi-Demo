//
//  DashboardPresenter.swift
//  Rivi Demo
//
//  Created by Amol Prakash on 28/01/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

class DashboardPresenter: DashboardPresenterProtocol {
    weak var view: DashboardViewProtocol?
    var interactor: DashboardInteractorInputProtocol?
    var router: DashboardRouterProtocol?
    
    var isExpanded: Bool = false
    
    private var maxCardToShowCount: Int = 2
    private var expandedDataSource: [FoodConfigurable] = [FoodConfigurable]()
    private var contractedDataSource: [FoodConfigurable] = [FoodConfigurable]()
    private var foodViewModel: FoodDataViewModel?
    private var dataSource: [FoodConfigurable] {
        if self.isExpanded {
            return self.expandedDataSource
        } else {
            return self.contractedDataSource
        }
    }
    
    func viewDidLoad() {
        self.interactor?.getLocalFoodData()
    }
    
    func numberOfItemsIn(section: Int) -> Int {
        return self.dataSource.count
    }
    
    func getFoodItemAt(indexPath: IndexPath) -> FoodConfigurable {
        return self.dataSource[indexPath.item]
    }
    
    func didSelectFoodItem(at indexPath: IndexPath) {
        guard let foodVm = self.foodViewModel else {
            return
        }
        foodVm.foodArray?[indexPath.row].isExpanded = true
        self.router?.presentFoodDetailScreen(from: self.view, forIndex: indexPath.row, andDetail: foodVm)
    }
    
    func getHeaderText() -> String {
        guard let foodVm = self.foodViewModel else {
            return ""
        }
        return "\(foodVm.foodHeaderDetails?.title ?? "") \(foodVm.foodHeaderDetails?.city ?? "")"
    }
    
    private func createExpandedDataSource(forCards cards: [FoodConfigurable]?) {
        guard var card = cards else {
            return
        }
        let showLessCard = Card(cardType: .show)
        showLessCard.title = "SHOW LESS"
        let showLessVm = FoodViewModel(model: showLessCard)
        card.append(showLessVm)
        self.expandedDataSource = card
    }
    
    private func createContractedDataSource(forCards cards: [FoodConfigurable]?) {
        guard let card = cards else {
            return
        }
        if card.count > self.maxCardToShowCount {
            let showMoreCard = Card(cardType: .show)
            showMoreCard.title = "SHOW MORE"
            let showMoreVm = FoodViewModel(model: showMoreCard)
            let slice = card.prefix(self.maxCardToShowCount)
            var card = Array(slice)
            card.append(showMoreVm)
            self.contractedDataSource = card
        } else {
            self.contractedDataSource = card
        }
    }
}

extension DashboardPresenter: DashboardInteractorOutputProtocol {
    
    func didFetch(response: LocalFoodData) {
        self.foodViewModel = FoodDataViewModel(model: response)
        self.createExpandedDataSource(forCards: self.foodViewModel?.foodArray)
        self.createContractedDataSource(forCards: self.foodViewModel?.foodArray)
        self.view?.loadingFinished()
    }
    
    func failedWith(error: CustomError?) {
        self.view?.failed(withError: error)
    }
}
