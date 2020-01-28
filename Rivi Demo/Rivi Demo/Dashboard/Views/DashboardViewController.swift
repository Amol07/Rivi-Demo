//
//  DashboardViewController.swift
//  Rivi Demo
//
//  Created by Amol Prakash on 28/01/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    var presenter: DashboardPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
    }
}

extension DashboardViewController: DashboardViewProtocol {
    
    func loadingFinished() {
        
    }
    
    func failed(withError error: CustomError?) {
        
    }
}
