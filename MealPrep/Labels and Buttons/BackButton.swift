//
//  BackButton.swift
//  MealPrep
//
//  Created by Rui Silva on 29/09/2021.
//

import UIKit

class BackButton: UIButton {
    
    let backButtonImage: UIImage = UIImage(systemName: "chevron.backward")!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        setImage(backButtonImage, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
