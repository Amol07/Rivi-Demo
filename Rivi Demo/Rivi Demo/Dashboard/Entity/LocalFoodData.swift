//
//  LocalFoodData.swift
//  Rivi Demo
//
//  Created by Amol Prakash on 28/01/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

enum CardType: Int {
    case food
    case show
    case invalid
}

struct LocalFoodData: Decodable  {
    var headerDetails: CardHeaderDetail?
    var card: [Card]?
    
    private enum CodingKeys: String, CodingKey {
        case headerDetails = "card_details"
        case card
    }
}

struct CardHeaderDetail: Decodable {
    var title: String?
    var type: String?
    var city: String?
}

struct Card: Decodable {
    var title: String?
    var description: String?
    var cardImage: String?
    var cardNo: Int?
    var cardDetails: CardDetail?
    
    var cardType: CardType = .food
    
    init(cardType: CardType) {
        self.cardType = cardType
    }
    
    private enum CodingKeys: String, CodingKey {
        case title
        case description = "desc"
        case cardImage = "img"
        case cardNo = "card_no"
        case cardDetails = "details"
    }
}

struct CardDetail: Decodable {
    var about: [String]?
    var location: [Location]?
    var dishes: [String]?
    var images: [String]?
    
    private enum CodingKeys: String, CodingKey {
        case about
        case location = "where"
        case dishes
        case images
    }
}

struct Location: Decodable {
    var name: String?
    var distance: Float?
}
