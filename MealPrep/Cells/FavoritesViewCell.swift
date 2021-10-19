//
//  FavoritesViewCell.swift
//  MealPrep
//
//  Created by Rui Silva on 08/09/2021.
//

import UIKit

class FavoritesViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageLabel: ExploreCellImageView!
    @IBOutlet weak var recipeView: UIView!
    
    func set(title: String) {
        titleLabel.text = title
    }

    
}
