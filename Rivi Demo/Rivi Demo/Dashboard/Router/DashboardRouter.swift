//
//  DashboardRouter.swift
//  Rivi Demo
//
//  Created by Amol Prakash on 28/01/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation
import UIKit

var mainStoryboard: UIStoryboard {
    return UIStoryboard(name: "Main", bundle: Bundle.main)
}

class DashboardRouter: DashboardRouterProtocol {
    
    static func createFoodDashboardModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "DashboardNavigationViewController")
        if let view = navController.children.first as? DashboardViewController {
            let presenter: DashboardPresenterProtocol & DashboardInteractorOutputProtocol = DashboardPresenter()
            let interactor: DashboardInteractorInputProtocol & DashboardFetcherOutputProtocol = DashboardInteractor()
            let remoteDataFetcher: DashboardFetcherInputProtocol = DashboardFetcher()
            let router: DashboardRouterProtocol = DashboardRouter()
            
            view.presenter = presenter
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.fetcher = remoteDataFetcher
            remoteDataFetcher.interactor = interactor
            return navController
        }
        return UIViewController()
    }
    
    static func createFoodDetailModule(withIndex selectedIndex: Int, foodDetail: LocalFoodData) -> UIViewController {
        if let view = mainStoryboard.instantiateViewController(withIdentifier: "FoodDetailsViewController") as? FoodDetailsViewController {
            let presenter: FoodDetailsPresenterProtocol = FoodDetailsPresenter(foodData: foodDetail, currentSelectedIndex: selectedIndex)
            view.presenter = presenter
            presenter.view = view
            return view
        }
        return FoodDetailsViewController()
    }
    
    func presentFoodDetailScreen(from view: DashboardViewProtocol?, forIndex selectedIndex: Int, andDetail foodDetail: LocalFoodData) {
        let detailVc = type(of: self).createFoodDetailModule(withIndex: selectedIndex, foodDetail: foodDetail)
        if let view = view as? UIViewController {
            view.navigationController?.present(detailVc, animated: true, completion: nil)
        }
    }
}
