//
//  DashboardFetcher.swift
//  Rivi Demo
//
//  Created by Amol Prakash on 28/01/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

class DashboardFetcher: DashboardFetcherInputProtocol {
    weak var interactor: DashboardFetcherOutputProtocol?
    
    func getLocalFoodData() {
        ApiClient<LocalFoodData>.makeRequest(toURL: Endpoints.Food.fetch.url) { [weak self] response, error in
            guard let response = response else {
                self?.interactor?.failedWith(error: error)
                return
            }
            self?.interactor?.didFetchLocalFoodData(response: response)
        }
    }
}
