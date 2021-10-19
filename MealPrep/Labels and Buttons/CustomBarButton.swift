//
//  BookmarkButton.swift
//  MealPrep
//
//  Created by Rui Silva on 29/09/2021.
//

import UIKit

class CustomBarButton: UIButton {
    
    var isBookmarked: Bool = false

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
        self.buttonImage = buttonImage
        self.color = color
        
        configure()
    }
    
    func configure() {
        setImage(buttonImage, for: .normal)
        imageView?.tintColor = color
        translatesAutoresizingMaskIntoConstraints = false
    }

}
