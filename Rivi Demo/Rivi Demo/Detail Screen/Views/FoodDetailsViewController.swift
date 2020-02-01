//
//  FoodDetailsViewController.swift
//  Rivi Demo
//
//  Created by Amol Prakash on 29/01/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

class FoodDetailsViewController: UIViewController {
    @IBOutlet private weak var curatedLabel: UILabel!
    @IBOutlet private weak var headerLabel: UILabel!
    @IBOutlet private weak var coverImageView: UIImageView! {
        didSet {
            self.coverImageView.layer.borderColor = UIColor.clear.cgColor
            self.coverImageView.layer.cornerRadius = 5.0
        }
    }
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var tableView: UITableView!
    
    var presenter: FoodDetailsPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCells()
        self.setUpUI()
        self.presenter?.viewDidLoad()
    }
    
    private func registerCells() {
        self.tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        self.tableView.estimatedRowHeight = 420
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.register(cellType: FoodDetailsTableViewCell.self)
    }
    
    private func setUpUI() {
        self.curatedLabel.text = "CURATED FOR MAYANAK"
        self.headerLabel.text = self.presenter?.getHeaderText()
    }
}

extension FoodDetailsViewController: FoodDetailsViewProtocol {
    
    func reloadTableView(withIndicies indicies: [IndexPath]) {
        self.tableView.beginUpdates()
        self.tableView.reloadRows(at: indicies, with: .none)
        self.tableView.endUpdates()
    }
    
    func displayUI() {
        guard let presenter = self.presenter else { return }
        self.coverImageView.setImage(with: presenter.getSelectedCoverImageUrl(), placeHolder: UIImageView.placeHolderImage, completed: nil)
        self.pageControl.numberOfPages = presenter.numberOfPages()
        self.pageControl.currentPage = presenter.currentSelectedIndex
    }
}

extension FoodDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let presenter = self.presenter else { return 0 }
        return presenter.numberOfItemsIn(section: 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter = self.presenter else { return UITableViewCell() }
        let card = presenter.getFoodItemAt(indexPath: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FoodDetailsTableViewCell.reuseIdentifier, for: indexPath) as? FoodDetailsTableViewCell else { return FoodDetailsTableViewCell() }
        cell.configure(forCard: card)
        return cell
    }
}

extension FoodDetailsViewController: UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let presenter = self.presenter else { return }
        presenter.selectedCard(atIndex: indexPath)
    }
}

