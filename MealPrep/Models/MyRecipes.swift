//
//  MyRecipes.swift
//  MealPrep
//
//  Created by Rui Silva on 26/09/2021.
//

import Foundation
import UIKit

struct MyRecipe: Codable {
    
    var label: String
    var ingredients: String
    var instructions: String
    
    init(label: String, ingredients: String, instructions: String) {
        self.label = label
        self.ingredients = ingredients
        self.instructions = instructions
    }
}
