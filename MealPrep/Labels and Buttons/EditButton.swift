//
//  EditButton.swift
//  MealPrep
//
//  Created by Rui Silva on 17/11/2021.
//

import UIKit

class EditButton: UIButton {

    var buttonImage: UIImage?
    var color: UIColor?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(buttonImage: UIImage, color: UIColor) {
        super.init(frame: .zero)
        self.buttonImage = buttonImage.withConfiguration(UIImage.SymbolConfiguration(textStyle: .title3))
        self.color = color
        configure()
    }
    
    func configure() {
        setImage(buttonImage, for: .normal)
        imageView?.tintColor = color
        translatesAutoresizingMaskIntoConstraints = false
    }

}
