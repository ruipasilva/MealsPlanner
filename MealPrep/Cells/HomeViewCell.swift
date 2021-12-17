//
//  HomeViewCell.swift
//  MealPrep
//
//  Created by Rui Silva on 06/09/2021.
//

import UIKit


class HomeViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    

    func set(title: String) {
        label.text = title
    }
}
