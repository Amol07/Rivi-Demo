//
//  FoodViewModel.swift
//  Rivi Demo
//
//  Created by Amol Prakash on 31/01/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation
import UIKit

protocol FoodDataConfigurable {
    var foodHeaderDetails: FoodHeaderDetailsConfigurable? { get }
    var foodArray: [FoodConfigurable]? { get }
    init(model: LocalFoodData)
}

protocol FoodHeaderDetailsConfigurable {
    var title: String? { get }
    var type: String? { get }
    var city: String? { get }
}

protocol FoodConfigurable {
    var title: String? { get }
    var description: String? { get }
    var imageUrl: String? { get }
    var isExpanded: Bool { get set }
    var cardDetails: FoodDetailsConfigurable? { get set }
    var cardType: CardType { get set }
    init(model: Card)
}

protocol FoodDetailsConfigurable {
    var about: DetailsConfigurable? { get }
    var dishes: DetailsConfigurable? { get }
    var locaction: DetailsConfigurable? { get }
    var photos: PhotosConfigurable? { get }
    init(model: CardDetail, cardName: String)
}

protocol DetailsConfigurable {
    var title: String { get set }
    var description: NSAttributedString { get set }
    init(title: String, description: NSAttributedString)
}

protocol PhotosConfigurable {
    var title: String { get set }
    var photos: [String] { get set }
    init(title: String, photos: [String])
}

class FoodDataViewModel: FoodDataConfigurable {
    var foodHeaderDetails: FoodHeaderDetailsConfigurable?
    var foodArray: [FoodConfigurable]?
    
    required init(model: LocalFoodData) {
        if let foods = model.card, !foods.isEmpty {
            self.foodArray = [FoodConfigurable]()
            foods.forEach { food in
                self.foodArray?.append(FoodViewModel(model: food))
            }
        }
        if let headerDetails = model.headerDetails {
            self.foodHeaderDetails = FoodHeaderDetailsViewModel(model: headerDetails)
        }
    }
}

class FoodHeaderDetailsViewModel: FoodHeaderDetailsConfigurable {
    
    private var foodHeaderDetails: CardHeaderDetail
    init(model: CardHeaderDetail) {
        self.foodHeaderDetails = model
    }
    
    var title: String? {
        self.foodHeaderDetails.title
    }
    
    var type: String? {
        self.foodHeaderDetails.type
    }
    
    var city: String? {
        self.foodHeaderDetails.city
    }
}


class FoodViewModel: FoodConfigurable {

    var cardDetails: FoodDetailsConfigurable?
    private var card: Card
    private var _isExpanded: Bool
    
    var cardType: CardType
    required init(model: Card) {
        self.card = model
        self._isExpanded =  false
        self.cardType = card.cardType
        if let cardDetails = self.card.cardDetails, let title = model.title {
            self.cardDetails = FoodDetailsViewModel(model: cardDetails, cardName: title)
        }
    }
    
    var title: String? {
        self.card.title
    }
    
    var description: String? {
        self.card.description
    }
    
    var imageUrl: String? {
        self.card.cardImage
    }
    
    var isExpanded: Bool {
        set {
            self._isExpanded = newValue
        }
        get {
            self._isExpanded
        }
    }
}

class FoodDetailsViewModel: FoodDetailsConfigurable {
    
    private var _about: DetailsConfigurable?
    private var _dishes: DetailsConfigurable?
    private var _photos: PhotosConfigurable?
    private var _location: DetailsConfigurable?
    
    required init(model: CardDetail, cardName: String) {
        if let about = model.about, !about.isEmpty {
            self._about = TitleDescriptionViewModel(title: "ABOUT", description: NSAttributedString(string: about.joined(separator: "\n")))
        }
        if let dishes = model.dishes, !dishes.isEmpty {
            let attributedString = getAttributedString(fromStringList: dishes, font: UIFont.systemFont(ofSize: 10, weight: .regular), textColor: UIColor.RiviColor.detailDescriptionColor, bulletColor: UIColor.RiviColor.detailDescriptionColor)
            self._dishes = TitleDescriptionViewModel(title: "BEST \(cardName.uppercased()) DISHES", description: attributedString)
        }
        if let images = model.images, !images.isEmpty {
            self._photos = PhotosViewModel(title: "PHOTOS", photos: images)
        }
        if let locations = model.location, !locations.isEmpty {
            var stringList = [String]()
            locations.forEach { location in
                var locationStr = ""
                if let locName = location.name {
                    locationStr = locName
                    if let distance = location.distance {
                        locationStr = "\(locationStr) (\(distance) km away)"
                    } else {
                        locationStr = "\(locationStr) (distance unavailable)"
                    }
                }
                if !locationStr.isEmpty {
                    stringList.append(locationStr)
                }
            }
            if !stringList.isEmpty {
                let attributedString = getAttributedString(fromStringList: stringList, font: UIFont.systemFont(ofSize: 10, weight: .regular), textColor: UIColor.RiviColor.detailDescriptionColor, bulletColor: UIColor.RiviColor.detailDescriptionColor)
                self._location = TitleDescriptionViewModel(title: "WHERE TO EAT", description: attributedString)
            }
        }
    }
    
    var about: DetailsConfigurable? {
        self._about
    }
    
    var dishes: DetailsConfigurable? {
        self._dishes
    }
    
    var photos: PhotosConfigurable? {
        self._photos
    }
    
    var locaction: DetailsConfigurable? {
        self._location
    }
}

class TitleDescriptionViewModel: DetailsConfigurable {
    var title: String
    var description: NSAttributedString
    required init(title: String, description: NSAttributedString) {
        self.title = title
        self.description = description
    }
}

class PhotosViewModel: PhotosConfigurable {
    var title: String
    var photos: [String]
    
    required init(title: String, photos: [String]) {
        self.title = title
        self.photos = photos
    }
}
