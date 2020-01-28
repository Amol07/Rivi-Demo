//
//  LocalFoodData.swift
//  Rivi Demo
//
//  Created by Amol Prakash on 28/01/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

class LocalFoodData: Decodable  {
    var headerDetails: CardHeaderDetail?
    var card: [Card]?
}

class CardHeaderDetail: Decodable {
    var title: String?
    var type: String?
    var city: String?
}

class Card: Decodable {
    var title: String?
    var description: String?
    var cardImage: String?
    var cardNo: Int?
    var cardDetails: CardDetail?
}

class CardDetail: Decodable {
    var about: [String]?
    var location: [Location]?
    var dishes: [String]?
    var images: [String]?
}

class Location: Decodable {
    var name: String?
    var distance: Float?
}
