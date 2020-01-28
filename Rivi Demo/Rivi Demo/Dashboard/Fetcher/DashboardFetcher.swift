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
        ApiClient<[String: LocalFoodData]>.makeRequest(toURL: Endpoints.Food.fetch.url) { [weak self] response, error in
            guard let response = response, let data = response["data"] else {
                self?.interactor?.failedWith(error: error)
                return
            }
            self?.interactor?.didFetchLocalFoodData(response: data)
        }
    }
}
