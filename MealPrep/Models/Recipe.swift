//
//  Recipe.swift
//  MealPrep
//
//  Created by Rui Silva on 04/09/2021.
//

import UIKit

struct Results: Codable {
    var hits: [Hits]
}

struct Hits: Codable {
    var recipe: Recipe 
}

struct Recipe: Codable, Hashable {
    var uri: String?
    var label: String?
    var image: String?
    var cuisineType: [String]?
}

