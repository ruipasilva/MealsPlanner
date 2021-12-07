//
//  Fonts.swift
//  MealPrep
//
//  Created by Rui Silva on 24/11/2021.
//

import UIKit

enum CustomFontType: String {
    case KollektifBold = "Kollektif-Bold"
    case KollektifBoldItalic = "Kollektif-BoldItalic"
    case KollektifItalic = "Kollektif-Italic"
    case Kollektif = "Kollektif"
}

struct Fonts {
    static func font(customFontType: CustomFontType, size: CGFloat) -> UIFont {
        return UIFont(name: customFontType.rawValue, size: size) ?? .systemFont(ofSize: size)
    }
    
    static func font(size: CGFloat, weight: UIFont.Weight) -> UIFont {
        UIFont.systemFont(ofSize: size, weight: weight)
    }
}
