//
//  DashboardViewController.swift
//  Rivi Demo
//
//  Created by Amol Prakash on 28/01/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    
    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    @IBOutlet private weak var contentView: ShadowView!
    @IBOutlet private weak var curatedLabel: UILabel!
    @IBOutlet private weak var headerLabel: UILabel!
    @IBOutlet private weak var tableView: SelfSizedTableView!
    
    var presenter: DashboardPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 60
        self.tableView.rowHeight = UITableView.automaticDimension
        self.title = "Restaurants"
        self.contentView.isHidden = true
        self.presenter?.viewDidLoad()
    }
    
    func setupUI() {
        self.curatedLabel.text = "CURATED FOR MAYANAK"
        self.headerLabel.text = self.presenter?.getHeaderText()
    }
}

extension DashboardViewController: DashboardViewProtocol {
    
    func loadingFinished() {
        self.setupUI()
        self.tableView.reloadData()
        self.indicator.stopAnimating()
        self.contentView.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.init(uptimeNanoseconds: 100)) {
            self.contentView.updateShadow()
        }
    }
    
    func failed(withError error: CustomError?) {
        self.indicator.stopAnimating()
        self.showAlert(title: "Error", message: error?.errorDescription ?? "Something went wrong. Please try again later.") { (alert, index) in
        }
    }
}

extension DashboardViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let presenter = self.presenter else { return 0 }
        return presenter.numberOfItemsIn(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter = self.presenter else { return UITableViewCell() }
        let card = presenter.getFoodItemAt(indexPath: indexPath)
        if card.cardType == .show {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ShowMoreTableViewCell.reuseIdentifier, for: indexPath) as? ShowMoreTableViewCell else { return UITableViewCell() }
            cell.configure(forCard: card)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FoodTableViewCell.reuseIdentifier, for: indexPath) as? FoodTableViewCell else { return UITableViewCell() }
            cell.configure(forCard: card)
            return cell
        }
    }
}

extension DashboardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let presenter = self.presenter else { return }
        let card = presenter.getFoodItemAt(indexPath: indexPath)
        if card.cardType == .show {
            presenter.isExpanded = !presenter.isExpanded
            tableView.reloadData()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.init(uptimeNanoseconds: 100)) {
                self.contentView.updateShadow()
            }
        } else {
            self.presenter?.didSelectFoodItem(at: indexPath)
        }
    }
}
