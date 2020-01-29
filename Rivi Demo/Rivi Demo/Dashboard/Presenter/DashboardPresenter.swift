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
    
    private var maxCardToShowCount: Int = 3
    private var expandedDataSource: [Card] = [Card]()
    private var contractedDataSource: [Card] = [Card]()
    private var foodData: LocalFoodData?
    private var dataSource: [Card] {
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
    
    private func createExpandedDataSource(forCards cards: [Card]?) {
        guard var card = cards else {
            return
        }
        var showLessCard = Card(cardType: .show)
        showLessCard.title = "SHOW LESS"
        card.append(showLessCard)
        self.expandedDataSource = card
    }
    
    private func createContractedDataSource(forCards cards: [Card]?) {
        guard let card = cards else {
            return
        }
        if card.count > self.maxCardToShowCount {
            var showMoreCard = Card(cardType: .show)
            showMoreCard.title = "SHOW MORE"
            let slice = card.prefix(self.maxCardToShowCount)
            var card = Array(slice)
            card.append(showMoreCard)
            self.contractedDataSource = card
        } else {
            self.contractedDataSource = card
        }
    }
}

extension DashboardPresenter: DashboardInteractorOutputProtocol {
    
    func didFetch(response: LocalFoodData) {
        self.foodData = response
        self.createExpandedDataSource(forCards: response.card)
        self.createContractedDataSource(forCards: response.card)
        self.view?.loadingFinished()
    }
    
    func failedWith(error: CustomError?) {
        self.view?.failed(withError: error)
    }
}
