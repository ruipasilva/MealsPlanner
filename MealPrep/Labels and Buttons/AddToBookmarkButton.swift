//
//  AddToBookmarkButton.swift
//  MealPrep
//
//  Created by Rui Silva on 23/09/2021.
//

import UIKit

class AddToBookmarkButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(background: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = background
        self.setTitle(title, for: .normal)
        configure()
    }
    
    func configure() {
        layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
