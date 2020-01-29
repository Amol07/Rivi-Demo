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
    
    var maxCardToShowCount: Int = 2
    var isExpanded: Bool = false
    
    private var foodData: LocalFoodData?
    private var dataSource: [Card] {
        if self.isExpanded {
            return self.expandedDataSource
        } else {
            return self.contractedDataSource
        }
    }
    
    private var expandedDataSource: [Card] {
        guard var card = self.foodData?.card else {
            return [Card]()
        }
        var showLessCard = Card(cardType: .show)
        showLessCard.title = "SHOW LESS"
        card.append(showLessCard)
        return card
    }
    
    private var contractedDataSource: [Card] {
        guard let card = self.foodData?.card else { return [Card]() }
        if card.count > self.maxCardToShowCount {
            var showMoreCard = Card(cardType: .show)
            showMoreCard.title = "SHOW MORE"
            let slice = card.prefix(self.maxCardToShowCount)
            var card = Array(slice)
            card.append(showMoreCard)
            return card
        } else {
            return card
        }
    }
    
    func viewDidLoad() {
        self.interactor?.getLocalFoodData()
    }
    
    func numberOfItemsIn(section: Int) -> Int {
        return self.dataSource.count
    }
    
    func getFoodItemAt(indexPath: IndexPath) -> Card {
        return self.dataSource[indexPath.item]
    }
    
    func didSelectFoodItem(at indexPath: IndexPath) {
        guard let foodData = self.foodData else {
            return
        }
        self.router?.presentFoodDetailScreen(from: self.view, forIndex: indexPath.row, andDetail: foodData)
    }
    
    func getHeaderText() -> String {
        guard let foodData = self.foodData else {
            return ""
        }
        return "\(foodData.headerDetails?.title ?? "") \(foodData.headerDetails?.city ?? "")"
    }
}

extension DashboardPresenter: DashboardInteractorOutputProtocol {
    
    func didFetch(response: LocalFoodData) {
        self.foodData = response
        self.view?.loadingFinished()
    }
    
    func failedWith(error: CustomError?) {
        self.view?.failed(withError: error)
    }
}
