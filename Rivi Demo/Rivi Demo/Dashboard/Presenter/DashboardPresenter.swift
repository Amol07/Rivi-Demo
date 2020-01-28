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
    
    private var foodData: LocalFoodData?
    
    func viewDidLoad() {
        self.interactor?.getLocalFoodData()
    }
    
    func numberOfItemsIn(section: Int) -> Int {
        guard let card = self.foodData?.card else {
            return 0
        }
        return card.count
    }
    
    func getFoodItemAt(indexPath: IndexPath) -> Card {
        guard let card = self.foodData?.card else {
            return Card()
        }
        return card[indexPath.item]
    }
    
    func didSelectFoodItem(at indexPath: IndexPath) {
        guard let foodData = self.foodData else {
            return
        }
        self.router?.presentFoodDetailScreen(from: self.view, forIndex: indexPath.row, andDetail: foodData)
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
