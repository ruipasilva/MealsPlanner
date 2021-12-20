//
//  SpecificRecipe.swift
//  MealPrep
//
//  Created by Rui Silva on 20/09/2021.
//

import Foundation

struct RecipeInfoResult: Codable {
    var recipe: RecipeInfo
}

struct RecipeInfo: Codable, Hashable {
    var uri: String?
    var label: String
    var image: String?
    var url: String?
    var ingredientLines: [String]?
    var cuisineType: [String]?
    var healthLabels: [String]?
}
