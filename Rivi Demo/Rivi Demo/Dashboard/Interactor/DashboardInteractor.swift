//
//  DashboardInteractor.swift
//  Rivi Demo
//
//  Created by Amol Prakash on 28/01/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

class DashboardInteractor: DashboardInteractorInputProtocol {
    weak var presenter: DashboardInteractorOutputProtocol?
    var fetcher: DashboardFetcherInputProtocol?
    
    func getLocalFoodData() {
        self.fetcher?.getLocalFoodData()
    }
}

extension DashboardInteractor: DashboardFetcherOutputProtocol {
    
    func didFetchLocalFoodData(response: LocalFoodData) {
        self.presenter?.didFetch(response: response)
    }
    
    func failedWith(error: CustomError?) {
        self.presenter?.failedWith(error: error)
    }
}
