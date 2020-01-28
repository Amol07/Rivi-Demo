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
        var tempResponse = response
        tempResponse.card?.sort(by: { $0.cardNo ?? 0 < $1.cardNo ?? 0 })
        self.presenter?.didFetch(response: tempResponse)
    }
    
    func failedWith(error: CustomError?) {
        self.presenter?.failedWith(error: error)
    }
}
