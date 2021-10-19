//
//  ErrorMessages.swift
//  MealPrep
//
//  Created by Rui Silva on 15/09/2021.
//

import Foundation

enum ErrorMessage: String, Error {
    case invalidData = "Something went wrong, Please try again"
    case invalidResponse = "Server Error. Please check your spelling and again later"
    case unableToFavorite = "Couldn't save this recipe. Please try again"
    case alreadyBookmarked = "This recipe has been bookmark already"
    case generalError = "Something went wrong. Please try again"
    case invalidURL = "The url is invalid"
}
