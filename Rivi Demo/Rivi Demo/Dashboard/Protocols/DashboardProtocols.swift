//
//  DashboardProtocols.swift
//  Rivi Demo
//
//  Created by Amol Prakash on 28/01/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation
import UIKit

// Presenter to View
protocol DashboardViewProtocol: AnyObject {
    var presenter: DashboardPresenterProtocol? { get set }
    
    func loadingFinished()
    func failed(withError error: CustomError?)
}

// View to Presenter
protocol DashboardPresenterProtocol: AnyObject {
    var view: DashboardViewProtocol? { get set }
    var interactor: DashboardInteractorInputProtocol? { get set }
    var router: DashboardRouterProtocol? { get set }
    
    func viewDidLoad()
    func getLocalFoodData()
    func numberOfItemsIn(section: Int) -> Int
    func getFoodItemAt(indexPath: IndexPath) -> Card
    func didSelectFoodItem(at indexPath: IndexPath)
}

// Presenter to Interactor
protocol DashboardInteractorInputProtocol: AnyObject {
    var presenter: DashboardInteractorOutputProtocol? { get set }
    var fetcher: DashboardFetcherInputProtocol? { get set }
    
    func getLocalFoodData()
}

// Interactor to Presenter
protocol DashboardInteractorOutputProtocol: AnyObject {
    func didFetch(response: LocalFoodData)
    func failedWith(error: CustomError?)
}

// Interactor to Fetcher
protocol DashboardFetcherInputProtocol: AnyObject {
    var interactor: DashboardFetcherOutputProtocol? { get set }
    func getLocalFoodData()
}

// Fetcher to Interactor
protocol DashboardFetcherOutputProtocol: AnyObject {
    func didFetchLocalFoodData(response: LocalFoodData)
    func failedWith(error: CustomError?)
}

// Presenter to Router
protocol DashboardRouterProtocol {
    static func createFoodDashboardModule() -> UIViewController
    static func createFoodDetailModule(withIndex foodIndex: Int, foodDetail: LocalFoodData) -> UIViewController
    func presentFoodDetailScreen(from view: DashboardViewProtocol?, forIndex selectedIndex: Int, andDetail foodDetail: LocalFoodData)

}
