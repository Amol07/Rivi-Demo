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
    
    func viewDidLoad() {
        self.getLocalFoodData()
    }
    
    func getLocalFoodData() {
        self.interactor?.getLocalFoodData()
    }
}

extension DashboardPresenter: DashboardInteractorOutputProtocol {
    
    func didFetch(response: LocalFoodData) {
        self.view?.loadingFinished()
    }
    
    func failedWith(error: CustomError?) {
        self.view?.failed(withError: error)
    }
}
