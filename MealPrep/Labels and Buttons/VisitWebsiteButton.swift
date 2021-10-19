//
//  ViewRecipeButton.swift
//  MealPrep
//
//  Created by Rui Silva on 04/10/2021.
//

import UIKit

class VisitWebsiteButton: UIButton {
    
    var url: String?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        setTitle("Instructions", for: .normal)
        backgroundColor = .systemIndigo
        layer.cornerRadius = 10
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        translatesAutoresizingMaskIntoConstraints = false
        
        
    }
}
